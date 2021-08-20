//
//  PlayerViewModel.swift
//  BugLoosTest
//
//  Created by Pelk on 8/19/21.
//

import Foundation
import Queuer

protocol SliderChangeDelegate: AnyObject {
    func sliderChange(value: Float)
    func mediaPlayerPositionChange(value: Float)
}

final class PlayerViewModel: BaseViewModel {
    weak var delegate: SliderChangeDelegate?
    var playList: PlayList
    let queue = Queuer(name: "PlayerQueue", maxConcurrentOperationCount: 1, qualityOfService: .default)
    var position: Float = 0
    
    init(playList: PlayList) {
        self.playList = playList
    }
    
    func next(index: Int) {
        let track = playList.tracks[index + 1]
        track.selected = true
        playList.tracks[index + 1] = track
    }
    
    func previous(index: Int) {
        let track = playList.tracks[index - 1]
        track.selected = true
        playList.tracks[index - 1] = track
    }
    
    func addTimerChange(position: Float) {
        let concurrentOperation = ConcurrentOperation { _ in
            self.position = position
        }
        queue.addOperation(concurrentOperation)
        queue.addCompletionHandler {
            DispatchQueue.main.async {
                self.delegate?.sliderChange(value: self.position)
            }
        }
    }
    
    func changeSliderToQueue(position: Float) {
        queue.cancelAll()
        let concurrentOperation = ConcurrentOperation { _ in
            self.position = position
        }
        queue.addOperation(concurrentOperation)
        queue.addCompletionHandler {
            DispatchQueue.main.async {
                self.delegate?.mediaPlayerPositionChange(value: self.position)
            }
        }
    }
    
    func isTheSameTrack(url: URL) -> Bool {
        guard let track = playList.tracks.first(where: { $0.selected == true }), let trackUrl = URL(string: track.dir) else {
            return false
        }
        
        return trackUrl == url
    }
    
    func changeHeartTrack() {
        guard let index = playList.tracks.firstIndex(where: { $0.selected == true }) else { return }
        let track = playList.tracks[index]
        track.heart.toggle()
        playList.tracks[index] = track
    }
}
