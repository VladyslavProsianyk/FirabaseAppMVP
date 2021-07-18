//
//  AlertController.swift
//  FirabaseAppMVP
//
//  Created by Vladyslav Prosianyk on 14.07.2021.
//

import UIKit

protocol AlertProtocol {
    func createAuthAlert(with message: String) -> UIAlertController
    func createMessageAlert(with message: String) -> UIAlertController
}

class AlertController: AlertProtocol {
    func createMessageAlert(with message: String) -> UIAlertController {
        let alert = UIAlertController(title: "Message:", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        return alert
    }
    
    
    func createAuthAlert(with message: String) -> UIAlertController {
        let alert = UIAlertController(title: "Auth failled!", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        return alert
    }
    
    
}
