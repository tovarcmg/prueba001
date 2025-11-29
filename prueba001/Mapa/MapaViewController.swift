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
    let buscarLabel = UILabel()
    
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
        
        titleLabel.text = "appVenton"
        titleLabel.textAlignment = .center
        titleLabel.textColor = .white
        titleLabel.font = UIFont(name: "HelveticaNeue-Bold", size: 30)
        
        buscarLabel.text = "Buscar destino"
        buscarLabel.textAlignment = .left
        buscarLabel.textColor = .white
        
        


        let stack = UIStackView(arrangedSubviews: [
            titleLabel, buscarLabel
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
