//
//  MainTabNavigator.swift
//  BugLoosTest
//
//  Created by Pelk on 8/20/21.
//

import Foundation
import UIKit

class MainTabNavigator: Navigator {
    enum Destination {
        case detailsView
        case playerView
    }

    private var tabbarController: UITabBarController
    private let viewControllerFactory: MainNavigatorFactory

    // MARK: - Initializer

    init(tabbarController: UITabBarController,
         viewControllerFactory: MainNavigatorFactory) {
        self.tabbarController = tabbarController
        self.viewControllerFactory = viewControllerFactory
    }

    // MARK: - Navigator

    func navigate(to destination: Destination,
                  isPresent: Bool = true,
                  modalPresentationStyle: UIModalPresentationStyle = .fullScreen,
                  animated: Bool = true,
                  viewModel: BaseViewModel? = nil) {
        let viewController = makeViewController(for: destination, viewModel: viewModel)
        viewController.modalPresentationStyle = modalPresentationStyle
        tabbarController.present(viewController, animated: animated, completion: nil)
    }

    // MARK: - Private

    private func makeViewController(for destination: Destination,
                                    viewModel: BaseViewModel? = nil) -> UIViewController {
        switch destination {
        case .playerView:
            if let playerViewModel = viewModel as? PlayerViewModel {
                return viewControllerFactory.makePlayerViewController(viewModel: playerViewModel)
            }
            return UIViewController()
        case .detailsView:
            return viewControllerFactory.makeDetailsViewController()
        }
    }
}
