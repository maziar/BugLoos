//
//  MainTabbarViewController.swift
//
//
//  Created by Maziar Saadatfar on 4/29/20.
//  Copyright © 2020 Maziar Saadatfar. All rights reserved.
//

import UIKit
import MarqueeLabel

class MainTabbarViewController: UITabBarController {
    var viewModel: MainTabbarViewModel!
    lazy var customPopupBarVC = CustomBarPopupView(viewModel: CustomBarPopupViewModel(tracks: viewModel.playList.tracks),
                                                   frame: CGRect(x: 0, y: screenHeight, width: screenWidth, height: 95))
    lazy var navigator = MainTabNavigator(tabbarController: self,
                                       viewControllerFactory: MainNavigatorFactory())
    
    init(viewModel: MainTabbarViewModel) {
        self.viewModel = viewModel
        super.init(nibName: MainTabbarViewController.nameOfClass, bundle: nil)
        customPopupBarVC.isHidden = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTabbarView()
        self.view.insertSubview(self.customPopupBarVC, belowSubview: self.tabBar)
        self.customPopupBarVC.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        checkShowOrNot()
    }
    
    func configureTabbarView() {
        guard let viewModel = viewModel else {
            return
        }
        
        self.tabBar.barTintColor = UIColor(red: 29, green: 29, blue: 33)
        self.tabBar.tintColor = .white
        self.viewControllers = viewModel.viewControllers
        self.selectedViewController = viewModel.selectedViewController
        self.selectedIndex = viewModel.selectedIndex
    }
    
    func checkShowOrNot() {
        if viewModel.hasSelectedTrack() {
            showBottomView()
            customPopupBarVC.setupTrackUI()
        }
        else { hideBottomView() }
    }
}

extension MainTabbarViewController: CustomPopupBarDelegate {
    func tap() {
        navigator.navigate(to: .playerView,
                           viewModel: PlayerViewModel(playList: viewModel.playList))
    }
    
    func dismiss() {
        hideBottomView()
    }
}

extension MainTabbarViewController {
    func showBottomView() {
        let height = 95
        let tabbarHeight = self.tabBar.frame.size.height
        self.customPopupBarVC.isHidden = false
        UIView.animate(withDuration: 0.5, delay: 0.2, options: .curveLinear) {
            self.customPopupBarVC.frame = CGRect(x: 0,
                                      y: Int(screenHeight) - height - Int(tabbarHeight),
                                      width: Int(screenWidth),
                                      height: height)
            self.loadViewIfNeeded()
        } completion: {_ in
        }
    }
    
    func hideBottomView() {
        UIView.animate(withDuration: 0.5, delay: 0.2, options: .curveLinear) {
            self.customPopupBarVC.isHidden = true
            self.view.backgroundColor = .blue;
            let height = 100;
            self.customPopupBarVC.frame = CGRect(x: 0,
                                      y: Int(screenHeight) + height,
                                      width: Int(screenWidth),
                                      height: 0)
            self.loadViewIfNeeded()
        } completion: {_ in
        }
    }
}
