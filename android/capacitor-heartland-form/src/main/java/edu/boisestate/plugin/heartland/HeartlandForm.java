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
    public void echo(PluginCall call) {
        String value = call.getString("value");

        JSObject ret = new JSObject();
        ret.put("value", value);
        call.success(ret);
    }

    @PluginMethod()
    public void call(PluginCall call) {
        String publicKey = call.getString("heartlandPublicKey");

        //            We have a key... open the view
        if (publicKey != null) {
            presentHeartlandFormView();
        } else {
            call.error("You must pass a Heartland public key");
        }
    }

    public void presentHeartlandFormView() {
        Intent intent = new Intent(Intent.ACTION_VIEW);
        getActivity().startActivity(intent);
    }
}