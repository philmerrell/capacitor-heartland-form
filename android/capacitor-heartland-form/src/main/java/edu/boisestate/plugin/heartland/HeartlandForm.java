package edu.boisestate.plugin.heartland;

import android.content.Intent;

import com.getcapacitor.JSObject;
import com.getcapacitor.NativePlugin;
import com.getcapacitor.Plugin;
import com.getcapacitor.PluginCall;
import com.getcapacitor.PluginMethod;


@NativePlugin()
public class HeartlandForm extends Plugin {

    @PluginMethod()
    public void open(PluginCall call) {
        String publicKey = call.getString("heartlandPublicKey");

        if (publicKey != null) {
            // presentHeartlandFormView();
        } else {
            call.error("You must pass a Heartland public key");
        }
    }

    // private void presentHeartlandFormView() {
    //     Intent intent = new Intent(Intent.ACTION_VIEW);
    //     getActivity().startActivity(intent);
    // }
}
