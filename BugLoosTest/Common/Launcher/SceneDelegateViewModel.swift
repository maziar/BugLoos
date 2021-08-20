//
//  SceneDelegateViewModel.swift
//  JabamaTest
//
//  Created by Pelk on 7/19/21.
//

import Foundation

final class SceneDelegateViewModel: BaseViewModel, SceneDelegateViewModelProtocol {
    var playList: PlayList = PlayList(title: "", cover: "", tracks: [])
    let service: MusicServiceProtocol!
    var changeHandler: ((MusicViewModelChange) -> Void)?
    
    init(service: MusicServiceProtocol = MusicService()) {
        self.service = service
    }
    
    func getPlayList() {
        emit(.didChangeNetworkActivityStatus(true))
        
        service.getPlayList() { [weak self] (result) in
            guard let strongSelf = self else { return }
            
            strongSelf.emit(.didChangeNetworkActivityStatus(false))
            
            switch result {
            case .success(let response):
                strongSelf.playList = PlayList(title: response.title,
                                               cover: response.cover,
                                               tracks: response.tracks.map { Track(track: $0) })
                strongSelf.emit(.didSuccess)
            case .failure(let error):
                strongSelf.emit(.didError(error))
            }
        }
    }
    
    private func emit(_ change: MusicViewModelChange) {
        changeHandler?(change)
    }
}
