//
//  MusicService.swift
//
//
//  Created by Pelk on 7/19/21.
//

import Foundation
import Alamofire
import Unbox

public class MusicService: BaseService , MusicServiceProtocol {
    public func getPlayList(_ completion: @escaping  (Result<PlayListModel>) -> Void) {
        let urlString = ""
        print("url--->\(urlString)")
        AF.request(urlString,
                   method: .post,
                   parameters: nil,
                   encoding: JSONEncoding.default,
                   headers: header)
        .validate(statusCode: 200..<300)
        .responseJSON { (response) in
            switch response.result {
            case .success(let rawJSON):
                let result = PlayListSerializer.shared.serialize(json: rawJSON)
                completion(result)
            case .failure(let error):
                let errorModel = self.checkErrorMessage(response, error: error)
                let result = Result<PlayListModel>.failure(errorModel)
                completion(result)
            }
        }
    }
}
