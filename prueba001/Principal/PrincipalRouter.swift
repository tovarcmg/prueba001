//
//  PrincipalRoutingLogic.swift
//  prueba001
//
//  Created by tovarchavez on 17/08/25.
//


import UIKit

protocol PrincipalRoutingLogic {
    // Definir funciones de navegación aquí (ej. logout, ir a home, etc.)
    func navigateToMapa(destino: infoRuta)
}

protocol PrincipalDataPassing {
    var dataStore: PrincipalDataStore? { get }
}

class PrincipalRouter: NSObject, PrincipalRoutingLogic, PrincipalDataPassing {
    weak var viewController: PrincipalViewController?
    var dataStore: PrincipalDataStore?
    
    func navigateToMapa(destino: infoRuta) {
        let destination = MapaViewController(destino: destino)
        viewController?.navigationController?.pushViewController(destination, animated: true)
    }
}
