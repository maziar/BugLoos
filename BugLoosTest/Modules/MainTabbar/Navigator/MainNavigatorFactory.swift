//
//  MainNavigatorFactory.swift
//  BugLoosTest
//
//  Created by Pelk on 8/20/21.
//

import Foundation
import UIKit

class MainNavigatorFactory: MainTabControllerFactoryProtocol {
    func makePlayerViewController(viewModel: PlayerViewModel) -> PlayerViewController {
        return PlayerViewController(playerViewModel: viewModel)
    }
    
    func makeDetailsViewController() -> UIViewController {
        return UIViewController()
    }
}
