//
//  LoginBusinessLogic.swift
//  prueba001
//
//  Created by tovarchavez on 17/08/25.
//

import Foundation

protocol LoginBusinessLogic {
    func authenticate(request: Login.Authenticate.Request, mmm: ParentRequestBody)
}

protocol LoginDataStore {
    // Para mantener datos entre escenas si es necesario
}

class LoginInteractor: LoginBusinessLogic, LoginDataStore {
    var presenter: LoginPresentationLogic?

    private lazy var worker: LoginWorkingLogic = LoginWorker()

    func authenticate(request: Login.Authenticate.Request, mmm: ParentRequestBody) {

        worker.getUsers(using: mmm) { [weak self]
            
            result in
            guard let self = self else { return }

            switch result {
            case .success(let response):

                let xxx = Login.Authenticate.Response(
                    success: true,
                    message: response.nombre
                )
                self.presenter?.presentLoginResult(response: xxx)

            case .failure(let error):

                self.presenter?.presentError(
                    response: error.localizedDescription
                )
            }
        }
    }
}
