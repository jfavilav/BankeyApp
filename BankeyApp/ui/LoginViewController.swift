//
//  ViewController.swift
//  BankeyApp
//
//  Created by Jairo Avila on 25/02/22.
//

import UIKit

class LoginViewController: UIViewController {
    
    let loginView = LoginView()
    let signInButton = UIButton(type: .system)
    let errorMessageText = UILabel()
    
    var username: String? { return loginView.usernameTextField.text }
    var password: String? { return loginView.passwordTextField.text }
    
    var leadingEdgeOnScreen: CGFloat = 16
    var leadingEdgeOffScreen: CGFloat = -1000
    
    var titleLeadingAnchor: NSLayoutConstraint?
    var subtitleLeadingAnchor: NSLayoutConstraint?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        style()
        layout()
    }
}

extension LoginViewController {
    
    private func style() {
        
        loginView.translatesAutoresizingMaskIntoConstraints = false
        
        signInButton.translatesAutoresizingMaskIntoConstraints = false
        signInButton.configuration = .filled()
        signInButton.configuration?.imagePadding = 8
        signInButton.setTitle("Sign In", for: [])
        signInButton.addTarget(self, action: #selector(signInTapped), for: .primaryActionTriggered)
        
        errorMessageText.translatesAutoresizingMaskIntoConstraints = false
        errorMessageText.textAlignment = .center
        errorMessageText.textColor = .systemRed
        errorMessageText.numberOfLines = 0
        errorMessageText.isHidden = true
    }
    
    private func layout() {
        
        view.addSubview(loginView)
        view.addSubview(signInButton)
        view.addSubview(errorMessageText)
        
         
        NSLayoutConstraint.activate([
            loginView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loginView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            loginView.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 1),
            view.trailingAnchor.constraint(equalToSystemSpacingAfter: loginView.trailingAnchor, multiplier: 1),
        ])
        
        NSLayoutConstraint.activate([
            signInButton.topAnchor.constraint(equalToSystemSpacingBelow: loginView.bottomAnchor, multiplier: 2),
            signInButton.leadingAnchor.constraint(equalTo: loginView.leadingAnchor),
            signInButton.trailingAnchor.constraint(equalTo: loginView.trailingAnchor),
        ])
        
        NSLayoutConstraint.activate([
            errorMessageText.topAnchor.constraint(equalToSystemSpacingBelow: signInButton.bottomAnchor, multiplier: 2),
            errorMessageText.leadingAnchor.constraint(equalTo: loginView.leadingAnchor),
            errorMessageText.trailingAnchor.constraint(equalTo: loginView.trailingAnchor),
        ])
    }
}

// MARK: Actions
extension LoginViewController {
    @objc func signInTapped(sender: UIButton) {
        errorMessageText.isHidden = true
        
        guard let username = username, let password = password else {
            assertionFailure("Username / password should never nil")
            return
        }
        
        if username.isEmpty || password.isEmpty {
            configureView(withMessage: "Username / Password cannot be blank")
            return
        }
        
        if username == "Jairo" && password == "Welcome" {
            signInButton.configuration?.showsActivityIndicator = true
        } else {
            configureView(withMessage: "Incorrect username / password")
            return
        }
    }
    
    private func configureView(withMessage message: String) {
        errorMessageText.isHidden = false
        errorMessageText.text = message
    }
}
