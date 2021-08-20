//
//  SplashView.swift
//  JabamaTest
//
//  Created by Pelk on 7/21/21.
//

import Foundation
import RevealingSplashView

class SplashView: RevealingSplashView {
    var errorlabel = UILabel(frame: CGRect(x: 30,
                                           y: 50,
                                           width: UIScreen.main.bounds.size.width - 60,
                                           height: 80))
    
    func addLabel() {
        errorlabel.textColor = .red
        errorlabel.textAlignment = .right
        errorlabel.numberOfLines = 0
        self.addSubview(errorlabel)
    }
    
    func addComponent() {
        addLabel()
    }
}
