//
//  CompositionRoot.swift
//  Technical-test
//
//  Created by Andrew on 13.04.2023.
//

import UIKit

final class CompositionRoot {
   
    private weak var window: UIWindow?
    
    private var appCoordinator: AppCoordinator?
    
    init(window: UIWindow?) {
        self.window = window
    }
    
    func compose(
        presentationController: UINavigationController,
        application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) {
        appCoordinator = AppCoordinator(
            presentationController: presentationController,
            screenFactory: ScreenFactory(networkService: .init())
        )
        appCoordinator?.start()
    }
}
