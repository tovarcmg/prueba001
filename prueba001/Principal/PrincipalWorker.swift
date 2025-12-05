//
//  PrincipalWorker.swift
//  PacoMax
//
//  Created by Luis on 05/07/22.
//  Copyright © 2022 E1Technology. All rights reserved.
//

import Foundation

// MARK: - PrincipalWorkingLogic

/// Defines the functions of the Worker.
protocol PrincipalWorkingLogic {

    func getRutas(
        destino: String,
        completion: @escaping RequestCompletion<[Rutas]>
    )
}

// MARK: - PrincipalWorker

final class PrincipalWorker: PrincipalWorkingLogic {

    // MARK: - Private Properties

    private let service = WebServiceClient()

    // MARK: - Working Logic

    func getRutas(
        destino: String,
        completion: @escaping RequestCompletion<[Rutas]>
    ) {

        let request = PrincipalRequest(
            urlString: "https://appventonapi-cpefgxg2gvekhshq.mexicocentral-01.azurewebsites.net/api/rutas/Lista/"+destino
        )

        service.perform(request: request, responseType: [Rutas].self) {
            
            result in

            switch result {
            case .success(let response):
                completion(.success(response: response))
            case .failure(let error):
                completion(.failure(error: error))
            }
        }
    }

}
