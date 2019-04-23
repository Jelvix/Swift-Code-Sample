//
//  LogInViewController.swift
//
//  Copyright © 2017 Jelvix. All rights reserved.
//

import UIKit
import FBSDKLoginKit

class LogInViewController: UIViewController {
    
    //MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    //MARK: Actions
    @IBAction func didTapLoginButton(_ sender: UIButton) {
        authWithFacebook()
    }
}

//MARK: Private
private extension LogInViewController {
    func showRecomendationsViewController() {
        DispatchQueue.main.async {
            let vc = StoryboardHelper.main.storyboard.instantiateViewController(withIdentifier: "RecNavigationViewController")
            self.present(vc, animated: true, completion: nil)
        }
    }
}

//MARK: API part
private extension LogInViewController {
    func authWithFacebook() {
        let fbLoginManager : FBSDKLoginManager = FBSDKLoginManager()
        fbLoginManager.logIn(withReadPermissions: ["email"], from: self) { [weak self] result, error in
            guard let self = self else { return }
            if (error == nil) {
                if let permission = result?.grantedPermissions, permission.contains("email") {
                    let loginRequest = LoginRequest(facebookID: result?.token.userID, facebookToken: result?.token.tokenString)
                    self.login(request: loginRequest)
                }
            } else {
                let alert = AlertMessage(title: "Oops!", message: error?.localizedDescription)
                AlertHelper.showMessage(message: alert, controller: self)
            }
        }
    }
    
    func login(request: LoginRequest) {
        UserService.loginUser(loginRequest: request, success: { [weak self] in
            self?.showRecomendationsViewController()
        }) { [weak self] error in
            AlertHelper.showMessage(message: error, controller: self)
        }
    }
}
