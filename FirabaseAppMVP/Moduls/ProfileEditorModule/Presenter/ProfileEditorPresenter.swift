//
//  ProfileEditorPresenter.swift
//  FirabaseAppMVP
//
//  Created by Vladyslav Prosianyk on 15.07.2021.
//

import UIKit
import Firebase

protocol ProfileEditorViewProtocol: AnyObject {
    func saveOnSecces()
    func saveOnFailure(error: Error)
}

protocol ProfileEditorPresenterProtocol: AnyObject {
    init(view: ProfileEditorViewProtocol, authLayer: AuthLayerProtocol, router: RouterProtocol, userLayer: UserLayerProtocol, phoneNumber: String?, userID: String?)
    func saveUserTapped(image: UIImage, userName: String)
    func openHomePage()
}

class ProfileEditorPresenter: ProfileEditorPresenterProtocol {
    
    weak var view: ProfileEditorViewProtocol?
    var authLayer: AuthLayerProtocol?
    var router: RouterProtocol?
    var userLayer: UserLayerProtocol?
    
    var phoneNumber: String?
    var userID: String?
    
    required init(view: ProfileEditorViewProtocol, authLayer: AuthLayerProtocol, router: RouterProtocol, userLayer: UserLayerProtocol, phoneNumber: String?, userID: String?) {
        self.authLayer = authLayer
        self.router = router
        self.view = view
        self.phoneNumber = phoneNumber
        self.userID = userID
        self.userLayer = userLayer
    }
    
    func saveUserTapped(image: UIImage, userName: String) {
        
        userLayer?.savePhotoToFirStorage(image: image, id: userID!, comlition: { [self] result in
            switch result {
            case .success(let url):
                let user = User(name: userName, id: userID!, phone: phoneNumber!, photoURL: url)

                self.userLayer?.saveToFirebase(user: user, comlition: { result in
                    DispatchQueue.main.async {
                        switch result {
                        case .failure(let error):
                            self.view?.saveOnFailure(error: error)
                        case .success(_):
                            self.view?.saveOnSecces()
                        }
                    }

                })
            case .failure(let error):
                debugPrint(error.localizedDescription)
            }
        })
    }
    
    func openHomePage() {
        router?.openHomePage()
    }
    
    
}
