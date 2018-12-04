import Foundation
import Capacitor
import Stripe
import CreditCardForm
import Heartland_iOS_SDK

/**
 * Please read the Capacitor iOS Plugin Development Guide
 * here: https://capacitor.ionicframework.com/docs/plugins/ios
 */
@objc(HeartlandForm)
public class HeartlandForm: CAPPlugin {
    @IBOutlet weak var creditCardForm: CreditCardFormView!
    
    let paymentTextField = STPPaymentCardTextField()
    
    var tokenService: HpsTokenService?
    var call: CAPPluginCall?
    
    @objc override func viewDidLoad() {
        // Set up stripe textfield
        paymentTextField.delegate = self
        paymentTextField.frame = CGRect(x: 15, y: 199, width: self.view.frame.size.width - 30, height: 44)
        paymentTextField.translatesAutoresizingMaskIntoConstraints = false
        paymentTextField.borderWidth = 0
        
        let border = CALayer()
        let width = CGFloat(1.0)
        border.borderColor = UIColor.darkGray.cgColor
        border.frame = CGRect(x: 0, y: paymentTextField.frame.size.height - width, width:  paymentTextField.frame.size.width, height: paymentTextField.frame.size.height)
        border.borderWidth = width
        paymentTextField.layer.addSublayer(border)
        paymentTextField.layer.masksToBounds = true
        
        view.addSubview(paymentTextField)
        
        NSLayoutConstraint.activate([
            paymentTextField.topAnchor.constraint(equalTo: creditCardForm.bottomAnchor, constant: 20),
            paymentTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            paymentTextField.widthAnchor.constraint(equalToConstant: self.view.frame.size.width-20),
            paymentTextField.heightAnchor.constraint(equalToConstant: 44)
        ])
    }

    @objc func getHeartlandToken() {
        // TODO: Get card values
        tokenService.getTokenWithCardNumber("XXXXXXXXXXXXX",
            cvc: "123",
            expMonth: "12",
            expYear: "2016") { (tokenData) in
                //use token
                tokenData.tokenValue
                //Call method after execution to continue.
            }
    }

    
    @objc func echo(_ call: CAPPluginCall) {
        let value = call.getString("value") ?? ""
        call.success([
            "value": value
        ])
    }

    @objc func open(_ call: CAPPluginCall) {
        guard publicKey = call.getString("heartlandPublicKey") as? String else {
            call.error("You must pass a Heartland public key")
            self.bridge.modulePrint(self, "A Heartland public key was not passed")
            return
        }
        tokenService = HpsTokenService(publicKey: publicKey)
    }
    
    @objc func paymentCardTextFieldDidChange(_ textField: STPPaymentCardTextField) {
        creditCardForm.paymentCardTextFieldDidChange(cardNumber: textField.cardNumber, expirationYear: textField.expirationYear, expirationMonth: textField.expirationMonth, cvc: textField.cvc)
    }

    @objc func paymentCardTextFieldDidEndEditingExpiration(_ textField: STPPaymentCardTextField) {
        creditCardForm.paymentCardTextFieldDidEndEditingExpiration(expirationYear: textField.expirationYear)
    }

    @objc func paymentCardTextFieldDidBeginEditingCVC(_ textField: STPPaymentCardTextField) {
        creditCardForm.paymentCardTextFieldDidBeginEditingCVC()
    }

    @objc func paymentCardTextFieldDidEndEditingCVC(_ textField: STPPaymentCardTextField) {
        creditCardForm.paymentCardTextFieldDidEndEditingCVC()
    }
}
