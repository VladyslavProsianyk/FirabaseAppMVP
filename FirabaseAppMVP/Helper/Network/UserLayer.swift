//
//  SaveLayer.swift
//  FirabaseAppMVP
//
//  Created by Vladyslav Prosianyk on 16.07.2021.
//

import UIKit
import Firebase

protocol UserLayerProtocol {
    
    func saveToFirebase(user: User?, comlition: @escaping ((Result<String, Error>)->Void))
    func saveToDefaults(user: User?, comlition: @escaping ((Result<String, Error>)->Void))
    
    func getUserFromFirabase(id: String?, comlition: @escaping ((Result<String, Error>)->Void))
    func getUserFromDefaults(user: User?, comlition: @escaping ((Result<String, Error>)->Void))
    
}

class UserLayer: UserLayerProtocol {
    
    func saveToFirebase(user: User?, comlition: @escaping ((Result<String, Error>) -> Void)) {
        let db = Firestore.firestore()
        db.collection("users").document(user!.id).setData([
            "name": user?.name ?? "",
            "phone": user?.number ?? "",
            "id": user?.id ?? ""
        ]) { err in
            if let err = err {
                comlition(.failure(err))
            } else {
                comlition(.success("Success!"))
            }
        }
    }

    
    func saveToDefaults(user: User?, comlition: @escaping ((Result<String, Error>) -> Void)) {
        
    }
    
    func getUserFromFirabase(id: String?, comlition: @escaping ((Result<String, Error>) -> Void)) {
        
    }
    
    func getUserFromDefaults(user: User?, comlition: @escaping ((Result<String, Error>) -> Void)) {
        
    }
    
    
}

