//
//  TrackModel.swift
//  JabamaTest
//
//  Created by Pelk on 7/19/21.
//

import Foundation
import Unbox

public struct TrackModel {
    public let id: Int
    public let name: String
    public let artist: ArtistModel
    public let dir: String
    public let cover: String
    public var heart: Bool = false
    public var removed: Bool = false
    public var selected: Bool = false
}

extension TrackModel: Unboxable {
    public init(unboxer: Unboxer) throws {
        self.id = try unboxer.unbox(key: "id")
        self.name = try unboxer.unbox(key: "name")
        self.artist = try unboxer.unbox(key: "artist")
        self.dir = try unboxer.unbox(key: "dir")
        self.cover = try unboxer.unbox(key: "cover")
    }
}

public class Track {
    public var id: Int
    public var name: String
    public var artist: ArtistModel
    public var dir: String
    public var cover: String
    public var heart: Bool = false
    public var removed: Bool = false
    public var selected: Bool = false
    
    init(track: TrackModel) {
        self.id = track.id
        self.name = track.name
        self.artist = track.artist
        self.dir = track.dir
        self.cover = track.cover
        self.heart = track.heart
        self.removed = track.removed
        self.selected = track.selected
    }
}
