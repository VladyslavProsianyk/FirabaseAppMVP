//
//  PhoneVerifyViewPresenter.swift
//  FirabaseAppMVP
//
//  Created by Vladyslav Prosianyk on 12.07.2021.
//

import UIKit

protocol VerifyPhoneViewProtocol: AnyObject {
    func onSeccesVerify(varificationID: String)
    func onFailureVerify(error: Error)
}

protocol PhoneVerifyViewPresenterProtocol: AnyObject {
    init(view: VerifyPhoneViewProtocol, authLayer: AuthLayerProtocol, router: RouterProtocol)
    func verifyPhone(number: String)
    func openVerifyCodePage(varificationID: String)
}

class PhoneVerifyViewPresenter: PhoneVerifyViewPresenterProtocol {
    
    var authLayer: AuthLayerProtocol!
    weak var view: VerifyPhoneViewProtocol?
    var router: RouterProtocol?
    
    required init(view: VerifyPhoneViewProtocol, authLayer: AuthLayerProtocol, router: RouterProtocol) {
        self.authLayer = authLayer
        self.view = view
        self.router = router
    }
    
    func openVerifyCodePage(varificationID: String) {
        router?.openVerifyCodePage(authID: varificationID)
    }
    
    func verifyPhone(number: String) {
        authLayer.verifyPhoneNumber(number: number, complition: { [weak self] result in
            guard let weakSelf = self else { return }
            DispatchQueue.main.async {
                switch result {
                case .success(let id):
                    UserDefaults.standard.set(id, forKey: "varificationId")
                    weakSelf.view?.onSeccesVerify(varificationID: id)
                case .failure(let error):
                    weakSelf.view?.onFailureVerify(error: error)
                }
            }
        })
    }

    
    
}
