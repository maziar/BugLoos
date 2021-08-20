//
//  MainTabControllerFactoryProtocol.swift
//  BugLoosTest
//
//  Created by Pelk on 8/20/21.
//

import Foundation
import UIKit

protocol MainTabControllerFactoryProtocol {
    func makePlayerViewController(viewModel: PlayerViewModel) -> PlayerViewController
    func makeDetailsViewController() -> UIViewController
}
