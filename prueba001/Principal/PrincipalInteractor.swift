//
//  PrincipalBusinessLogic.swift
//  prueba001
//
//  Created by tovarchavez on 17/08/25.
//

import Foundation

protocol PrincipalBusinessLogic {
    func authenticate(destino: String)
}

protocol PrincipalDataStore {
    // Para mantener datos entre escenas si es necesario
}

class PrincipalInteractor: PrincipalBusinessLogic, PrincipalDataStore {
    var presenter: PrincipalPresentationLogic?

    private lazy var worker: PrincipalWorkingLogic = PrincipalWorker()

    func authenticate(destino: String) {

        worker.getRutas(destino: destino) { [weak self]
            
            result in
            guard let self = self else { return }

            switch result {
            case .success(let response):

                 
                self.presenter?.presentPrincipalResult(response: response)

            case .failure(let error):

                self.presenter?.presentError(
                    response: error.localizedDescription
                )
            }
        }
    }
}
