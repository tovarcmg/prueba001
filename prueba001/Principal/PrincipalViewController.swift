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
    let buscarLabel = UILabel()
    let destinoTextField = UITextField()
    let buscarButton = UIButton(type: .system)

    var stackMain: UIStackView = {
        let s = UIStackView()
        s.axis = .vertical
        s.spacing = 22
        s.alignment = .center
        s.translatesAutoresizingMaskIntoConstraints = false
        return s
    }()

    var stackDestinos: UIStackView = {
        let s = UIStackView()
        s.axis = .vertical
        s.spacing = 14
        s.alignment = .fill
        s.translatesAutoresizingMaskIntoConstraints = false
        return s
    }()

    var destinoSel = infoRuta(id: 0, origen: "", destino: "", chofer: "")

    class RutaLabel: UILabel {
        var rutaID: Int?
        var destino: String?
        var origen: String?
        var chofer: String?
    }

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

        view.backgroundColor = UIColor.systemBackground

        titleLabel.text = "appVenton"
        titleLabel.textAlignment = .center
        titleLabel.textColor = UIColor.label
        titleLabel.font = UIFont.systemFont(ofSize: 42, weight: .bold)

        buscarLabel.text = "Buscar destino"
        buscarLabel.textAlignment = .center
        buscarLabel.textColor = .secondaryLabel
        buscarLabel.font = UIFont.systemFont(ofSize: 17, weight: .regular)

        destinoTextField.placeholder = "Ejemplo: Metro Zócalo"
        destinoTextField.borderStyle = .none
        destinoTextField.backgroundColor = .clear
        destinoTextField.textAlignment = .center
        destinoTextField.textColor = UIColor.label
        destinoTextField.font = UIFont.systemFont(ofSize: 20)

        let underline = UIView()
        underline.backgroundColor = UIColor.systemGray3
        underline.translatesAutoresizingMaskIntoConstraints = false
        destinoTextField.addSubview(underline)
        NSLayoutConstraint.activate([
            underline.heightAnchor.constraint(equalToConstant: 1),
            underline.leadingAnchor.constraint(equalTo: destinoTextField.leadingAnchor, constant: 0),
            underline.trailingAnchor.constraint(equalTo: destinoTextField.trailingAnchor, constant: 0),
            underline.bottomAnchor.constraint(equalTo: destinoTextField.bottomAnchor, constant: 0)
        ])

        destinoTextField.widthAnchor.constraint(equalToConstant: 250).isActive = true
        destinoTextField.heightAnchor.constraint(equalToConstant: 35).isActive = true

        buscarButton.setTitle("Buscar", for: .normal)
        buscarButton.backgroundColor = UIColor.label
        buscarButton.setTitleColor(UIColor.systemBackground, for: .normal)
        buscarButton.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        buscarButton.layer.cornerRadius = 20
        buscarButton.contentEdgeInsets = UIEdgeInsets(top: 12, left: 40, bottom: 12, right: 40)

        let tapGestureeee = UITapGestureRecognizer(target: self, action: #selector(buscarRutas))
        buscarButton.addGestureRecognizer(tapGestureeee)

        stackMain.addArrangedSubview(titleLabel)
        stackMain.addArrangedSubview(buscarLabel)
        stackMain.addArrangedSubview(destinoTextField)
        stackMain.addArrangedSubview(buscarButton)
        stackMain.addArrangedSubview(stackDestinos)

        view.addSubview(stackMain)
        NSLayoutConstraint.activate([
            stackMain.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackMain.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            stackMain.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            stackMain.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
        ])
    }

    @objc func buscarRutas() {
        let destino: String = destinoTextField.text ?? ""
        if !destino.isEmpty {
            interactor?.authenticate(destino: destino)
        }
    }

    @objc func labelTocado(_ sender: UITapGestureRecognizer) {
        if let label = sender.view as? RutaLabel {
            destinoSel.id = label.rutaID ?? 0
            destinoSel.destino = label.destino ?? ""
            destinoSel.origen = label.origen ?? ""
            destinoSel.chofer = label.chofer ?? ""
        }
        router?.navigateToMapa(destino: destinoSel)
    }

    func displayRutas(response: [Rutas]) {
        stackDestinos.arrangedSubviews.forEach { $0.removeFromSuperview() }

        response.forEach { ruta in
            let labellll = RutaLabel()
            labellll.text = ruta.destino
            labellll.rutaID = ruta.id
            labellll.destino = ruta.destino
            labellll.origen = ruta.origen
            labellll.chofer = ruta.idUsuario

            labellll.isUserInteractionEnabled = true
            labellll.textAlignment = .center
            labellll.textColor = UIColor.label
            labellll.font = UIFont.systemFont(ofSize: 18, weight: .medium)
            labellll.backgroundColor = UIColor.secondarySystemBackground
            labellll.layer.cornerRadius = 16
            labellll.layer.masksToBounds = true
            labellll.heightAnchor.constraint(equalToConstant: 46).isActive = true

            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(labelTocado(_:)))
            labellll.addGestureRecognizer(tapGesture)

            stackDestinos.addArrangedSubview(labellll)
        }
    }
}
