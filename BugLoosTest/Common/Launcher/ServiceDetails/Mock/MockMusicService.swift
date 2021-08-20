//
//  MockMusicService.swift
//  JabamaTest
//
//  Created by Pelk on 7/19/21.
//

import Foundation

public class MockMusicService: MusicServiceProtocol {
    
    public enum Error: Swift.Error {
        case loadFailed
    }
    
    public init() {
        // Noop.
    }
    
    public func getPlayList(_ completion: @escaping (Result<PlayListModel>) -> Void) {
        guard let json = loadMockJSON() else {
            completion(Result<PlayListModel>.failure(Error.loadFailed))
            return
        }
        
        let result = PlayListSerializer.shared.serialize(json: json)
        completion(result)
    }
    
    private func loadMockJSON() -> Any? {
        let bundle = Bundle(for: type(of: self))
        
        guard let url = bundle.url(forResource: "music", withExtension: "json") else {
            return nil
        }
        
        do {
            let data = try Data(contentsOf: url)
            let json = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
            return json
        } catch {
            return nil
        }
    }
}
