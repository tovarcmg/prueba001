//
//  PrincipalBusinessLogic.swift
//  prueba001
//
//  Created by tovarchavez on 17/08/25.
//

import Foundation

protocol PrincipalBusinessLogic {
    func authenticate(request: Principal.Authenticate.Request, mmm: ParentRequestBody)
}

protocol PrincipalDataStore {
    // Para mantener datos entre escenas si es necesario
}

class PrincipalInteractor: PrincipalBusinessLogic, PrincipalDataStore {
    var presenter: PrincipalPresentationLogic?

    private lazy var worker: PrincipalWorkingLogic = PrincipalWorker()

    func authenticate(request: Principal.Authenticate.Request, mmm: ParentRequestBody) {

        worker.getUsers(using: mmm) { [weak self]
            
            result in
            guard let self = self else { return }

            switch result {
            case .success(let response):

                let xxx = Principal.Authenticate.Response(
                    success: true,
                    message: response.nombre
                )
                self.presenter?.presentPrincipalResult(response: xxx)

            case .failure(let error):

                self.presenter?.presentError(
                    response: error.localizedDescription
                )
            }
        }
    }
}
