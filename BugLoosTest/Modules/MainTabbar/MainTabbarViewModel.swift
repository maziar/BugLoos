//
//  MainTabbarViewModel.swift
//  ViraProject
//
//  Created by Maziar Saadatfar on 4/29/20.
//  Copyright © 2020 Maziar Saadatfar. All rights reserved.
//

import Foundation
import UIKit

final class MainTabbarViewModel: BaseViewModel {
    var viewControllers: [UIViewController]
    var selectedViewController: UIViewController
    var selectedIndex: Int = 0
    var playList: PlayList
    
    init(playList: PlayList) {
        self.playList = playList
        
        let homeViewController = PlayListViewController(playListViewModel: PlayListViewModel(playList: playList))
        let searchViewController = SearchViewController(nibName:SearchViewController.nameOfClass , bundle: nil)
        let libraryViewController = LibraryViewController(nibName:LibraryViewController.nameOfClass , bundle: nil)
        let premiumViewController = PremiumViewController(nibName:PremiumViewController.nameOfClass , bundle: nil)
        
        homeViewController.tabBarItem = UITabBarItem(title: "Home", image: UIImage(systemName: "homekit")?
                                                        .imageResize(sizeChange: CGSize(width: 30, height: 24)) , tag: 0)
        searchViewController.tabBarItem = UITabBarItem(title: "Seacrh", image: UIImage(systemName: "magnifyingglass")?
                                                        .imageResize(sizeChange: CGSize(width: 26, height: 24)) , tag: 1)
        libraryViewController.tabBarItem = UITabBarItem(title: "Library", image: UIImage(systemName: "square.stack.3d.up.fill")?
                                                            .imageResize(sizeChange: CGSize(width: 24, height: 24)) , tag: 2)
        premiumViewController.tabBarItem = UITabBarItem(title: "premium", image: UIImage(systemName: "wave.3.forward.circle.fill")?
                                                            .imageResize(sizeChange: CGSize(width: 24, height: 24)) , tag: 3)
        
        let navHomeViewController = UINavigationController(rootViewController: homeViewController)
        let navSearchViewController = UINavigationController(rootViewController: searchViewController)
        let navLibraryViewController = UINavigationController(rootViewController: libraryViewController)
        let navPremiumViewController = UINavigationController(rootViewController: premiumViewController)
        
        setNavigationStyle(navigationCon: navHomeViewController)
        setNavigationStyle(navigationCon: navSearchViewController)
        setNavigationStyle(navigationCon: navLibraryViewController)
        setNavigationStyle(navigationCon: navPremiumViewController)
        
        selectedViewController = navHomeViewController
        selectedIndex = 0
        self.viewControllers = [navHomeViewController, navSearchViewController, navLibraryViewController, navPremiumViewController]
    }
    
    func hasSelectedTrack() -> Bool {
        playList.tracks.filter { $0.selected }.count > 0 ? true : false
    }
}

func setNavigationStyle(navigationCon: UINavigationController) {
    let backImage = UIImage(systemName: "arrowshape.turn.up.backward.fill")?.imageResize(sizeChange: CGSize(width: 24, height: 24))
    navigationCon.navigationBar.backIndicatorImage = backImage
    navigationCon.navigationBar.backIndicatorTransitionMaskImage = backImage
    navigationCon.navigationBar.barTintColor = .black
    navigationCon.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
    navigationCon.navigationBar.tintColor = .white
    UIBarButtonItem.appearance().setBackButtonTitlePositionAdjustment(
        UIOffset(horizontal: -1000, vertical: 0),
        for: UIBarMetrics.default)
}

