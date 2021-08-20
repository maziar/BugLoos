//
//  PlayerViewController.swift
//  BugLoosTest
//
//  Created by Pelk on 8/19/21.
//

import UIKit
import SDWebImage
import Queuer
import MarqueeLabel

class PlayerViewController: BaseViewController {
    
    @IBOutlet weak var dismissButton: UIButton!
    @IBOutlet weak var infoButton: UIButton!
    @IBOutlet weak var trackImageView: UIImageView!
    @IBOutlet weak var songNameLabel: MarqueeLabel!
    @IBOutlet weak var artistNameLabel: MarqueeLabel!
    @IBOutlet weak var shareButton: UIButton!
    @IBOutlet weak var companyButton: UIButton!
    @IBOutlet weak var seekStackView: UIStackView!
    @IBOutlet weak var seekView: UIView!
    @IBOutlet weak var seekSlider: UISlider!
    @IBOutlet weak var controlsStackView: UIStackView!
    @IBOutlet weak var heartButton: UIButton!
    @IBOutlet weak var dislikeButton: UIButton!
    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var previousButton: UIButton!
    @IBOutlet weak var labelsStackView: UIStackView!
    @IBOutlet weak var albumLabel: MarqueeLabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var movieView: UIView!
    
    let viewModel: PlayerViewModel
    
    init(playerViewModel: PlayerViewModel) {
        self.viewModel = playerViewModel
        super.init(nibName: PlayerViewController.nameOfClass, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        setupMediaPLayer()
        setUpTimer()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupTrackUI()
        if !mediaPlayer.isPlaying || !viewModel.isTheSameTrack(url: mediaPlayer.media.url) { setupTrackMedia() }
        mediaPlayer.play()
        playButton.setBackgroundImage(UIImage(systemName: "pause.circle"), for: .normal)
    }
    
    func setup() {
        viewModel.delegate = self
        albumLabel.text = viewModel.playList.title
    }

    func setupMediaPLayer() {
        mediaPlayer.delegate = self
        mediaPlayer.drawable = movieView
    }
    
    func setupTrackUI() {
        guard let track = viewModel.playList.tracks.first(where: { $0.selected == true }) else {
            return
        }
        let trackPresenter = TrackPresenter(track: track)
        songNameLabel.text = trackPresenter.name
        artistNameLabel.text = trackPresenter.artistFullName
        trackImageView.sd_setImage(with: trackPresenter.trackImageUrl , placeholderImage: UIImage(named: "logo"))
        let image = track.heart ? UIImage(named: "fillHeart") : UIImage(systemName: "heart")
        heartButton.setBackgroundImage(image, for: .normal)
    }
    
    func setupTrackMedia() {
        guard let track = viewModel.playList.tracks.first(where: { $0.selected == true }), let url = URL(string: track.dir) else {
            return
        }
        mediaPlayer.media = VLCMedia(url: url)
    }
    
    func setUpTimer() {
        Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { timer in
            self.viewModel.addTimerChange(position: self.mediaPlayer.position)
        }
    }
}

extension PlayerViewController: VLCMediaPlayerDelegate {
    func mediaPlayerStateChanged(_ aNotification: Notification!) {
        if mediaPlayer.state == .stopped {
        }
    }
}

extension PlayerViewController: SliderChangeDelegate {
    func sliderChange(value: Float) {
        UIView.animate(withDuration: 1.0, delay: 0.0, options: [.beginFromCurrentState], animations: {
            self.seekSlider.value = value
            self.view.layoutIfNeeded()
        }, completion: nil)
    }
    
    func mediaPlayerPositionChange(value: Float) {
        mediaPlayer.position = value
    }
}
