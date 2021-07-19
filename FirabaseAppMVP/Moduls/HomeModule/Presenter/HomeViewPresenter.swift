//
//  HpmeViewPresenter.swift
//  FirabaseAppMVP
//
//  Created by Vladyslav Prosianyk on 19.07.2021.
//

import UIKit
import WebKit
import Firebase

protocol HomeViewProtocol: AnyObject {
    func success(user: User?)
    func failure(error: Error)
}

protocol HomeViewPresenterProtocol: AnyObject {
    init(userLayer: UserLayerProtocol?, router: RouterProtocol, view: HomeViewProtocol)
    func loadUser(id: String)
    func loggOut()
}

class HomeViewPresenter: HomeViewPresenterProtocol {
    
    weak var view: HomeViewProtocol?
    var userLayer: UserLayerProtocol?
    var router: RouterProtocol?
    
    required init(userLayer: UserLayerProtocol?, router: RouterProtocol, view: HomeViewProtocol) {
        self.userLayer = userLayer
        self.router = router
        self.view = view
    }

    func loadUser(id: String) {
        userLayer?.getUserFromFirabase(id: id, comlition: { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let user):
                    self.view?.success(user: user)
                case .failure(let error):
                    self.view?.failure(error: error)
                }
            }
        })
    }
    
    func loggOut() {
        
        UserDefaults.standard.removeObject(forKey: "userID")
        
        do {
            try Auth.auth().signOut()
            router?.initialViewController()
            router?.popToRoot()
        } catch {
            debugPrint(error.localizedDescription)
        }
    }
    
    
}
