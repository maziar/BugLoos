//
//  SceneDelegateViewModelContract.swift
//  JabamaTest
//
//  Created by Pelk on 7/19/21.
//

import Foundation

enum MusicViewModelChange {
    case didSuccess
    case didError(Error)
    case didChangeNetworkActivityStatus(Bool)
}

protocol SceneDelegateViewModelProtocol {
    var playList: PlayList { get }
    var changeHandler: ((MusicViewModelChange) -> Void)? { get set }
    func getPlayList()
}
