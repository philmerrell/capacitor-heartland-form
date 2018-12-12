import Foundation
import Capacitor

struct TokenSuccess {
    var token: String
    var expMonth: String
    var expYear: String
    var postalCode: String
}

protocol PaymentTokenDelegate {
    func paymentTokenSuccess(_ result:TokenSuccess)
}

/**
 * Please read the Capacitor iOS Plugin Development Guide
 * here: https://capacitor.ionicframework.com/docs/plugins/ios
 */
@objc(HeartlandForm)
public class HeartlandForm: CAPPlugin, PaymentTokenDelegate {
    
    var call: CAPPluginCall!

    @objc func open(_ call: CAPPluginCall) {
        let publicKey = call.getString("heartlandPublicKey")
        if publicKey != nil {
            let podBundle = Bundle(for: HeartlandForm.self)
            let bundleUrl = podBundle.url(forResource: "CapacitorHeartlandForm", withExtension: "bundle")
            let bundle = Bundle(url: bundleUrl!)!
            let storyboard = UIStoryboard(name: "UIHeartlandForm", bundle: bundle)
            let controller = storyboard.instantiateViewController(withIdentifier: "HeartlandViewController") as! HeartlandViewController
            
            controller.delegate = self
            controller.publicKey = publicKey
            
            DispatchQueue.main.async {
                self.bridge.viewController.present(controller, animated: true, completion: nil)
            }
         } else {
             call.error("You must pass a Heartland public key")
             self.bridge.modulePrint(self, "A Heartland public key was not passed")
//            call.reject(error.localizedDescription, error, [
//                "item1": true
//            ])
            return
         }
    }
    
    func paymentTokenSuccess(_ result: TokenSuccess) {
        call.resolve([
            "added": true
        ])
    }
    
}
