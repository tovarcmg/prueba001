//
//  PrincipalPresentationLogic.swift
//  prueba001
//
//  Created by tovarchavez on 17/08/25.
//

import Foundation

protocol PrincipalPresentationLogic {
    func presentPrincipalResult(response: [Rutas])
    func presentError(response: String)
}

class PrincipalPresenter: PrincipalPresentationLogic {
    weak var viewController: PrincipalDisplayLogic?

    func presentPrincipalResult(response: [Rutas]) {
         
        viewController?.displayRutas(response: response)
    }

    func presentError(response: String) {
        let viewModel = Principal.Authenticate.ViewModel(
            displayMessage: "usuario o contrasena no valida"
        )
        
    }
}
