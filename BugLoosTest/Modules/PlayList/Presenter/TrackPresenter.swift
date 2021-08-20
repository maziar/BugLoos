//
//  TrackPresenter.swift
//  BugLoosTest
//
//  Created by Pelk on 8/18/21.
//

import Foundation

public struct TrackPresenter {
    public let id: Int
    public let name: String
    public let artistNikName: String
    public let artistFullName: String
    public let artistImage: String
    public let dir: String
    public let cover: String
    public let trackImageUrl: URL?
    
    public init(track: TrackModel) {
        id = track.id
        name = " \(track.name) "
        artistNikName = track.artist.nikName
        artistFullName = "\(track.artist.name) \(track.artist.family)"
        artistImage = track.artist.image
        dir = track.dir
        cover = track.cover
        trackImageUrl = URL(string: track.cover)
    }
    
    public init(track: Track) {
        id = track.id
        name = "\(track.name) "
        artistNikName = track.artist.nikName
        artistFullName = "\(track.artist.name) \(track.artist.family)"
        artistImage = track.artist.image
        dir = track.dir
        cover = track.cover
        trackImageUrl = URL(string: track.cover)
    }
}
