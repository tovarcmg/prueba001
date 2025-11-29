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
        view.backgroundColor = .lightGray
        
        titleLabel.text = "Viaje"
        titleLabel.textAlignment = .center
        titleLabel.textColor = .white
        titleLabel.font = UIFont(name: "HelveticaNeue-Bold", size: 30)
        
        conductorLabel.text = "Luis E Tovar (Spark/NBJ-12-IU)"
        conductorLabel.textAlignment = .left
        conductorLabel.textColor = .white
        
        destinoLabel.text = "Destino:"
        destinoLabel.textAlignment = .left
        destinoLabel.textColor = .black
        destinoLabel.font = UIFont(name: "HelveticaNeue-Bold", size: 12)
        
        destinoDireccionLabel.text = "Metro Zocalo, CDMX"
        destinoDireccionLabel.textAlignment = .left
        destinoDireccionLabel.textColor = .white
        
        ubicacionLabel.text = "Ubicacion:"
        ubicacionLabel.textAlignment = .left
        ubicacionLabel.textColor = .black
        ubicacionLabel.font = UIFont(name: "HelveticaNeue-Bold", size: 12)
        
        ubicacionDireccionLabel.text = "Calz México-Tacuba 469-507, Popotla, Miguel Hidalgo, 11400 Ciudad de México, CDMX"
        ubicacionDireccionLabel.textAlignment = .left
        ubicacionDireccionLabel.textColor = .white
        ubicacionDireccionLabel.numberOfLines = 3
        
        buscarButton.setTitle("Ir a Google Maps", for: .normal)
        buscarButton.tintColor = .white
        buscarButton.backgroundColor = .blue
        buscarButton.layer.cornerRadius = 5
        
        recomendacionLabel.text = "Antes de abordar el vehículo, verifica que el modelo, color, matrícula y conductor coincidan con la información mostrada en la aplicación; si notas cualquier discrepancia, comportamiento inusual o te sientes incómodo, evita subir, cancela el viaje y repórtalo inmediatamente a través de la app. Tu seguridad es responsabilidad compartida, por lo que te recomendamos seguir estas medidas preventivas en todo momento."
        recomendacionLabel.textAlignment = .justified
        recomendacionLabel.textColor = .white
        recomendacionLabel.numberOfLines = 10
        
        let stack = UIStackView(arrangedSubviews: [
            titleLabel, conductorLabel, destinoLabel, destinoDireccionLabel, ubicacionLabel, ubicacionDireccionLabel, buscarButton, recomendacionLabel
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
