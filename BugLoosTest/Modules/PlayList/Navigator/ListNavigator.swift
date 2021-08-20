//
//  ListNavigator.swift
//  JabamaTest
//
//  Created by Pelk on 7/21/21.
//

import Foundation
import UIKit

class ListNavigator: Navigator {
    enum Destination {
        case detailsView
        case playerView
    }

    private weak var navigationController: UINavigationController?
    private let viewControllerFactory: ListNavigatorFactory

    // MARK: - Initializer

    init(navigationController: UINavigationController?,
         viewControllerFactory: ListNavigatorFactory) {
        self.navigationController = navigationController
        self.viewControllerFactory = viewControllerFactory
    }

    // MARK: - Navigator

    func navigate(to destination: Destination,
                  isPresent: Bool = false,
                  modalPresentationStyle: UIModalPresentationStyle = .automatic,
                  animated: Bool = true,
                  viewModel: BaseViewModel? = nil) {
        let viewController = makeViewController(for: destination, viewModel: viewModel)
        
        if isPresent {
            viewController.modalPresentationStyle = modalPresentationStyle
            navigationController?.present(viewController, animated: animated, completion: nil)
        } else {
            navigationController?.pushViewController(viewController, animated: true)
        }
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
