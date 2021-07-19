//
//  RouterProtocol.swift
//  FirabaseAppMVP
//
//  Created by Vladyslav Prosianyk on 15.07.2021.
//

import UIKit
import Firebase

protocol RouterMain {
    var navigationController: UINavigationController? { get set }
    var assemblyBuilder: AssemblyBuilderProtocol? { get set }
}

protocol RouterProtocol: RouterMain {
    func initialViewController()
    func openVerifyCodePage(authID: String)
    func openProfileEditorPage(userData: AuthDataResult?)
    func openHomePage()
    func popToRoot()
}

class Router: RouterProtocol {
    
    var navigationController: UINavigationController?
    var assemblyBuilder: AssemblyBuilderProtocol?
    
    
    
    init(navigationController: UINavigationController, assemblyBuilder: AssemblyBuilderProtocol) {
        self.assemblyBuilder = assemblyBuilder
        self.navigationController = navigationController
    }
    
    func initialViewController() {
        let userID = UserDefaults.standard.string(forKey: "userID")
        
        if let navigationController = navigationController { 
            if userID == nil {
                guard let mainVC = assemblyBuilder?.createVerifyPhoneModule(router: self) else { return }
                navigationController.viewControllers = [mainVC]
            } else {
                guard let homeVC = assemblyBuilder?.createHomePage(router: self, id: userID!) else { return }
                navigationController.viewControllers = [homeVC]
            }
        }
    }
    
    func openVerifyCodePage(authID: String) {
        if let navigationController = navigationController {
            guard let verifyCodeVC = assemblyBuilder?.createVerifyCodeModule(router: self, authID: authID) else { return }
            navigationController.pushViewController(verifyCodeVC, animated: true)
        }
    }
    
    func openProfileEditorPage(userData: AuthDataResult?) {
        if let navigationController = navigationController {
            guard let profileEditorVC = assemblyBuilder?.createProfileEditorModule(router: self, userData: userData) else { return }
            navigationController.pushViewController(profileEditorVC, animated: true)
        }
    }
    
    func openHomePage() {
        
        let userID = UserDefaults.standard.string(forKey: "userID")
        
        if let navigationController = navigationController {
            if userID != nil{
                guard let homeVC = assemblyBuilder?.createHomePage(router: self, id: userID!) else { return }
                navigationController.viewControllers = [homeVC]
                popToRoot()
            }
        }
    }
    
    func popToRoot() {
        if let navigationController = navigationController {
            navigationController.popToRootViewController(animated: true)
        }
    }
    
    
    
}
