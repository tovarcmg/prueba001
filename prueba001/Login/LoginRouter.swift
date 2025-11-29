//
//  LoginRoutingLogic.swift
//  prueba001
//
//  Created by tovarchavez on 17/08/25.
//


import UIKit

@objc protocol LoginRoutingLogic {
    // Definir funciones de navegación aquí (ej. logout, ir a home, etc.)
    func navigateToHome()
}

protocol LoginDataPassing {
    var dataStore: LoginDataStore? { get }
}

class LoginRouter: NSObject, LoginRoutingLogic, LoginDataPassing {
    weak var viewController: LoginViewController?
    var dataStore: LoginDataStore?
    
    func navigateToHome() {
        let destination = PrincipalViewController()
        viewController?.navigationController?.pushViewController(destination, animated: true)
    }
}
