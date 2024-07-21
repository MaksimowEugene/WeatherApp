//
//  AppDelegate.swift
//  WeatherApp
//
//  Created by Eugene Maksimow on 20.07.2024.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        let navigationController = UINavigationController()
        window = UIWindow(frame: UIScreen.main.bounds)
        navigationController.viewControllers.append(WeatherSelectorView())
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()

        return true
    }
}
