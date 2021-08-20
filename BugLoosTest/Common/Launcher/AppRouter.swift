//
//  AppRouter.swift
//  JabamaTest
//
//  Created by Pelk on 7/19/21.
//

import Foundation
import UIKit

final class AppRouter {
    static let shared = AppRouter()
    
    func configureMainTabbarViewController(playList: PlayList) -> UIViewController {
        let vc = MainTabbarViewController(viewModel: MainTabbarViewModel(playList: playList))
        return vc
    }
}
