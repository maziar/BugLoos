//
//  PlayListModel.swift
//  BugLoosTest
//
//  Created by Pelk on 8/20/21.
//

import Foundation
import Unbox

public struct PlayListModel {
    public let title: String
    public let cover: String
    public let tracks: [TrackModel]
}

extension PlayListModel: Unboxable {
    public init(unboxer: Unboxer) throws {
        self.title = try unboxer.unbox(keyPath: "playlist.title")
        self.cover = try unboxer.unbox(keyPath: "playlist.cover")
        self.tracks = try unboxer.unbox(keyPath: "playlist.tracks")
    }
}
