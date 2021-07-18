//
//  ProfileEditorView.swift
//  FirabaseAppMVP
//
//  Created by Vladyslav Prosianyk on 15.07.2021.
//

import UIKit

class ProfileEditorView: UIViewController {
    
    @IBOutlet weak var userPhoto: UIImageView!
    @IBOutlet weak var tfUserName: UITextField!
    @IBOutlet weak var btnSaveProfile: UIButton!
    
    var presenter: ProfileEditorPresenterProtocol?
    var alert: AlertProtocol?
    
    @IBAction func imagePickerTapped(_ sender: UIButton) {
        openImagePicker()
    }
    
    @IBAction func saveProfileTapped(_ sender: UIButton) {
        presenter?.saveUserTapped(image: (userPhoto.image ?? UIImage(named: "avatar_selector")!), userName: tfUserName.text!)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        btnSaveProfile.isEnabled = false
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tap)
        
        tfUserName.addTarget(self, action: #selector(textFieldDidChange(textField:)), for: .editingChanged)
    }
    
}

extension ProfileEditorView {
    
    @objc func dismissKeyboard() {
        tfUserName.endEditing(true)
    }
    
    @objc func textFieldDidChange(textField: UITextField) {
        if !tfUserName.text!.isEmpty {
            btnSaveProfile.isEnabled = true
        } else {
            btnSaveProfile.isEnabled = false
        }
    }
}

extension ProfileEditorView: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func openImagePicker() {
        let imagePicker = UIImagePickerController()
        imagePicker.allowsEditing = true
        imagePicker.delegate = self
        self.present(imagePicker, animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let editedImage = info[.editedImage] as? UIImage {
            userPhoto.image = editedImage
        }
        
        dismiss(animated: true, completion: nil)
    }
}

extension ProfileEditorView: ProfileEditorViewProtocol {
    func saveOnSecces(documentID: String) {
        self.present((self.alert?.createMessageAlert(with: documentID))!, animated: true)
    }
    
    func saveOnFailure(error: Error) {
        self.present((self.alert?.createMessageAlert(with: error.localizedDescription))!, animated: true)
    }
    
    
}
