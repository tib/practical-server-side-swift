//
//  AccountView.swift
//  MyProjectClient
//
//  Created by Tibor Bödecs on 2020. 05. 20..
//

import Foundation
import UIKit
import AuthenticationServices
import UserNotifications

final class AccountView: UIViewController, ViewInterface {

    var presenter: AccountPresenterViewInterface!
    weak var siwaButton: ASAuthorizationAppleIDButton!
    weak var logoutButton: UIButton!

    override func loadView() {
        super.loadView()
        
        let siwaButton = ASAuthorizationAppleIDButton()
        siwaButton.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(siwaButton)
        self.siwaButton = siwaButton

        NSLayoutConstraint.activate([
            self.siwaButton.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 50.0),
            self.siwaButton.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -50.0),
            self.siwaButton.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -70.0),
            self.siwaButton.heightAnchor.constraint(equalToConstant: 50.0)
        ])
        //...
        let logoutButton = UIButton(type: .system)
        logoutButton.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(logoutButton)
        self.logoutButton = logoutButton

        NSLayoutConstraint.activate([
            self.logoutButton.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 50.0),
            self.logoutButton.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -50.0),
            self.logoutButton.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -70.0),
            self.logoutButton.heightAnchor.constraint(equalToConstant: 50.0)
        ])
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Account"
        self.view.backgroundColor = .systemBackground
        
        self.navigationItem.rightBarButtonItem = .init(barButtonSystemItem: .close, target: self, action: #selector(self.close))
        self.navigationItem.leftBarButtonItem = .init(barButtonSystemItem: .fastForward, target: self, action: #selector(self.notif))
            
        self.logoutButton.setTitle("Logout", for: .normal)
        self.logoutButton.addTarget(self, action: #selector(self.logout), for: .touchUpInside)
        self.siwaButton.addTarget(self, action: #selector(self.siwa), for: .touchUpInside)
        
        self.presenter.start()
    }
    
    @objc func close() {
        self.presenter.close()
    }

    @objc func logout() {
        self.presenter.logout()
    }
    
    @objc func notif() {
        let notif = UNUserNotificationCenter.current()
        notif.requestAuthorization(options: [.badge, .sound, .alert]) { granted, error in
            // check if granted or error happened
        }
    }

    @objc func siwa() {
        let provider = ASAuthorizationAppleIDProvider()
        let request = provider.createRequest()
        request.requestedScopes = [.fullName, .email]
        let authController = ASAuthorizationController(authorizationRequests: [request])
        authController.presentationContextProvider = self
        authController.delegate = self
        authController.performRequests()
    }
}

extension AccountView: AccountViewPresenterInterface {

    func displayLogin() {
        self.siwaButton.isHidden = false
        self.logoutButton.isHidden = true
    }

    func displayLogout() {
        self.siwaButton.isHidden = true
        self.logoutButton.isHidden = false
    }
}

extension AccountView: ASAuthorizationControllerPresentationContextProviding {
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        return self.view.window!
    }
}

extension AccountView: ASAuthorizationControllerDelegate {
    
    func authorizationController(controller: ASAuthorizationController,
                                 didCompleteWithAuthorization authorization: ASAuthorization) {
        guard
            let appleIDCredential = authorization.credential as? ASAuthorizationAppleIDCredential,
            let tokenData = appleIDCredential.identityToken,
            let token = String(bytes: tokenData, encoding: .utf8)
        else {
            return
        }
        self.presenter.signIn(token: token)
    }
    
    func authorizationController(controller: ASAuthorizationController,
                                 didCompleteWithError error: Error) {
        guard let error = error as? ASAuthorizationError else {
            return
        }
        switch error.code {
        case .canceled:
            print("Canceled")
        case .invalidResponse:
            print("Invalid respone")
        case .notHandled:
            print("Not handled")
        case .failed:
            print("Failed")
        case .unknown:
            print("Unknown")
        @unknown default:
            print("Default")
        }
    }
}
