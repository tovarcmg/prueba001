//
//  WebServiceUrlRequestInitializationError.swift
//  PacoMax
//
//  Copyright © 2022 E1Technology. All rights reserved.
//

import Foundation

// MARK: - WebServiceUrlRequestInitializationError

/// Error reported on URL Request Initialization.
///
/// - invalidUrl: thrown when the URL string is not valid.
enum WebServiceUrlRequestError: Error {
    case invalidUrl(url: String)
}
