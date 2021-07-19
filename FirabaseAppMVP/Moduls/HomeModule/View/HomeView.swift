//
//  HomeView.swift
//  FirabaseAppMVP
//
//  Created by Vladyslav Prosianyk on 19.07.2021.
//

import UIKit
import WebKit

class HomeView: UIViewController {
    
    @IBOutlet weak var imageWebView: WKWebView!
    @IBOutlet weak var lName: UILabel!
    @IBOutlet weak var lPhone: UILabel!
    @IBOutlet weak var lID: UILabel!
    
    @IBAction func loggOutBtnPressed(_ sender: UIButton) {
        presenter?.loggOut()
    }
    
    var alert: AlertProtocol?
    var presenter: HomeViewPresenterProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let userID = UserDefaults.standard.string(forKey: "userID") {
            presenter?.loadUser(id: userID)
        }
    }

}

extension HomeView: HomeViewProtocol {
    
    func success(user: User?) {
        if let url = URL(string: user?.photoURL ?? "") {
            let request = URLRequest(url: url)
            imageWebView.load(request)
        }
        lName.text = user?.name
        lID.text = user?.id
        lPhone.text = user?.phone
        
    }
    
    func failure(error: Error) {
        print(error.localizedDescription)
    }
    
    
}
