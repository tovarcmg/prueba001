//
//  MapaDisplayLogic.swift
//  prueba001
//
//  Created by tovarchavez on 17/08/25.
//

import UIKit

protocol MapaDisplayLogic: AnyObject {

}

class MapaViewController: UIViewController, MapaDisplayLogic {

    var interactor: MapaBusinessLogic?
    var router: (NSObjectProtocol & MapaRoutingLogic & MapaDataPassing)?

    let titleLabel = UILabel()
    let conductorLabel = UILabel()
    let destinoLabel = UILabel()
    let destinoDireccionLabel = UILabel()
    let ubicacionLabel = UILabel()
    let ubicacionDireccionLabel = UILabel()
    let buscarButton = UIButton(type: .system)
    let recomendacionLabel = UILabel()
    let solicitarButton = UIButton(type: .system)
    
    /// The initializer.
    init(destino: infoRuta) {
        
        super.init(nibName: nil, bundle: nil)
        
        destinoDireccionLabel.text = destino.destino
        ubicacionDireccionLabel.text = destino.origen
        conductorLabel.text = destino.chofer
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        setupUI()
    }

    private func setup() {
        let viewController = self
        let interactor = MapaInteractor()
        let presenter = MapaPresenter()
        let router = MapaRouter()

        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }

    private func setupUI() {
        view.backgroundColor = UIColor.systemGray6
        
        let titleFont = UIFont.systemFont(ofSize: 28, weight: .bold)
        let subtitleFont = UIFont.systemFont(ofSize: 14, weight: .semibold)
        let bodyFont = UIFont.systemFont(ofSize: 15, weight: .regular)
        
        titleLabel.text = "Viaje"
        titleLabel.textAlignment = .center
        titleLabel.font = titleFont
        titleLabel.textColor = UIColor.label
        
        
        //contenedor de info
        
        let infoContainer = UIView()
        infoContainer.backgroundColor = .white
        infoContainer.layer.cornerRadius = 12
        infoContainer.layer.shadowColor = UIColor.black.cgColor
        infoContainer.layer.shadowOpacity = 0.08
        infoContainer.layer.shadowRadius = 6
        infoContainer.layer.shadowOffset = CGSize(width: 0, height: 4)
        infoContainer.translatesAutoresizingMaskIntoConstraints = false
        
        solicitarButton.setTitle("Solicitar", for: .normal)
        solicitarButton.titleLabel?.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
        solicitarButton.backgroundColor = UIColor.systemBlue
        solicitarButton.tintColor = .white
        solicitarButton.layer.cornerRadius = 10
        solicitarButton.heightAnchor.constraint(equalToConstant: 48).isActive = true
        
        //conductorLabel.text = "Luis E Tovar (Spark/NBJ-12-IU)"
        conductorLabel.textAlignment = .left
        conductorLabel.font = bodyFont
        conductorLabel.textColor = UIColor.darkGray
        
        destinoLabel.text = "Destino:"
        destinoLabel.font = subtitleFont
        destinoLabel.textColor = UIColor.label
        
        //destinoDireccionLabel.text = "Metro Zocalo, CDMX"
        destinoDireccionLabel.textAlignment = .left
        destinoDireccionLabel.font = bodyFont
        destinoDireccionLabel.textColor = UIColor.darkGray
        
        ubicacionLabel.text = "Ubicacion:"
        ubicacionLabel.font = subtitleFont
        ubicacionLabel.textColor = UIColor.label
        
        //ubicacionDireccionLabel.text = "Calz México-Tacuba 469-507, Popotla, Miguel Hidalgo, 11400 Ciudad de México, CDMX"
        ubicacionDireccionLabel.textAlignment = .left
        ubicacionDireccionLabel.font = bodyFont
        ubicacionDireccionLabel.textColor = UIColor.darkGray
        ubicacionDireccionLabel.numberOfLines = 0
        
        buscarButton.setTitle("Ir a Google Maps", for: .normal)
        buscarButton.titleLabel?.font = UIFont.systemFont(ofSize: 15, weight: .medium)
        buscarButton.tintColor = .white
        buscarButton.backgroundColor = UIColor.systemGreen
        buscarButton.layer.cornerRadius = 10
        buscarButton.heightAnchor.constraint(equalToConstant: 44).isActive = true
        
        recomendacionLabel.text = "Antes de abordar el vehículo, verifica que el modelo, color, matrícula y conductor coincidan con la información mostrada en la aplicación; si notas cualquier discrepancia, comportamiento inusual o te sientes incómodo, evita subir, cancela el viaje y repórtalo inmediatamente a través de la app. Tu seguridad es responsabilidad compartida, por lo que te recomendamos seguir estas medidas preventivas en todo momento."
        recomendacionLabel.textAlignment = .justified
        recomendacionLabel.textColor = UIColor.secondaryLabel
        recomendacionLabel.font = UIFont.systemFont(ofSize: 13)
        recomendacionLabel.numberOfLines = 0
        
        
        let infoStack = UIStackView(arrangedSubviews: [
                    conductorLabel,
                    destinoLabel,
                    destinoDireccionLabel,
                    ubicacionLabel,
                    ubicacionDireccionLabel,
                    buscarButton
                ])
                infoStack.axis = .vertical
                infoStack.spacing = 8
                infoStack.translatesAutoresizingMaskIntoConstraints = false
                
                infoContainer.addSubview(infoStack)
                
                NSLayoutConstraint.activate([
                    infoStack.topAnchor.constraint(equalTo: infoContainer.topAnchor, constant: 16),
                    infoStack.leadingAnchor.constraint(equalTo: infoContainer.leadingAnchor, constant: 16),
                    infoStack.trailingAnchor.constraint(equalTo: infoContainer.trailingAnchor, constant: -16),
                    infoStack.bottomAnchor.constraint(equalTo: infoContainer.bottomAnchor, constant: -16)
                ])
        
        
        let stack = UIStackView(arrangedSubviews: [
            titleLabel, infoContainer, solicitarButton, recomendacionLabel
        ])
        stack.axis = .vertical
        stack.spacing = 12
        stack.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(stack)
        NSLayoutConstraint.activate([
            stack.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
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

    @objc func labelTocado() {
            // Acción al tocar el label
            
        }
}
