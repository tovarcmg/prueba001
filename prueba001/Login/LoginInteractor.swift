//
//  LoginBusinessLogic.swift
//  prueba001
//
//  Created by tovarchavez on 17/08/25.
//


import Foundation

protocol LoginBusinessLogic {
    func authenticate(request: Login.Authenticate.Request)
}

protocol LoginDataStore {
    // Para mantener datos entre escenas si es necesario
}

class LoginInteractor: LoginBusinessLogic, LoginDataStore {
    var presenter: LoginPresentationLogic?

    func authenticate(request: Login.Authenticate.Request) {
        let isValid = request.email == "admin@example.com" && request.password == "1234"
        let message = isValid ? "Login exitoso" : "Credenciales inválidas"
        let response = Login.Authenticate.Response(success: isValid, message: message)
        presenter?.presentLoginResult(response: response)
    }
}
