//
//  AuthLayer.swift
//  FirabaseAppMVP
//
//  Created by Vladyslav Prosianyk on 13.07.2021.
//

import Foundation
import FirebaseAuth

protocol AuthLayerProtocol {
    func verifyPhoneNumber(number: String, complition: @escaping (Result<String, Error>) -> Void)
    func makeAuth(varificationCode: String,varificationID: String, complition: @escaping (Result<AuthDataResult?, Error>) -> Void)
}

class AuthLayer: AuthLayerProtocol {
    
    func verifyPhoneNumber(number: String, complition: @escaping (Result<String, Error>) -> Void) {
        
        Auth.auth().settings?.isAppVerificationDisabledForTesting = true

        PhoneAuthProvider.provider().verifyPhoneNumber(number, uiDelegate: nil) { varificationId, error in
            if error == nil {
                complition(.success(varificationId ?? ""))
            } else {
                complition(.failure(error!))
            }
        }
    }
    
    func makeAuth(varificationCode: String, varificationID: String, complition: @escaping (Result<AuthDataResult?, Error>) -> Void) {
        let varificationID = UserDefaults.standard.string(forKey: "varificationId") ?? ""
        let credential = PhoneAuthProvider.provider().credential(withVerificationID: varificationID, verificationCode: varificationCode)
        
        
        Auth.auth().signIn(with: credential) { (result, error) in
            
            if error != nil {
                complition(.failure(error!))
            } else {
                complition(.success(result))
            }
        }
    }
}

