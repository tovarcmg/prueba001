//
//  BoardWorkingLogic.swift
//  prueba001
//
//  Created by tovarchavez on 24/08/25.
//


//
//  BoardWorker.swift
//  PacoMax
//
//  Created by Luis on 05/07/22.
//  Copyright © 2022 E1Technology. All rights reserved.
//

import Foundation

// MARK: - BoardWorkingLogic

/// Defines the functions of the Worker.
protocol BoardWorkingLogic {
    
    func getHeadOfDisplayInfo(completion: @escaping RequestCompletion<HeadOfDisplayResponse>)
    func getTopics(completion: @escaping RequestCompletion<[Topic]>)
    func getUsers(completion: @escaping RequestCompletion<[User]>)
}

// MARK: - BoardWorker

final class BoardWorker: BoardWorkingLogic {
    
    // MARK: - Private Properties
    
    private let service = WebServiceClient()

    // MARK: - Working Logic
    
    func getHeadOfDisplayInfo(completion: @escaping RequestCompletion<HeadOfDisplayResponse>) {
        
        #warning("TODO: Update the accessToken once we can retrieve a student token.")
        let headers = WebServiceHeader(accessToken: Constant.defaultAccessToken)
        let request = HeadOfDisplayRequest(headers: headers.dictionary)
        
        service.perform(request: request, responseType: HeadOfDisplayResponse.self) { result in
            switch result {
            case .success(response: let response):
                completion(.success(response: response))
            case .failure(error: let error):
                completion(.failure(error: error))
            }
        }
    }
    
    func getTopics(completion: @escaping RequestCompletion<[Topic]>) {
        
        #warning("TODO: Update the accessToken once we can retrieve a student token.")
        let headers = WebServiceHeader(accessToken: Constant.defaultAccessToken)
        let request = TopicsRequest(headers: headers.dictionary)
        
        service.perform(request: request, responseType: [Topic].self) { result in
            
            switch result {
            case .success(response: let response):
                completion(.success(response: response))
            case .failure(error: let error):
                completion(.failure(error: error))
            }
        }
    }

    func getUsers(completion: @escaping RequestCompletion<[User]>) {
        
        #warning("TODO: Update the accessToken once we can retrieve a student token.")
        let headers = WebServiceHeader(accessToken: Constant.defaultAccessToken)
        let request = UsersRequest(headers: headers.dictionary)
        
        service.perform(request: request, responseType: [User].self) { result in
            
            switch result {
            case .success(response: let response):
                completion(.success(response: response))
            case .failure(error: let error):
                completion(.failure(error: error))
            }
        }
    }

}
