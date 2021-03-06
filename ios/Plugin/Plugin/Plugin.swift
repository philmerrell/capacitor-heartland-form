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
    var heartlandViewController: HeartlandViewController?

    @objc func open(_ call: CAPPluginCall) {
        self.call = call;
        let publicKey = call.getString("heartlandPublicKey")
        if publicKey != nil {
            createHeartlandViewController(publicKey!)
         } else {
            call.error("You must pass a Heartland public key")
            self.bridge.modulePrint(self, "A Heartland public key was not passed")
            return
         }
    }
    
    func createHeartlandViewController(_ publicKey:String) {
        let podBundle = Bundle(for: HeartlandForm.self)
        let bundleUrl = podBundle.url(forResource: "CapacitorHeartlandForm", withExtension: "bundle")
        let bundle = Bundle(url: bundleUrl!)!
        let storyboard = UIStoryboard(name: "UIHeartlandForm", bundle: bundle)
        heartlandViewController = storyboard.instantiateViewController(withIdentifier: "HeartlandViewController") as! HeartlandViewController
        
        heartlandViewController?.delegate = self
        heartlandViewController?.publicKey = publicKey
        
        DispatchQueue.main.async {
            self.bridge.viewController.present(self.heartlandViewController!, animated: true, completion: nil)
        }
    }
    
    func paymentTokenSuccess(_ result: TokenSuccess) {
        self.call.resolve([
            "token"     : result.token,
            "expMonth"  : result.expMonth,
            "expYear"   : result.expYear,
            "postalCode": result.postalCode
        ])
        
        DispatchQueue.main.async {
            self.heartlandViewController?.dismiss(animated: true, completion: nil)
        }
    }
    
}
