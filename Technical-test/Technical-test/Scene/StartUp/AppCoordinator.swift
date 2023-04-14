//
//  AppCoordinator.swift
//  Technical-test
//
//  Created by Andrew on 13.04.2023.
//

import UIKit

protocol AppCoordinatorDelegate {
    func followDetails(_ related: DefaultQuoteDetailsViewModel.DTO.Related)
}

final class AppCoordinator {
    
    public let presentationController: UINavigationController
    
    private let screenFactory: ScreenFactory
    
    init(
        presentationController: UINavigationController,
        screenFactory: ScreenFactory
    ) {
        self.presentationController = presentationController
        self.screenFactory = screenFactory
    }
    
    func start() {
        let quotesListController = screenFactory.create(scene: .quotesList(self))
        presentationController.setViewControllers([quotesListController], animated: true)
    }
}

extension AppCoordinator: AppCoordinatorDelegate {
    
    func followDetails(_ related: DefaultQuoteDetailsViewModel.DTO.Related) {
        let detailsController = screenFactory.create(scene: .quotesDetails(related))
        presentationController.pushViewController(detailsController, animated: true)
    }
}
