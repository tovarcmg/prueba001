//
//  LoginPresentationLogic.swift
//  prueba001
//
//  Created by tovarchavez on 17/08/25.
//


import Foundation

protocol LoginPresentationLogic {
    func presentLoginResult(response: Login.Authenticate.Response)
}

class LoginPresenter: LoginPresentationLogic {
    weak var viewController: LoginDisplayLogic?

    func presentLoginResult(response: Login.Authenticate.Response) {
        let viewModel = Login.Authenticate.ViewModel(displayMessage: response.message)
        viewController?.displayLoginResult(viewModel: viewModel)
    }
}
