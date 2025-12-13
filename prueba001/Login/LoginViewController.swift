//
//  LoginDisplayLogic.swift
//  prueba001
//
//  Created by tovarchavez on 17/08/25.
//

import UIKit

protocol LoginDisplayLogic: AnyObject {
    func displayLoginResult(viewModel: Login.Authenticate.ViewModel)
}

class LoginViewController: UIViewController, LoginDisplayLogic {

    var interactor: LoginBusinessLogic?
    var router: (NSObjectProtocol & LoginRoutingLogic & LoginDataPassing)?

    let titleTextField = UILabel()
    let emailTextField = UITextField()
    let passwordTextField = UITextField()
    let loginButton = UIButton(type: .system)
    let resultLabel = UILabel()

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        setupUI()
        hideKeyboardWhenTapped()
    }

    private func setup() {
        let viewController = self
        let interactor = LoginInteractor()
        let presenter = LoginPresenter()
        let router = LoginRouter()

        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }

    private func setupUI() {

        view.backgroundColor = UIColor.systemGray6

        titleTextField.text = "appVenton"
        titleTextField.textAlignment = .center
        titleTextField.textColor = UIColor.label
        titleTextField.font = UIFont.systemFont(ofSize: 36, weight: .bold)

        emailTextField.text = "luistovar"
        emailTextField.placeholder = "Correo"
        emailTextField.borderStyle = .none
        emailTextField.backgroundColor = .white
        emailTextField.layer.cornerRadius = 12
        emailTextField.layer.borderWidth = 1
        emailTextField.layer.borderColor = UIColor.systemGray4.cgColor
        emailTextField.setLeftPaddingPoints(12)
        emailTextField.heightAnchor.constraint(equalToConstant: 45).isActive = true

        passwordTextField.text = "123123"
        passwordTextField.placeholder = "Contraseña"
        passwordTextField.borderStyle = .none
        passwordTextField.isSecureTextEntry = true
        passwordTextField.backgroundColor = .white
        passwordTextField.layer.cornerRadius = 12
        passwordTextField.layer.borderWidth = 1
        passwordTextField.layer.borderColor = UIColor.systemGray4.cgColor
        passwordTextField.setLeftPaddingPoints(12)
        passwordTextField.heightAnchor.constraint(equalToConstant: 45).isActive = true

        loginButton.setTitle("Iniciar sesión", for: .normal)
        loginButton.addTarget(self, action: #selector(loginTapped), for: .touchUpInside)
        loginButton.tintColor = .white
        loginButton.backgroundColor = .black
        loginButton.titleLabel?.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
        loginButton.layer.cornerRadius = 14
        loginButton.heightAnchor.constraint(equalToConstant: 50).isActive = true

        resultLabel.textAlignment = .center
        resultLabel.numberOfLines = 0
        resultLabel.textColor = .systemRed
        resultLabel.font = UIFont.systemFont(ofSize: 15, weight: .medium)

        let stack = UIStackView(arrangedSubviews: [
            titleTextField,
            emailTextField,
            passwordTextField,
            loginButton,
            resultLabel,
        ])

        stack.axis = .vertical
        stack.spacing = 18
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.alignment = .fill

        view.addSubview(stack)

        NSLayoutConstraint.activate([
            stack.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            stack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32),
            stack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32),
        ])
    }

    @objc private func loginTapped() {
        self.resultLabel.text = ""
        let request = Login.Authenticate.Request(
            email: emailTextField.text ?? "",
            password: passwordTextField.text ?? ""
        )

        let credentialssss = ParentRequestBody(
            usuario: emailTextField.text ?? "",
            contrasena: passwordTextField.text ?? ""
        )

        interactor?.authenticate(request: request, mmm: credentialssss)
    }

    func displayLoginResult(viewModel: Login.Authenticate.ViewModel) {
        let resp = viewModel.displayMessage

        if resp == "like" {
            router?.navigateToHome()
        } else {
            self.resultLabel.text = viewModel.displayMessage
        }
    }

    func hideKeyboardWhenTapped() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }

    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}


extension UITextField {
    func setLeftPaddingPoints(_ amount: CGFloat){
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.height))
        self.leftView = paddingView
        self.leftViewMode = .always
    }
}
