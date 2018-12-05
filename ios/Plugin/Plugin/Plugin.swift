import Foundation
import Capacitor
import Heartland_iOS_SDK

/**
 * Please read the Capacitor iOS Plugin Development Guide
 * here: https://capacitor.ionicframework.com/docs/plugins/ios
 */
@objc(HeartlandForm)
public class HeartlandForm: CAPPlugin {
    
    var tokenService: HpsTokenService!
    var call: CAPPluginCall!
    

    @objc func getHeartlandToken() {
        // TODO: Get card values
        tokenService.getTokenWithCardNumber("XXXXXXXXXXXXX",
            cvc: "123",
            expMonth: "12",
            expYear: "2016") { (_ tokenData) in
                //use token
                let tokenValue = tokenData?.tokenValue
                //Call method after execution to continue.
        }
    }

    
    @objc func echo(_ call: CAPPluginCall) {
        
    }

    @objc func open(_ call: CAPPluginCall) {
        // let publicKey = call.getString("heartlandPublicKey")
        // if publicKey != nil {
        //     tokenService = HpsTokenService(publicKey: publicKey)
        let podBundle = Bundle(for: HeartlandForm.self)
        let bundleUrl = podBundle.url(forResource: "CapacitorHeartlandForm", withExtension: "bundle")
        let bundle = Bundle(url: bundleUrl!)!
        let storyboard = UIStoryboard(name: "UIHeartlandForm", bundle: bundle)
        let controller = storyboard.instantiateInitialViewController()!
            DispatchQueue.main.async {
                self.bridge.viewController.present(controller, animated: true, completion: nil)
            }
        // } else {
        //     call.error("You must pass a Heartland public key")
        //     self.bridge.modulePrint(self, "A Heartland public key was not passed")
        //     return
        // }
    }
    
}
