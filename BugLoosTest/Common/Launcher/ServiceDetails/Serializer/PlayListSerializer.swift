//
//  MusicSerializer.swift
//
//
//  Created by Pelk on 7/19/21.
//

import Foundation
import Unbox

class PlayListSerializer {
    enum Error: Swift.Error {
        case invalidResponse
    }
    
    static let shared = PlayListSerializer()
    
    func serialize(json: Any) -> Result<PlayListModel> {
        do {
            guard let json = json as? [String: Any] else {
                let result = Result<PlayListModel>.failure(Error.invalidResponse)
                return result
            }
            let response: PlayListModel = try unbox(dictionary: json)
            let result = Result<PlayListModel>.success(response)
            return result
        } catch {
            let result = Result<PlayListModel>.failure(Error.invalidResponse)
            return result
        }
    }
}
