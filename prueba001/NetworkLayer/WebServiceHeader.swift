//
//  WebServiceHeader.swift
//  PacoMax
//
//  Copyright © 2022 E1Technology. All rights reserved.
//

import Foundation

/// Type alias to group additional headers definition, in network calls of the service.
public typealias AdditionalHeaders = [String: String]

// MARK: - WebServiceHeader

struct WebServiceHeader {
    
   /// An optional header for the JWT.
   private let accessToken: String?
   
   /// Additional custom headers to pass into the request.
   private let additionalHeaders: AdditionalHeaders?
    
    ///  Initialization method.
    ///
    ///  - Parameters:
    ///    -  accessToken: The access token used as header.
    ///    - additionalHeaders: Additional custom headers to pass into the request. Default value is `nil`.
   init(accessToken: String?, additionalHeaders: AdditionalHeaders? = nil) {
       
       self.additionalHeaders = additionalHeaders
       if let accessToken = accessToken {
           self.accessToken = WebServiceHeader.normalizeAccessToken(accessToken)
       } else {
           self.accessToken = nil
       }
   }
   
   static func normalizeAccessToken(_ token: String) -> String {
       
       if token.contains(Constants.bearer.rawValue) {
           return token
       } else {
           return "\(Constants.bearer.rawValue) \(token)"
       }
   }
}

// MARK: - Computed Properties
extension WebServiceHeader {
   
   /// Dictionary constructed from the structure
   var dictionary: [String: String] {
       var dictionaryToUse = [String: String]()

       if let accessToken = accessToken, !accessToken.isEmpty {
           dictionaryToUse[Keys.accessToken.rawValue] = accessToken
       }
       
       if let additionalHeaders = additionalHeaders, !additionalHeaders.isEmpty {
           dictionaryToUse.merge(additionalHeaders) { (current, _) in current }
       }
       
       return dictionaryToUse
   }
}

// MARK: - Raw Header Keys
private extension WebServiceHeader {
    
   enum Constants: String {
       case bearer = "Bearer"
   }
   
   enum Keys: String {
       case accessToken = "Authorization"
   }
}
