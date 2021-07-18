//
//  VerifyCodeView.swift
//  FirabaseAppMVP
//
//  Created by Vladyslav Prosianyk on 14.07.2021.
//

import UIKit
import Firebase

class VerifyCodeView: UIViewController {
    
    @IBOutlet weak var tfCodeInput: UITextField!
    
    var presenter: VerifyCodePresenterProtocol!
    var alert: AlertProtocol!
    
    @IBAction func loggInBtnTapped(_ sender: UIButton) {
        presenter?.verify(code: tfCodeInput.text ?? "")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

}

extension VerifyCodeView: VerifyCodeViewProtocol {

    func onSeccesVerify(userData: AuthDataResult?) {
        UserDefaults.standard.set(userData?.user.uid, forKey: "userID")
        presenter.setUserInfo(user: userData)
    }
    
    func onFailedVerify(error: Error) {
        self.present(alert.createAuthAlert(with: error.localizedDescription), animated: true)
    }
    
    
}
