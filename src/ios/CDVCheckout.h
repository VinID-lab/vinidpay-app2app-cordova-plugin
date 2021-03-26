//
//  CDVCheckout.h
//  CDVCheckout
//
//  Created by NGUYEN CHI CONG on 3/25/21.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import <VinIDPaySDK/VinIDPaySDK.h>
#import <Cordova/CDVPlugin.h>

NS_ASSUME_NONNULL_BEGIN

@interface CDVCheckout : CDVPlugin

- (void)setReturnURLScheme:(CDVInvokedUrlCommand*)command;
- (void)checkout:(CDVInvokedUrlCommand*)command;

@end

NS_ASSUME_NONNULL_END
