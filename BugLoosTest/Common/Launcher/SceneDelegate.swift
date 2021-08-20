//
//  SceneDelegate.swift
//  BugLoosTest
//
//  Created by Pelk on 8/18/21.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    
    var viewModel: SceneDelegateViewModel = SceneDelegateViewModel(service: MockMusicService())
    let revealingSplashView = SplashView(iconImage: UIImage(named: "logo")! ,
                                         iconInitialSize: CGSize(width: 80,height: 80),
                                         backgroundColor: .white)
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let scene = (scene as? UIWindowScene) else { return }
        self.window = UIWindow(windowScene: scene)
        splashRoot()
        bindViewModel()
        viewModel.getPlayList()
    }
    
    func splashRoot() {
        let vc = UIViewController()
        vc.view.backgroundColor = .black
        window?.rootViewController = vc
        window?.makeKeyAndVisible()
        window?.addSubview(revealingSplashView)
        revealingSplashView.playHeartBeatAnimation()
    }
    
    func bindViewModel() {
        viewModel.changeHandler = { [weak self] change in
            guard let strongSelf = self else { return }
            switch change {
            case .didChangeNetworkActivityStatus(_):
                break
            case .didSuccess:
                strongSelf.revealingSplashView.finishHeartBeatAnimation()
                strongSelf.revealingSplashView.startAnimation {
                    strongSelf.initListRootViewController()
                }
                break
            case .didError(_):
                strongSelf.viewModel.getPlayList()
                break
            }
        }
    }
    
    func initListRootViewController() {
        window?.rootViewController = AppRouter.shared.configureMainTabbarViewController(playList: viewModel.playList)
        window?.makeKeyAndVisible()
    }

    func sceneDidDisconnect(_ scene: UIScene) {
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
    }

    func sceneWillResignActive(_ scene: UIScene) {
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
    }
}
