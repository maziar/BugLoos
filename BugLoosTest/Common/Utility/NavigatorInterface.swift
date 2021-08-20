//
//  NavigatorInterface.swift
//  JabamaTest
//
//  Created by Pelk on 7/21/21.
//

import Foundation
import UIKit

protocol Navigator {
    associatedtype Destination
    func navigate(to destination: Destination,
                  isPresent: Bool,
                  modalPresentationStyle: UIModalPresentationStyle,
                  animated: Bool,
                  viewModel: BaseViewModel?)
}
