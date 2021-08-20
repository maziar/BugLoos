//
//  PlayListViewModel.swift
//  BugLoosTest
//
//  Created by Pelk on 8/18/21.
//

import Foundation

final class PlayListViewModel: BaseViewModel {
    var playList: PlayList {
        didSet {
            playList.tracks = playList.tracks.filter { $0.removed == false }
        }
    }
    
    init(playList: PlayList) {
        self.playList = playList
    }
    
    func changeHeartTrack(trackId: Int) -> Int {
        guard let index = playList.tracks.firstIndex(where: { $0.id == trackId }) else { return 0 }
        let track = playList.tracks[index]
        track.heart.toggle()
        playList.tracks[index] = track
        return index
    }
    
    func changeRemoveTrack(trackId: Int) {
        guard let index = playList.tracks.firstIndex(where: { $0.id == trackId }) else { return }
        let track = playList.tracks[index]
        track.removed.toggle()
        playList.tracks[index] = track
    }
}
