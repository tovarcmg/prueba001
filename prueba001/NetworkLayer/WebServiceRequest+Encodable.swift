//
//  WebServiceRequest+Encodable.swift
//  PacoMax
//
//  Copyright © 2022 E1Technology. All rights reserved.
//

import Foundation

// MARK: - Encodable Extension
extension Encodable {

    /// Workaround since protocols do not conform to themselves in Swift.
    func add(to request: inout URLRequest, webServiceRequest: WebServiceRequest) throws {

        try webServiceRequest.add(body: self, to: &request)
    }
}
