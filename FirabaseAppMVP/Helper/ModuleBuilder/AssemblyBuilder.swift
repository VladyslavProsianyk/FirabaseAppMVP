//
//  AssemblyBuilder.swift
//  FirabaseAppMVP
//
//  Created by Vladyslav Prosianyk on 14.07.2021.
//

import UIKit
import Firebase

protocol AssemblyBuilderProtocol {
    func createVerifyPhoneModule(router: RouterProtocol) -> UIViewController
    func createVerifyCodeModule(router: RouterProtocol, authID: String) -> UIViewController
    func createProfileEditorModule(router: RouterProtocol, userData: AuthDataResult?) -> UIViewController
}

class AssemblyBuilder: AssemblyBuilderProtocol {
    
    var userID = UserDefaults.standard.value(forKey: "userID") ?? ""
    
    func createVerifyPhoneModule(router: RouterProtocol) -> UIViewController {
        let view = VerifyPhoneView()
        let network = AuthLayer()
        let alertController = AlertController()
        let presenter = PhoneVerifyViewPresenter(view: view, authLayer: network, router: router)
        view.presenter = presenter
        view.alert = alertController
        return view
    }
    
    func createVerifyCodeModule(router: RouterProtocol, authID: String) -> UIViewController {
        let view = VerifyCodeView()
        let network = AuthLayer()
        let alertController = AlertController()
        let presenter = VerifyCodePresenter(view: view, authLayer: network, router: router, authID: authID)
        view.presenter = presenter
        view.alert = alertController
        return view
    }
    
    func createProfileEditorModule(router: RouterProtocol, userData: AuthDataResult?) -> UIViewController {
        let view = ProfileEditorView()
        let network = AuthLayer()
        let alertController = AlertController()
        let userLayer = UserLayer()
        let presenter = ProfileEditorPresenter(view: view, authLayer: network, router: router, userLayer: userLayer, phoneNumber: userData?.user.phoneNumber, userID: userData?.user.uid)
        view.presenter = presenter
        view.alert = alertController
        return view
    }
    
}
