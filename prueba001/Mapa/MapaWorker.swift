//
//  MapaWorker.swift
//  PacoMax
//
//  Created by Luis on 05/07/22.
//  Copyright © 2022 E1Technology. All rights reserved.
//

import Foundation

// MARK: - MapaWorkingLogic

/// Defines the functions of the Worker.
protocol MapaWorkingLogic {

    func getUsers(
        using credentials: ParentRequestBody,
        completion: @escaping RequestCompletion<User>
    )
}

// MARK: - MapaWorker

final class MapaWorker: MapaWorkingLogic {

    // MARK: - Private Properties

    private let service = WebServiceClient()

    // MARK: - Working Logic

    func getUsers(
        using credentials: ParentRequestBody,
        completion: @escaping RequestCompletion<User>
    ) {

        let headers = WebServiceHeader(accessToken: "mmm")

        let request = UsersRequest(
            headers: headers.dictionary,
            body: credentials
        )

        service.perform(request: request, responseType: User.self) {
            
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
