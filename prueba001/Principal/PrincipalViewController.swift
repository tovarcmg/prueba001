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
        destinoTextField.text = "m"

        buscarButton.setTitle("Buscar", for: .normal)
        buscarButton.tintColor = .white
        buscarButton.backgroundColor = .blue
        buscarButton.layer.cornerRadius = 5
        let tapGestureeee = UITapGestureRecognizer(target: self, action: #selector(buscarRutas))
        buscarButton.addGestureRecognizer(tapGestureeee)

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
        
        let destino: String = destinoTextField.text ?? ""
        
        if !destino.isEmpty {
            interactor?.authenticate(destino: destino)
        }
    }
    
    @objc func labelTocado(_ sender: UITapGestureRecognizer) {
        // Acción al tocar el label
        if let label = sender.view as? RutaLabel {
            print("ID:", label.rutaID ?? 0)
            print("Destino:", label.destino ?? "")
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
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(labelTocado(_:)))
            labellll.addGestureRecognizer(tapGesture)

            stackDestinos.addArrangedSubview(labellll)
        }
    }
}
