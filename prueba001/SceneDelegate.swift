import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }

        let window = UIWindow(windowScene: windowScene)
        
        // Instanciar LoginViewController
        let loginVC = LoginViewController()

        // Envolverlo en un NavigationController
        let navController = UINavigationController(rootViewController: loginVC)

        // Asignar a la ventana
        window.rootViewController = navController
        window.makeKeyAndVisible()

        self.window = window

    }
}

