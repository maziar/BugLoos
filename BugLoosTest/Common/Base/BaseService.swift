//
//  BaseService.swift
//  Edgecom
//
//  Created by Pelk on 11/6/1399 AP.
//

import Foundation
import Alamofire
import SwiftyJSON

public class BaseService {
    var header: HTTPHeaders {
        return HTTPHeaders([
            "Authorization": "Bearer \("")"
        ])
    }
    
    func checkErrorMessage(_ response: AFDataResponse<Any>, error: Error) -> Error {
        if let data = response.data, let message = JSON(data)["message"].rawValue as? String, !message.isEmpty {
           let error = ErrorModel(message: message, statusCode: response.response?.statusCode)
            return error.toNSError()
        }
        return NSError(domain: error.localizedDescription, code: response.response?.statusCode ?? 12, userInfo: nil)
    }
}
