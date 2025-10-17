//
//  HttpStatusCode.swift
//  prueba001
//
//  Created by tovarchavez on 24/08/25.
//


//
//  WebServiceClient.swift
//  PacoMax
//
//  Copyright © 2022 E1Technology. All rights reserved.
//

import os.log
import Foundation

// MARK: - HttpStatusCode
/// The Http status code.
enum HttpStatusCode {
    
    static let validRange = 200..<300
    
    static let noContent = 204
}

// MARK: - HttpNoContent
/// Http no content response, related to `204` status code.
struct HttpNoContent: Decodable { }

// MARK: - WebServiceClient

/// Client class used for performing all of the network calls.
final class WebServiceClient {

    // MARK: - Properties

    /// URL session used for all of the WebServiceClient's calls.
    private let session: URLSession = {
        let configuration = URLSessionConfiguration.default
        let session = URLSession(configuration: configuration)
        return session
    }()

    // MARK: - Request Cancellation

    func cancelAllRequests() {

        session.getAllTasks { $0.forEach { $0.cancel() } }
    }

    #warning("TODO: This method will need a refactor and a better error handling system. Ticket: https://paco-el-chato.atlassian.net/browse/MAX-151")
    /// Makes a web service request.
    ///
    /// - Parameters:
    ///   - request: The request object used to make the service call. Needs to conform the WebServiceRequest protocol.
    ///   - responseType: The type of response. Needs to conform the Decodable protocol.
    ///   - completionQueue: Queue to call the completion handler on - defaults to the main queue.
    ///   - completion: The completion handler that will return the result of the request. `RequestCompletion<Response>`
    func perform<Request: WebServiceRequest,
                 Response: Decodable>(request: Request,
                                      responseType: Response.Type,
                                      completionQueue: DispatchQueue = .main,
                                      completion: @escaping RequestCompletion<Response>) {

        // MARK: URL Request
        // Construct the URLRequest and handle errors.
        let urlRequest: URLRequest
        do {
            urlRequest = try request.buildUrlRequest()
        } catch let error as WebServiceUrlRequestError {
            switch error {
            case .invalidUrl:
                completionQueue.async {
                    completion(.failure(error: NSError(domain: "Invalid Endpoint", code: 404, userInfo: nil)))
                }
            }

            return

        } catch {
            completionQueue.async {
                completion(.failure(error: NSError(domain: "Uknowkn Error", code: 404, userInfo: nil)))
            }

            return
        }

        // MARK: Handle Response
        /// Helper closure to handle the response
        let handleResponse: (Data?, URLResponse?, Error?) -> Void = { [weak self] data, urlResponse, error in

            guard let self = self else { return }

            let optionalHttpCode = (urlResponse as? HTTPURLResponse)?.statusCode

            // Handle errors from URL service

            guard let urlResponse = urlResponse else {
                // Unexpected since response is nil even though there was no error returned
                completionQueue.async {
                    completion(.failure(error: NSError(domain: "Request returned a nil URL Response.", code: optionalHttpCode ?? 404, userInfo: nil)))
                }
                return
            }

            guard let httpResponse = urlResponse as? HTTPURLResponse else {
                completionQueue.async {
                    completion(.failure(error: NSError(domain: "Bad HTTP Url Request.", code: optionalHttpCode ?? 404, userInfo: nil)))
                }

                return
            }

            let httpCode = httpResponse.statusCode

            guard let data = data else {
                completionQueue.async {
                    completion(.failure(error: NSError(domain: "Data not returned from request.", code: httpCode, userInfo: nil)))
                }

                return
            }

            // Perform response validation.

            guard HttpStatusCode.validRange ~= httpCode else {
                
                completionQueue.async {
                    completion(.failure(error: NSError(domain: "Response is not a valid success response", code: httpCode, userInfo: nil)))
                }

                return
            }

            // If the response is expected to be in plain data, we just handle it without decoding, and finish execution.
            if responseType == Data.self {
                
                self.handlePlainData(data, completionQueue: completionQueue, completion: completion)
                return
            }

            if httpCode == HttpStatusCode.noContent,
               let noContent = HttpNoContent() as? Response {
                 
                completionQueue.async {
                    completion(.success(response: noContent))
                }
                return
            }
            
            // Decode the response.
            let response: Response
            do {
                response = try JSONDecoder().decode(Response.self, from: data)
            } catch {
                
                completionQueue.async {
                    completion(.failure(error: NSError(domain: "Couldn't decode response.", code: httpCode, userInfo: nil)))
                }

                return
            }

            // Decoded response successfully.
            completionQueue.async {
                completion(.success(response: response))
            }
        }

        // Execute the network call.
        execute(request: urlRequest, completion: handleResponse)
    }

    /// Makes sure that the request type is `Data` and handles its information to the completion handler.
    /// - Parameters:
    ///   - data: Pass in data returned from a network request.
    ///   - completionQueue: Queue where the completion should be executed.
    ///   - completion: completion to continue the flow of the request.
    private func handlePlainData<Response: Decodable>(_ data: Data,
                                                      completionQueue: DispatchQueue,
                                                      completion: @escaping RequestCompletion<Response>) {

        guard let responseData = data as? Response else {
            return os_log("Interference with data types. Expected response is not raw data.", log: .default, type: .error)
        }

        /// Completing successfully with raw data.
        completionQueue.async {
            completion(.success(response: responseData))
        }
    }

    /// Executes a network request.
    ///
    /// - Parameters:
    ///   - request: network request to execute.
    ///   - completion: completion returning the service results.
    private func execute(request: URLRequest, completion: @escaping (Data?, URLResponse?, Error?) -> Void) {

        session.dataTask(with: request) { data, urlResponse, error in

            completion(data, urlResponse, error)

        }.resume()
    }
}
