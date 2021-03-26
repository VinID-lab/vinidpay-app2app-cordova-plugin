//
//  CDVCheckout.m
//  CDVCheckout
//
//  Created by NGUYEN CHI CONG on 3/25/21.
//

#import "CDVCheckout.h"

@implementation CDVCheckout

- (void)setReturnURLScheme:(CDVInvokedUrlCommand*)command {
    if ([command.arguments count] != 1) {
        CDVPluginResult* pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR];
        [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
        return;
    }
    
    NSString* schemeUrl = [command.arguments objectAtIndex:0];
    [[VinIDPay sharedInstance] setReturnURLScheme:schemeUrl];
    CDVPluginResult* pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:schemeUrl];
    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}

- (void)checkout:(CDVInvokedUrlCommand*)command {
    if ([command.arguments count] != 2) {
        CDVPluginResult* pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR];
        [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
        return;
    }
    
    if ([VinIDPay sharedInstance].returnURLScheme == nil) {
        NSString *bundleId = [[NSBundle mainBundle] bundleIdentifier];
        [[VinIDPay sharedInstance] setReturnURLScheme:bundleId];
    }
    
    NSString* orderId = [command.arguments objectAtIndex:0];
    NSString* signature = [command.arguments objectAtIndex:1];
    
    [[VinIDPay sharedInstance] payWithOrderId:orderId signature:signature extraData:nil completionHandler:^(NSString *transactionId, VinIDPayStatus status) {
        CDVPluginResult* pluginResult = nil;
        switch (status) {
            case VinIDPayStatusSuccess: {
                pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:transactionId];
                
            }
                break;
                
            default: {
                pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR];
            }
                break;
        }
        [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
    }];
}

- (void)handleOpenURL:(NSNotification*)notification {
    NSURL* url = [notification object];

    if ([url isKindOfClass:[NSURL class]]) {
        [[VinIDPay sharedInstance] handleReturnURL:url];
    }
}

- (void)handleOpenURLWithApplicationSourceAndAnnotation:(NSNotification *)notification {
    NSDictionary*  notificationData = [notification object];
    
    if ([notificationData isKindOfClass: NSDictionary.class]){
        
        NSURL* url = notificationData[@"url"];
        NSString* sourceApplication = notificationData[@"sourceApplication"];
        id annotation = notificationData[@"annotation"];
        
        if ([url isKindOfClass:NSURL.class] && [sourceApplication isKindOfClass:NSString.class] && annotation) {
            [[VinIDPay sharedInstance] handleReturnURL:url];
        }
    }
}

@end
