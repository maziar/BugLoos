//
//  PlayList.swift
//  BugLoosTest
//
//  Created by Pelk on 8/20/21.
//

import Foundation

public class PlayList {
    public var title: String
    public var cover: String
    public var tracks: [Track]
    
    init(title: String, cover: String, tracks: [Track]) {
        self.title = title
        self.cover = cover
        self.tracks = tracks
    }
}
