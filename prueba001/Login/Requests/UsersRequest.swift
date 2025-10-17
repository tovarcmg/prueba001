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
    let urlString: String = URLs.Parent.signIn
    
    /// The HTTP method of the request.
    let method: WebServiceHTTPMethod = .post
    
    /// The headers used in the request.
    let headers: [String: String]
}
