//
//  PrincipalRoutingLogic.swift
//  prueba001
//
//  Created by tovarchavez on 17/08/25.
//


import UIKit

@objc protocol PrincipalRoutingLogic {
    // Definir funciones de navegación aquí (ej. logout, ir a home, etc.)
    func navigateToHome()
}

protocol PrincipalDataPassing {
    var dataStore: PrincipalDataStore? { get }
}

class PrincipalRouter: NSObject, PrincipalRoutingLogic, PrincipalDataPassing {
    weak var viewController: PrincipalViewController?
    var dataStore: PrincipalDataStore?
    
    func navigateToHome() {
        let destination = MapaViewController()
        viewController?.navigationController?.pushViewController(destination, animated: true)
    }
}
