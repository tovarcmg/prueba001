//
//  PrincipalDisplayLogic.swift
//  prueba001
//
//  Created by tovarchavez on 17/08/25.
//

import UIKit

protocol PrincipalDisplayLogic: AnyObject {

    func displayRutas(response: [Rutas])
}

class PrincipalViewController: UIViewController, PrincipalDisplayLogic {

    var interactor: PrincipalBusinessLogic?
    var router: (NSObjectProtocol & PrincipalRoutingLogic & PrincipalDataPassing)?

    let titleLabel = UILabel()
    let opcion1Label = UILabel()
    let opcion2Label = UILabel()
    let opcion3Label = UILabel()
    let buscarLabel = UILabel()
    let destinoTextField = UITextField()
    let buscarButton = UIButton(type: .system)
    var stackMain : UIStackView = {
        let s = UIStackView()
        s.axis = .vertical
        s.spacing = 12
        s.translatesAutoresizingMaskIntoConstraints = false
        return s
    }()
    
    var stackDestinos : UIStackView = {
        let s = UIStackView()
        s.axis = .vertical
        s.spacing = 12
        s.translatesAutoresizingMaskIntoConstraints = false
        return s
    }()
    
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
        
        titleLabel.text = "appVenton"
        titleLabel.textAlignment = .center
        titleLabel.textColor = .white
        titleLabel.font = UIFont(name: "HelveticaNeue-Bold", size: 30)
        
        buscarLabel.text = "Buscar destino"
        buscarLabel.textAlignment = .left
        buscarLabel.textColor = .white
        
        destinoTextField.placeholder = "metro zocalo"
        destinoTextField.borderStyle = .roundedRect

        buscarButton.setTitle("Buscar", for: .normal)
        buscarButton.tintColor = .white
        buscarButton.backgroundColor = .blue
        buscarButton.layer.cornerRadius = 5
        let tapGestureeee = UITapGestureRecognizer(target: self, action: #selector(buscarRutas))
        buscarButton.addGestureRecognizer(tapGestureeee)
        
        opcion1Label.text = "Luis E Tovar (Spark/NBJ-12-IU)"
        opcion1Label.textAlignment = .left
        opcion1Label.textColor = .white
        // Habilitar interacción en el label
        opcion1Label.isUserInteractionEnabled = true
        // Crear gesto de tap
        //let tapGesture = UITapGestureRecognizer(target: self, action: #selector(labelTocado))
        //opcion1Label.addGestureRecognizer(tapGesture)
        
        opcion2Label.text = "Natalia Chavez (Aveo/PQO-33-DC)"
        opcion2Label.textAlignment = .left
        opcion2Label.textColor = .white
        
        opcion3Label.text = "Yareli Ibarra (FIAT/ACA-23-LK)"
        opcion3Label.textAlignment = .left
        opcion3Label.textColor = .white


        stackMain.addArrangedSubview(titleLabel)
        stackMain.addArrangedSubview(buscarLabel)
        stackMain.addArrangedSubview(destinoTextField)
        stackMain.addArrangedSubview(buscarButton)
        stackMain.addArrangedSubview(stackDestinos)
        
        //stack.axis = .vertical
        stackMain.spacing = 12
        stackMain.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(stackMain)
        NSLayoutConstraint.activate([
            stackMain.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            stackMain.leadingAnchor.constraint(
                equalTo: view.leadingAnchor,
                constant: 24
            ),
            stackMain.trailingAnchor.constraint(
                equalTo: view.trailingAnchor,
                constant: -24
            ),
        ])
    }
    
    @objc func buscarRutas() {
        
        interactor?.authenticate(destino: destinoTextField.text ?? "")

    }
    
    @objc func labelTocado() {
        // Acción al tocar el label
        router?.navigateToHome()
    }
    
    func displayRutas(response: [Rutas]) {
        stackDestinos.arrangedSubviews.forEach { $0.removeFromSuperview() }

        response.forEach { ruta in
            let label = UILabel()
            label.text = ruta.destino
            label.isUserInteractionEnabled = true
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(labelTocado))
            label.addGestureRecognizer(tapGesture)

            stackDestinos.addArrangedSubview(label)
        }
    }
}
