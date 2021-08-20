//
//  ArtistModel.swift
//  BugLoosTest
//
//  Created by Pelk on 8/18/21.
//

import Foundation
import Unbox

public struct ArtistModel {
    public let id: UUID
    public let nikName: String
    public let name: String
    public let family: String
    public let image: String
}

extension ArtistModel: Unboxable {
    public init(unboxer: Unboxer) throws {
        self.id = UUID()
        self.nikName = try unboxer.unbox(key: "nikName")
        self.name = try unboxer.unbox(key: "name")
        self.family = try unboxer.unbox(key: "family")
        self.image = try unboxer.unbox(key: "image")
    }
}
