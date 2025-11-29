//
//  LoginPresentationLogic.swift
//  prueba001
//
//  Created by tovarchavez on 17/08/25.
//

import Foundation

protocol LoginPresentationLogic {
    func presentLoginResult(response: Login.Authenticate.Response)
    func presentError(response: String)
}

class LoginPresenter: LoginPresentationLogic {
    weak var viewController: LoginDisplayLogic?

    func presentLoginResult(response: Login.Authenticate.Response) {
        let viewModel = Login.Authenticate.ViewModel(
            displayMessage: "like",
        )
        
        
            
        viewController?.displayLoginResult(viewModel: viewModel)
    }

    func presentError(response: String) {
        let viewModel = Login.Authenticate.ViewModel(
            displayMessage: "usuario o contrasena no valida"
        )
        viewController?.displayLoginResult(viewModel: viewModel)
    }
}
