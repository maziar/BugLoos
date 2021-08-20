//
//  ListSideNavigatorFactory.swift
//  JabamaTest
//
//  Created by Pelk on 7/21/21.
//

import Foundation
import UIKit

class ListNavigatorFactory: ListControllerFactoryProtocol {
    func makePlayerViewController(viewModel: PlayerViewModel) -> PlayerViewController {
        return PlayerViewController(playerViewModel: viewModel)
    }
    
    func makeDetailsViewController() -> UIViewController {
        return UIViewController()
    }
}
