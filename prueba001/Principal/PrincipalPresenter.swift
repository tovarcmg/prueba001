//
//  PrincipalPresentationLogic.swift
//  prueba001
//
//  Created by tovarchavez on 17/08/25.
//

import Foundation

protocol PrincipalPresentationLogic {
    func presentPrincipalResult(response: Principal.Authenticate.Response)
    func presentError(response: String)
}

class PrincipalPresenter: PrincipalPresentationLogic {
    weak var viewController: PrincipalDisplayLogic?

    func presentPrincipalResult(response: Principal.Authenticate.Response) {
        let viewModel = Principal.Authenticate.ViewModel(
            displayMessage: response.message
        )
        viewController?.displayPrincipalResult(viewModel: viewModel)
    }

    func presentError(response: String) {
        let viewModel = Principal.Authenticate.ViewModel(
            displayMessage: "usuario o contrasena no valida"
        )
        viewController?.displayPrincipalResult(viewModel: viewModel)
    }
}
