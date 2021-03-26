package com.vinid.paysdk;

import android.app.Activity;
import android.content.Intent;
import android.os.Bundle;

import com.vinid.paysdk.utils.VinIDPayConstants;

import org.apache.cordova.CallbackContext;
import org.apache.cordova.CordovaPlugin;
import org.apache.cordova.PluginResult;
import org.json.JSONArray;

public class Checkout extends CordovaPlugin {
    private final static int PAYMENT_REQUEST_CODE = 111;
    private final static String PLUGIN_ACTION = "checkout";

    private CallbackContext callbackContext;

    @Override
    public boolean execute(String action, JSONArray args,
                           final CallbackContext callbackContext) {
        if (!action.equals(PLUGIN_ACTION)) {
            callbackContext.error("\"" + action + "\" is not a recognized action.");
            return false;
        }
        this.callbackContext = callbackContext;
        return openCheckout(args, callbackContext);
    }

    public boolean openCheckout(JSONArray args, final CallbackContext callbackContext) {
        try {
            String orderId = args.getString(0);
            String signature = args.getString(1);
            VinIDPayParams param = new VinIDPayParams.Builder()
                    .setOrderId(orderId)
                    .setSignature(signature)
                    .build();
            VinIDPaySdk sdk = new VinIDPaySdk.Builder()
                    .setVinIDPayParams(param)
                    .build();
            cordova.setActivityResultCallback(this);
            cordova.getActivity().startActivityForResult(sdk.toIntent(), PAYMENT_REQUEST_CODE);
        } catch (Exception e) {
            callbackContext.error("Can not parse options " + args + " " + e.getMessage());
        }

        return true;
    }

    public void onRestoreStateForActivityResult(Bundle state, CallbackContext callbackContext) {
        this.callbackContext = callbackContext;
    }

    @Override
    public void onActivityResult(int requestCode, int resultCode, Intent intent) {
        super.onActivityResult(requestCode, resultCode, intent);
        if (requestCode == PAYMENT_REQUEST_CODE) {
            if (resultCode == Activity.RESULT_OK) {
                String transactionStatus = intent.getStringExtra(VinIDPayConstants.EXTRA_RETURN_TRANSACTION_STATUS);
                if (transactionStatus != null) {
                    switch (transactionStatus) {
                        case VinIDPayConstants.TRANSACTION_SUCCESS:
                            callbackContext.sendPluginResult(new PluginResult(PluginResult.Status.OK));
                            break;
                        case VinIDPayConstants.TRANSACTION_ABORT:
                        case VinIDPayConstants.TRANSACTION_FAIL:
                            callbackContext.sendPluginResult(new PluginResult(PluginResult.Status.ERROR));
                            break;
                    }
                }
            }
        }

    }
}