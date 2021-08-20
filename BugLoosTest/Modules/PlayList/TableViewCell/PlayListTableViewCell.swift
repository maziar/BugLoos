//
//  PlayListTableViewCell.swift
//  BugLoosTest
//
//  Created by Pelk on 8/18/21.
//

import UIKit
import MarqueeLabel

protocol PlayListCellDelegate: AnyObject {
    func heartTap(trackId: Int)
    func removeTap(trackId: Int)
    func moreTap(trackId: Int)
}

class PlayListTableViewCell: UITableViewCell {
    
    weak var delegate: PlayListCellDelegate?
    var viewModel = TrackViewModel()
    
    @IBOutlet weak var nameLabel: MarqueeLabel!
    @IBOutlet weak var artistLabel: UILabel!
    @IBOutlet weak var heartButton: UIButton!
    @IBOutlet weak var deleteButton: UIButton!
    @IBOutlet weak var moreButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        moreButton.setImage(UIImage(named: "more")?.imageWithColor(color: .white), for: .normal)
        deleteButton.setImage(UIImage(named: "stop")?.imageWithColor(color: .white), for: .normal)
    }
    
    func config(track: Track) {
        viewModel.track = track
        let trackPresenter = TrackPresenter(track: track)
        nameLabel.text = trackPresenter.name
        artistLabel.text = trackPresenter.artistFullName
        let heartImage = track.heart ? UIImage(named: "fillHeart") : UIImage(named: "heart")?.imageWithColor(color: .white)
        heartButton.setImage(heartImage, for: .normal)
    }
    @IBAction func moreButtonPressed(_ sender: Any) {
        guard let id = viewModel.track?.id else {
            return
        }
        delegate?.moreTap(trackId: id)
    }
    
    @IBAction func removeButtonPressed(_ sender: Any) {
        guard let id = viewModel.track?.id else {
            return
        }
        delegate?.removeTap(trackId: id)
    }
    
    @IBAction func heartButtonPressed(_ sender: Any) {
        guard let id = viewModel.track?.id else {
            return
        }
        delegate?.heartTap(trackId: id)
    }
}

extension PlayListTableViewCell {
    class func register(for tableView: UITableView) {
        tableView.register(UINib(nibName: PlayListTableViewCell.nameOfClass, bundle: Bundle.main),
                           forCellReuseIdentifier: PlayListTableViewCell.nameOfClass)
    }
}
