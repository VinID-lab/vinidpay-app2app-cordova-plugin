var exec = require('cordova/exec');

function CheckoutPlugin(){}

// Set URLScheme to return host app after checkout for iOS Only
CheckoutPlugin.prototype.setReturnURLScheme = function(scheme, successCallback, errorCallback) {
    exec(successCallback, errorCallback, 'Checkout', 'setReturnURLScheme', [scheme]);
}

CheckoutPlugin.prototype.setSandboxMode = function(isSandbox, successCallback, errorCallback) {
    exec(successCallback, errorCallback, 'Checkout', 'setSandboxMode', [isSandbox]);
}

CheckoutPlugin.prototype.checkout = function(orderId, signature, successCallback, errorCallback) {
    exec(successCallback, errorCallback, 'Checkout', 'checkout', [orderId, signature]);
}

CheckoutPlugin.install = function(){
    if(!window.plugins){
        window.plugins = {};
    }
    window.plugins.checkoutPlugin = new CheckoutPlugin();
    return window.plugins.checkoutPlugin;
}
cordova.addConstructor(CheckoutPlugin.install);