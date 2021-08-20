//
//  PlayListStretchyHeaderView.swift
//  BugLoosTest
//
//  Created by Pelk on 8/21/21.
//

import UIKit
import MarqueeLabel
import GSKStretchyHeaderView

@objc
public class PlayListStretchyHeaderView: GSKStretchyHeaderView {
    @IBOutlet weak var playListLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet var containerView: UIView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    func commonInit() {
        Bundle.main.loadNibNamed(PlayListStretchyHeaderView.nameOfClass, owner: self, options: nil)
        containerView.fixInView(self)
    }
    
    func config(playList: PlayList) {
        playListLabel.text = playList.title
        imageView.sd_setImage(with: URL(string: playList.cover),
                              placeholderImage: UIImage(named: "logo"))
    }
}
