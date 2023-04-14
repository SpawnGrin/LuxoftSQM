//
//  AppDelegate.swift
//  Technical-test
//
//  Created by Patrice MIAKASSISSA on 29.04.21.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    private var compositionRoot: CompositionRoot?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.compositionRoot = CompositionRoot(window: window)
        
        startRootController(for: application, with: launchOptions)
        
        return true
    }
    
    private func startRootController(for application: UIApplication, with launchOptions: [UIApplication.LaunchOptionsKey: Any]?) {
        let presentationController = UINavigationController()
        let lauchStoryboard = UIStoryboard(name: "LaunchScreen", bundle: nil)
        let launchController = lauchStoryboard.instantiateInitialViewController() ?? UIViewController()
        
        presentationController.setViewControllers([launchController], animated: false)
        window?.rootViewController = presentationController
        window?.makeKeyAndVisible()
        compositionRoot?.compose(
            presentationController: presentationController,
            application: application,
            didFinishLaunchingWithOptions: launchOptions
        )
    }
}

