//
//  WebServiceHTTPMethod.swift
//  PacoMax
//
//  Copyright © 2022 E1Technology. All rights reserved.
//

import Foundation

// MARK: - WebServiceHTTPMethod

/// All Hypertext Transfer Protocol Secure Method Definitions.
enum WebServiceHTTPMethod: String {

    case put
    case get
    case post
    // Implement more when needed: post, put, delete, patch, etc.

    /// Computed propertie used to return the String rawValue uppercased.
    var name: String {
        return rawValue.uppercased()
    }
}
