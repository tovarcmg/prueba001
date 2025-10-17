//
//  WebServiceResult.swift
//  PacoMax
//
//  Copyright © 2022 E1Technology. All rights reserved.
//

import Foundation

// MARK: - RequestCompletion Typealias

/// Typealias used to simplify the completion handler that will return the result of the request.
typealias RequestCompletion<Response: Decodable> = (WebServiceResult<Response>) -> Void

// MARK: - WebServiceResult

/// The possible results after peforming a network call.
enum WebServiceResult<Response: Decodable> {

    /// Result when the request returns a valid response.
    case success(response: Response)

    /// Result when the request fails returning a valid response.
    case failure(error: Error)
}
