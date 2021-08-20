//
//  CustomBarPopupViewModel.swift
//  BugLoosTest
//
//  Created by Pelk on 8/19/21.
//

import Foundation

final class CustomBarPopupViewModel: BaseViewModel {
    var tracks: [Track]
    
    init(tracks: [Track]) {
        self.tracks = tracks
    }
    
    func next(index: Int) {
        let track = tracks[index + 1]
        track.selected = true
        tracks[index + 1] = track
    }
    
    func previous(index: Int) {
        let track = tracks[index - 1]
        track.selected = true
        tracks[index - 1] = track
    }
}
