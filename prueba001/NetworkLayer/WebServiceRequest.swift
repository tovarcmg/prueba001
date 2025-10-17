//
//  WebServiceRequest.swift
//  PacoMax
//
//  Copyright © 2022 E1Technology. All rights reserved.
//

import os.log
import Foundation

// MARK: - WebServiceRequest

protocol WebServiceRequest {

    /// The request url string.
    var urlString: String { get }

    /// The HTTP method used in the request.
    var method: WebServiceHTTPMethod { get }

    /// The headers to be used in the request.
    var headers: [String: String] { get }

    /// The query items to be appended to the full formed url.
    var queryItems: [String: String] { get }

    /// Gets the body to be used in the request.
    ///
    /// - Returns: encodable body object. nil if no body needed.
    func getBody() -> Encodable?
}

// MARK: - WebService Request Extension

extension WebServiceRequest {

    /// Default implementation for headers.
    var headers: [String: String] {
        [:]
    }

    /// Default implementation for queryItems.
    var queryItems: [String: String] {
        [:]
    }
    
    /// Default implementation for getBody.
    func getBody() -> Encodable? { nil }
}

// MARK: - WebServiceRequest Extension

extension WebServiceRequest {

    /// URL request builder.
    ///
    /// - Throws: `Error` if there is a problem encoding the request body.
    /// - Throws: `WebServiceUrlRequestInitializationError.invalidUrl` if invalid URL is encountered.
    func buildUrlRequest() throws -> URLRequest {

        guard let url = URL(string: urlString) else {
            throw WebServiceUrlRequestError.invalidUrl(url: urlString)
        }

        // Init the Url Request.
        var urlRequest = URLRequest(url: url)

        add(method: method, to: &urlRequest)

        add(queryItems: queryItems, to: &urlRequest)

        add(headers: headers, to: &urlRequest)

        // Adds http body.
        try getBody()?.add(to: &urlRequest, webServiceRequest: self)

        return urlRequest
    }

    /// Adds the HTTP method to the request.
    func add(method: WebServiceHTTPMethod, to request: inout URLRequest) {

        request.httpMethod = method.name
    }

    /// Encodes and appends the given request parameters to the request url.
    func add(queryItems: [String: String]?, to request: inout URLRequest) {

        guard let queryItems = queryItems else {
            return os_log("Failed unwrapping the queryItems.")
        }

        guard let requestURL = request.url else {
            return os_log("Failed unwrapping the request url.")
        }

        let items = queryItems.map { URLQueryItem(name: $0, value: $1) }

        var urlComponents = URLComponents(url: requestURL, resolvingAgainstBaseURL: false)
        urlComponents?.queryItems = items

        request.url = urlComponents?.url
    }

    /// Adds given headers to the request.
    func add(headers: [String: String]?, to request: inout URLRequest) {
        guard let headers = headers else {
            return os_log("Failed unwrapping the request headers.")
        }

        request.allHTTPHeaderFields = headers
    }

    /// Adds given body to the request.
    ///
    /// - Throws: Error.
    func add<Body: Encodable>(body: Body?,
                              to request: inout URLRequest) throws {

        guard let body = body else {
            return os_log("Failed unwrapping the request body.")
        }

        request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")

        let encodingResult: Data
        do {
            encodingResult = try JSONEncoder().encode(body)
        } catch {
            throw error
        }

        request.httpBody = encodingResult
    }
}
