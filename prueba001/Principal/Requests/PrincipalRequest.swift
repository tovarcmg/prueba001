//
//  PrincipalRequest.swift
//  mmm
//
//  Created by Luis on 07/07/22.
//  Copyright © 2025 mmm. All rights reserved.
//

import Foundation

// MARK: - PrincipalRequest

struct PrincipalRequest: WebServiceRequest {
    
    /// The URL string of the request.
    let urlString: String
    
    /// The HTTP method of the request.
    let method: WebServiceHTTPMethod = .get
    
    /// The headers used in the request.
    //let headers: [String: String]
    
     
}
