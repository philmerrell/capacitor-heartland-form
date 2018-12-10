//
//  HeartlandViewController.swift
//  Plugin
//
//  Created by Phil Merrell on 12/4/18.
//  Copyright © 2018 Max Lynch. All rights reserved.
//

import Stripe
import UIKit

class HeartlandViewController: UIViewController, STPPaymentCardTextFieldDelegate {

    @IBOutlet weak var payButton: UIButton!
    
    var paymentTextField = DispatchQueue.main.sync {
        return STPPaymentCardTextField()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createTextField()
        payButton.isEnabled = false

    }
    
    func createTextField() {
        let frame1 = CGRect(x: 20, y: 150, width: self.view.frame.size.width - 40, height: 40)
        paymentTextField = STPPaymentCardTextField(frame: frame1)
        paymentTextField.center = view.center
        paymentTextField.postalCodeEntryEnabled = true;
        paymentTextField.delegate = self
        view.addSubview(paymentTextField)

    }
    

    @IBAction func closePaymentView(_ sender: UIBarButtonItem) {
        DispatchQueue.main.async {
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    @IBAction func payButtonTapped(_ sender: UIButton) {
        print("did change")
        if textField.isValid {
            payButton.isEnabled = true
        }
    }
    
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
