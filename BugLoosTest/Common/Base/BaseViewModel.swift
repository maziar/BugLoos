//
//  BaseViewModel.swift
//  Edgecom
//
//  Created by Pelk on 11/6/1399 AP.
//

import Foundation
import UIKit
import CoreData

public class BaseViewModel {
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    let defaults = UserDefaults.standard
    
    func changeSelectedTracks(tracks: inout [Track]) {
        var trackList: [Track] = []
        for track in tracks {
            let trk = track
            trk.selected = false
            trackList.append(trk)
        }
        tracks = trackList
    }
}
