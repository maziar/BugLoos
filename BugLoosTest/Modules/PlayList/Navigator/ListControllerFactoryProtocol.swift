//
//  ListControllerFactoryProtocol.swift
//  
//
//  Created by Pelk on 7/21/21.
//

import Foundation
import UIKit

protocol ListControllerFactoryProtocol {
    func makePlayerViewController(viewModel: PlayerViewModel) -> PlayerViewController
    func makeDetailsViewController() -> UIViewController
}
