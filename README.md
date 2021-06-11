# Cordova Plugin for VinID Pay's app-to-app payment

## Installation

This Cordova Plugin adds support for the app-to-app payment on iOS and Android platforms. It uses the native VinIDPay Mobile SDK libraries, which you must also download. 


#### OutSystems
For OutSystems user, follow the [official guideline](https://success.outsystems.com/Documentation/11/Extensibility_and_Integration/Mobile_Plugins/Using_Cordova_Plugins) to integrate with the plugin. This is a sample JSON file for the **Extensibility Configuration** module property:

```JSON
{
    "plugin": {
        "url": "https://github.com/VinID-lab/vinidpay-app2app-cordova-plugin.git#0.0.3"
    }
}
```

## Methods
- window.plugins.checkoutPlugin.checkout
- window.plugins.checkoutPlugin.setSandboxMode
- window.plugins.checkoutPlugin.setReturnURLScheme

### CheckoutPlugin.checkout
Request a payment with an `orderId` and `signature`, return the status of the transaction (success/failed) with corresponding callback.


### CheckoutPlugin.setSandboxMode
Enable Sandbox Mode for testing. Default value is `false`, equavalent to PRODUCTION Mode.

### CheckoutPlugin.setReturnURLScheme
This function helps [Setup for app switch](https://github.com/VinID-lab/vinidpay-ios-sdk#setup-for-app-switch) for iOS platform. It has been setup properly by default, use it if you want to customize the scheme.

## Usage

Follow the native library guideline([iOS](https://github.com/VinID-lab/vinidpay-ios-sdk), [Android](https://github.com/VinID-lab/vinidpay-android-sdk/)) for more information about params and how it works.

Here is a sample code for making a checkout request and receiving response:
```JavaScript
  function onCheckoutPress(){
    var orderId = document.getElementById('orderId').value;
    var signature = document.getElementById('signature').value;
    window.plugins.checkoutPlugin.checkout(
       orderId,
       signature,
       function(data) {alert('Checkout successfull!');},
       function(err) { alert('Checkout errror ' + err);});
  }
```
