//
//  SceneDelegate.swift
//  BehindClosedDoors
//
//  Created by Daria on 08.05.2024.
//

import UIKit

class DependencyManager {
    static func createSearchNC() -> UIViewController {
        let mainVC = MainViewController()
        mainVC.title = "BEHIND CLOSED DOORS"
        return mainVC
    }

    static func createNavController() -> UINavigationController {
        let navController = UINavigationController()
        if #available(iOS 15, *) {
            let navigationBarAppearance = UINavigationBarAppearance()
            navigationBarAppearance.configureWithOpaqueBackground()
            navigationBarAppearance.titleTextAttributes = [
                NSAttributedString.Key.foregroundColor : UIColor.black
            ]
            navigationBarAppearance.backgroundColor           = Resources.Colors.green ?? UIColor.systemGray
            UINavigationBar.appearance().standardAppearance   = navigationBarAppearance
            UINavigationBar.appearance().compactAppearance    = navigationBarAppearance
            UINavigationBar.appearance().scrollEdgeAppearance = navigationBarAppearance
        }
        navController.viewControllers = [createSearchNC()]
        return navController
    }
}

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window                     = UIWindow(frame: windowScene.coordinateSpace.bounds)
        window?.windowScene        = windowScene
        window?.rootViewController = DependencyManager.createNavController()
        window?.makeKeyAndVisible()
    }
}

