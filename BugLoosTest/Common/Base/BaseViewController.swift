//
//  BaseViewController.swift
//  Edgecom
//
//  Created by Pelk on 11/6/1399 AP.
//

import UIKit

class BaseViewController: UIViewController {
    let defaults = UserDefaults.standard
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    lazy var mediaPlayer = appDelegate.mediaPlayer
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func showAlert(title: String) {
        print(title)
    }
    
    public func handleError(_ error: Error, isLogin: Bool = false) {
        let errorModel = (error as NSError)
        let err = errorModel.domain
        
        let alert = UIAlertController(
            title: "Error",
            message: err,
            preferredStyle: .alert
        )
        
        alert.addAction(UIAlertAction(title: "Done", style: .cancel, handler: {(_: UIAlertAction!) in
            if errorModel.code == 401 && !isLogin {
            }
        }))
        
        present(alert, animated: true, completion: nil)
    }
    
    public func handleErrorMessage(_ error: Error, isLogin: Bool = false) -> String {
        let errorModel = (error as NSError)
        if errorModel.code == 401 {
        }
        return errorModel.domain
    }
    
    @objc
    func dismissKeyBoard() {
        self.view.dismissKeyBoardInView(haveSubClass: true)
    }
    
    @objc
    func dismissPage() {
        self.dismiss(animated: true, completion: nil)
    }
}
