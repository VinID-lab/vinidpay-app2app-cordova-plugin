var exec = require('cordova/exec');

function CheckoutPlugin(){}

CheckoutPlugin.prototype.setReturnURLScheme = function(scheme, successCallback, errorCallback) {
    exec(successCallback, errorCallback, 'Checkout', 'setReturnURLScheme', [scheme]);
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