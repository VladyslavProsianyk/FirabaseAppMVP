//
//  VerifyPhoneView.swift
//  FirabaseAppMVP
//
//  Created by Vladyslav Prosianyk on 13.07.2021.
//

import UIKit

class VerifyPhoneView: UIViewController {

    @IBOutlet weak var tfPhoneNumber: UITextField!
    
    var presenter: PhoneVerifyViewPresenterProtocol!
    var alert: AlertProtocol!
    var varificationID: String?
    
    @IBAction func nextBtnTapped(_ sender: UIButton) {
        presenter.verifyPhone(number: tfPhoneNumber.text ?? "0")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

}

extension VerifyPhoneView: VerifyPhoneViewProtocol {
    
    func onSeccesVerify(varificationID: String) {
        presenter.openVerifyCodePage(varificationID: varificationID)
    }
    
    func onFailureVerify(error: Error) {
        self.present(alert.createAuthAlert(with: error.localizedDescription), animated: true)
    }
   
}
