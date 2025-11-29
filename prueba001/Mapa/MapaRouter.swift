//
//  MapaRoutingLogic.swift
//  prueba001
//
//  Created by tovarchavez on 17/08/25.
//


import UIKit

@objc protocol MapaRoutingLogic {
    // Definir funciones de navegación aquí (ej. logout, ir a home, etc.)
    
}

protocol MapaDataPassing {
    var dataStore: MapaDataStore? { get }
}

class MapaRouter: NSObject, MapaRoutingLogic, MapaDataPassing {
    weak var viewController: MapaViewController?
    var dataStore: MapaDataStore?
    
     
}
