//
//  MapaBusinessLogic.swift
//  prueba001
//
//  Created by tovarchavez on 17/08/25.
//

import Foundation

protocol MapaBusinessLogic {
    
}

protocol MapaDataStore {
    // Para mantener datos entre escenas si es necesario
}

class MapaInteractor: MapaBusinessLogic, MapaDataStore {
    var presenter: MapaPresentationLogic?

    private lazy var worker: MapaWorkingLogic = MapaWorker()

    
}
