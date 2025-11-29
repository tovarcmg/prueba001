//
//  PrincipalDisplayLogic.swift
//  prueba001
//
//  Created by tovarchavez on 17/08/25.
//

import UIKit

protocol PrincipalDisplayLogic: AnyObject {
    func displayPrincipalResult(viewModel: Principal.Authenticate.ViewModel)
}

class PrincipalViewController: UIViewController, PrincipalDisplayLogic {

    var interactor: PrincipalBusinessLogic?
    var router: (NSObjectProtocol & PrincipalRoutingLogic & PrincipalDataPassing)?

    let titleTextField = UILabel()
    let emailTextField = UITextField()
    let passwordTextField = UITextField()
    let loginButton = UIButton(type: .system)
    let resultLabel = UILabel()

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        setupUI()
    }

    private func setup() {
        let viewController = self
        let interactor = PrincipalInteractor()
        let presenter = PrincipalPresenter()
        let router = PrincipalRouter()

        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }

    private func setupUI() {
        view.backgroundColor = .lightGray
        titleTextField.text = "appVenton"
        titleTextField.textAlignment = .center
        titleTextField.textColor = .white
        emailTextField.placeholder = "Correo"
        emailTextField.borderStyle = .roundedRect
        passwordTextField.placeholder = "Contrasena"
        passwordTextField.borderStyle = .roundedRect
        passwordTextField.isSecureTextEntry = true

        loginButton.setTitle("Principal", for: .normal)
        loginButton.addTarget(
            self,
            action: #selector(loginTapped),
            for: .touchUpInside
        )
        loginButton.tintColor = .white
        loginButton.backgroundColor = .blue
        loginButton.layer.cornerRadius = 5

        resultLabel.textAlignment = .center
        resultLabel.numberOfLines = 0

        let stack = UIStackView(arrangedSubviews: [
            titleTextField, emailTextField, passwordTextField, loginButton,
            resultLabel,
        ])
        stack.axis = .vertical
        stack.spacing = 12
        stack.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(stack)
        NSLayoutConstraint.activate([
            stack.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            stack.leadingAnchor.constraint(
                equalTo: view.leadingAnchor,
                constant: 24
            ),
            stack.trailingAnchor.constraint(
                equalTo: view.trailingAnchor,
                constant: -24
            ),
        ])
    }

    @objc private func loginTapped() {
        self.resultLabel.text = ""
        let request = Principal.Authenticate.Request(
            email: emailTextField.text ?? "",
            password: passwordTextField.text ?? ""
        )
        
        let credentialssss = ParentRequestBody(
            usuario: emailTextField.text ?? "",
            contrasena: passwordTextField.text ?? ""
        )

        interactor?.authenticate(request: request, mmm: credentialssss)
    }

    func displayPrincipalResult(viewModel: Principal.Authenticate.ViewModel) {
        DispatchQueue.main.async {
            self.resultLabel.text = viewModel.displayMessage
        }
    }

    
}
