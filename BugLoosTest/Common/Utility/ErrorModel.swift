//
//  ErrorModel.swift
//  Edgecom
//
//  Created by Pelk on 11/6/1399 AP.
//

import Foundation
import Unbox

public struct ErrorModel {
    public let message: String
    public let statusCode: Int?
}

extension ErrorModel: Unboxable {
    public init(unboxer: Unboxer) throws {
        self.message = try unboxer.unbox(key: "message")
        self.statusCode = try? unboxer.unbox(key: "status_code")
    }
}

extension ErrorModel {
    func toNSError() -> NSError {
        let nserror = NSError(domain: self.message , code: self.statusCode ?? 0001, userInfo: nil)
        return nserror
    }
}
