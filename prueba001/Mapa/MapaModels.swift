//
//  Mapa.swift
//  prueba001
//
//  Created by tovarchavez on 17/08/25.
//


import Foundation

enum Mapa {
    enum Authenticate {
        struct Request {
            let email: String
            let password: String
        }
        struct Response {
            let success: Bool
            let message: String
        }
        struct ViewModel {
            let displayMessage: String
        }
    }
}
