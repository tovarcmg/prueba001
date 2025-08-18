//
//  LoginRoutingLogic.swift
//  prueba001
//
//  Created by tovarchavez on 17/08/25.
//


import UIKit

@objc protocol LoginRoutingLogic {
    // Definir funciones de navegación aquí (ej. logout, ir a home, etc.)
}

protocol LoginDataPassing {
    var dataStore: LoginDataStore? { get }
}

class LoginRouter: NSObject, LoginRoutingLogic, LoginDataPassing {
    weak var viewController: LoginViewController?
    var dataStore: LoginDataStore?
}
