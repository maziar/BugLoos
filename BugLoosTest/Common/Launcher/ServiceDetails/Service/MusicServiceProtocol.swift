//
//  MusicServiceProtocol.swift
//
//
//  Created by Pelk on 7/19/21.
//

import Foundation

public protocol MusicServiceProtocol {
    func getPlayList(_ completion: @escaping (Result<PlayListModel>) -> Void)
}
