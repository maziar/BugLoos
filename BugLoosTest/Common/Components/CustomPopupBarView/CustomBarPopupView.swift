//
//  CustomBarPopupViewController.swift
//  BugLoosTest
//
//  Created by Pelk on 8/19/21.
//

import UIKit
import MarqueeLabel

protocol CustomPopupBarDelegate: AnyObject {
    func dismiss()
    func tap()
}

class CustomBarPopupView: UIView {
    weak var delegate: CustomPopupBarDelegate?
    var viewModel: CustomBarPopupViewModel
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    lazy var mediaPlayer = appDelegate.mediaPlayer
    
    @IBOutlet weak var previousButton: UIButton!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet var containerView: UIView!
    @IBOutlet weak var closeButton: UIButton!
    @IBOutlet weak var barView: UIView!
    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: MarqueeLabel!
    @IBOutlet weak var subtitleLabel: MarqueeLabel!
    @IBOutlet weak var progressView: UIProgressView!
    
    init(viewModel: CustomBarPopupViewModel, frame: CGRect) {
        self.viewModel = viewModel
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func commonInit() {
        Bundle.main.loadNibNamed(CustomBarPopupView.nameOfClass, owner: self, options: nil)
        containerView.fixInView(self)
        setupUI()
        setupTrackUI()
        setUpTimer()
        addTapRecognizer()
    }
    
    func setupUI() {
        containerView.backgroundColor = .clear
        containerView.preservesSuperviewLayoutMargins = true
        barView.layer.shadowColor = UIColor.black.cgColor
        barView.layer.shadowOpacity = 0.5
        barView.layer.shadowRadius = 5
        barView.layer.shadowOffset = CGSize(width: 0, height: 0)
        barView.backgroundColor = UIColor(red: 29, green: 29, blue: 33)
        barView.layer.cornerRadius = 2
        closeButton.roundCorners(corners: [.topLeft, .topRight], radius: 7.0)
    }
    
    func setUpTimer() {
        Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { timer in
            self.progressAnimation()
        }
    }
    
    func setupTrackUI() {
        if let track = viewModel.tracks.first(where: { $0.selected == true }) {
            let trackPresenter = TrackPresenter(track: track)
            imageView.sd_setImage(with: trackPresenter.trackImageUrl , placeholderImage: UIImage(named: "logo"))
            titleLabel.text = trackPresenter.name
            subtitleLabel.text = trackPresenter.artistFullName
            playButton.setImage(UIImage(systemName: mediaPlayer.checkButton()), for: .normal)
        }
    }
    
    func setupTrackPlay() {
        if let track = viewModel.tracks.first(where: { $0.selected == true }), let url = URL(string: track.dir) {
            mediaPlayer.media = VLCMedia(url: url)
        }
    }
    
    func progressAnimation() {
        UIView.animate(withDuration: 0.003, delay: 0.0, options: [.beginFromCurrentState], animations: {
            self.progressView.progress = self.mediaPlayer.position
            self.layoutIfNeeded()
        }, completion: nil)
    }
    
    @IBAction func playPause(_ sender: Any) {
        mediaPlayer.toggle()
        playButton.setImage(UIImage(systemName: mediaPlayer.toggleButton()), for: .normal)
    }
    
    @IBAction func next(_ sender: UIButton) {
        guard let index = viewModel.tracks.firstIndex(where: { $0.selected == true }),
              viewModel.tracks.count > index + 1 else {
            return
        }
        viewModel.changeSelectedTracks(tracks: &viewModel.tracks)
        viewModel.next(index: index)
        setupTrackUI()
        setupTrackPlay()
        mediaPlayer.play()
    }
    
    @IBAction func previous(_ sender: Any) {
        guard let index = viewModel.tracks.firstIndex(where: { $0.selected == true }), index > 0 else {
            return
        }
        viewModel.changeSelectedTracks(tracks: &viewModel.tracks)
        viewModel.previous(index: index)
        setupTrackUI()
        setupTrackPlay()
        mediaPlayer.play()
    }
    
    @IBAction func cloaseButtonPressed(_ sender: Any) {
        mediaPlayer.stop()
        viewModel.changeSelectedTracks(tracks: &viewModel.tracks)
        delegate?.dismiss()
    }
    
    func addTapRecognizer() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.handleTap(_:)))
        self.addGestureRecognizer(tap)
    }
    
    @objc func handleTap(_ sender: UITapGestureRecognizer? = nil) {
        delegate?.tap()
    }
}


extension UIView {
    func fixInView(_ container: UIView!) {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.frame = container.frame
        container.addSubview(self)
        NSLayoutConstraint(item: self, attribute: .leading, relatedBy: .equal,
                           toItem: container, attribute: .leading,
                           multiplier: 1.0, constant: 0).isActive = true
        NSLayoutConstraint(item: self, attribute: .trailing, relatedBy: .equal,
                           toItem: container, attribute: .trailing,
                           multiplier: 1.0, constant: 0).isActive = true
        NSLayoutConstraint(item: self, attribute: .top, relatedBy: .equal,
                           toItem: container, attribute: .top,
                           multiplier: 1.0, constant: 0).isActive = true
        NSLayoutConstraint(item: self, attribute: .bottom, relatedBy: .equal,
                           toItem: container, attribute: .bottom,
                           multiplier: 1.0, constant: 0).isActive = true
    }
}

