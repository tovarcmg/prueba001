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

    func getUsers(
        using credentials: ParentRequestBody,
        completion: @escaping RequestCompletion<User>
    )
}

// MARK: - PrincipalWorker

final class PrincipalWorker: PrincipalWorkingLogic {

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
