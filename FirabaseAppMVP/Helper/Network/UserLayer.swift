//
//  SaveLayer.swift
//  FirabaseAppMVP
//
//  Created by Vladyslav Prosianyk on 16.07.2021.
//

import UIKit
import Firebase
import FirebaseFirestore
import FirebaseStorage

protocol UserLayerProtocol {
    func savePhotoToFirStorage(image: UIImage, id: String, comlition: @escaping ((Result<String, Error>)->Void))
    func saveToFirebase(user: User?, comlition: @escaping ((Result<String, Error>)->Void))
    func getUserFromFirabase(id: String, comlition: @escaping ((Result<User?, Error>)->Void))
}

class UserLayer: UserLayerProtocol {
    
    private let db = Firestore.firestore()
    private let storage = Storage.storage().reference()
    
    func savePhotoToFirStorage(image: UIImage, id: String, comlition: @escaping ((Result<String, Error>)->Void)) {

        guard let imageData = image.pngData() else {
            debugPrint("image not possible convert to data")
            return
        }
        
        self.storage.child("/usersPhoto/\(id).png").putData(imageData, metadata: nil) { _, error in
            guard error == nil else { debugPrint(error!.localizedDescription); comlition(.failure(error!)); return }
            self.storage.child("/usersPhoto/\(id).png").downloadURL { photoURL, error in
                guard error == nil else { debugPrint(error!.localizedDescription); comlition(.failure(error!)); return }
                comlition(.success(photoURL!.absoluteString))
            }
        }
        

    }
    
    func saveToFirebase(user: User?, comlition: @escaping ((Result<String, Error>) -> Void)) {
        
        db.collection("users").document(user!.id).setData([
            "name": user?.name ?? "",
            "phone": user?.phone ?? "",
            "id": user?.id ?? "",
            "photoURL": user?.photoURL ?? ""
        ]) { err in
            if let err = err {
                comlition(.failure(err))
            } else {
                comlition(.success("success"))
            }
        }
    }

    func getUserFromFirabase(id: String, comlition: @escaping ((Result<User?, Error>) -> Void)) {
        let docRef = db.collection("users").document(id)
        docRef.getDocument { document, error in
            guard error == nil else { comlition(.failure(error!)); return }
            
            if let document = document, document.exists {
                let data = document.data()
                let name = data?["name"] as! String
                let phone = data?["phone"] as! String
                let id = data?["id"] as! String
                let photoURL = data?["photoURL"] as! String
                
                let user = User(name: name, id: id, phone: phone, photoURL: photoURL)
                
                comlition(.success(user))
            }
        }
    }

    
}

