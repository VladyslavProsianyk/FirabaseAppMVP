//
//  VerifyCodePresenter.swift
//  FirabaseAppMVP
//
//  Created by Vladyslav Prosianyk on 14.07.2021.
//

import UIKit
import Firebase

protocol VerifyCodeViewProtocol: AnyObject {
    func onSeccesVerify(userData: AuthDataResult?)
    func onFailedVerify(error: Error)
}

protocol VerifyCodePresenterProtocol: AnyObject {
    init(view: VerifyCodeViewProtocol, authLayer: AuthLayerProtocol, router: RouterProtocol, authID: String)
    func verify(code: String)
    func setUserInfo(user: AuthDataResult?)
}

class VerifyCodePresenter: VerifyCodePresenterProtocol {

    weak var view: VerifyCodeViewProtocol!
    var authLayer: AuthLayerProtocol?
    var router: RouterProtocol?
    var authID: String?
    
    required init(view: VerifyCodeViewProtocol, authLayer: AuthLayerProtocol, router: RouterProtocol, authID: String) {
        self.view = view
        self.authLayer = authLayer
        self.router = router
        self.authID = authID
    }
    
    func verify(code: String) {
        authLayer?.makeAuth(varificationCode: code, varificationID: authID!, complition: { [weak self] result in
            guard let `self` = self else { return }
            DispatchQueue.main.async {
                switch result {
                case .success(let data):
                    self.view.onSeccesVerify(userData: data!)
                case .failure(let error):
                    self.view.onFailedVerify(error: error)
                }
            }
        })
    }
    
    func setUserInfo(user: AuthDataResult?) {
        router?.openProfileEditorPage(userData: user)
    }
    
}
