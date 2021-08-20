//
//  PlayerViewController+Actions.swift
//  BugLoosTest
//
//  Created by Pelk on 8/19/21.
//

import Foundation

extension PlayerViewController {
    @IBAction func playButtonPressed(_ sender: Any) {
        mediaPlayer.toggle()
        playButton.setBackgroundImage(UIImage(systemName: mediaPlayer.toggleCircleButton()), for: .normal)
    }
    
    @IBAction func nextButtonPressed(_ sender: Any) {
        guard let index = viewModel.playList.tracks.firstIndex(where: { $0.selected == true }),
              viewModel.playList.tracks.count > index + 1 else {
            return
        }
        viewModel.changeSelectedTracks(tracks: &viewModel.playList.tracks)
        viewModel.next(index: index)
        setupTrackUI()
        setupTrackMedia()
        mediaPlayer.play()
    }
    
    @IBAction func previousButtonPressed(_ sender: Any) {
        guard let index = viewModel.playList.tracks.firstIndex(where: { $0.selected == true }), index > 0 else {
            return
        }
        viewModel.changeSelectedTracks(tracks: &viewModel.playList.tracks)
        viewModel.previous(index: index)
        setupTrackUI()
        setupTrackMedia()
        mediaPlayer.play()
    }
    
    @IBAction func dragInside(_ sender: Any) {
        viewModel.queue.cancelAll()
    }
    
    @IBAction func sliderValueChanged(_ sender: Any) {
        viewModel.changeSliderToQueue(position: seekSlider.value)
    }
    
    @IBAction func heartButtonPressed(_ sender: Any) {
        viewModel.changeHeartTrack()
        setupTrackUI()
    }
    @IBAction func dismissButtonPressed(_ sender: Any) {
        self.dismissPage()
    }
    
    @IBAction func disLikeButtonPressed(_ sender: Any) {
    }
    @IBAction func shareButtonPressed(_ sender: Any) {
    }
    @IBAction func infoButtonPressed(_ sender: Any) {
    }
    @IBAction func companybuttonPressed(_ sender: Any) {
    }
    
}
