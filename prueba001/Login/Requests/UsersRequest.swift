//
//  UsersRequest.swift
//  prueba001
//
//  Created by tovarchavez on 24/08/25.
//


//
//  UsersRequest.swift
//  PacoMax
//
//  Created by Luis on 07/07/22.
//  Copyright © 2022 E1Technology. All rights reserved.
//

import Foundation

// MARK: - UsersRequest

struct UsersRequest: WebServiceRequest {
    
    /// The URL string of the request.
    let urlString: String = "https://appventonapi-cpefgxg2gvekhshq.mexicocentral-01.azurewebsites.net/api/Login/IniciarSesion"
    
    /// The HTTP method of the request.
    let method: WebServiceHTTPMethod = .post
    
    /// The headers used in the request.
    let headers: [String: String]
    
    let body: ParentRequestBody

        func getBody() -> Encodable? {
            return body
        }
}
