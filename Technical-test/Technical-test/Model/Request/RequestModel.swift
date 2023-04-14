//
//  RequestModel.swift
//  Technical-test
//
//  Created by Andrew on 13.04.2023.
//

import Foundation

enum APIMethod: String {
    case get = "GET"
}

final class RequestModel {
    let request: URLRequest
    let method: APIMethod
    let parameters: [String: Any]?
    
    init(
        _ request: URLRequest,
        _ method: APIMethod,
        _ parameters: [String: Any]? = nil
    ) {
        self.request = request
        self.method = method
        self.parameters = parameters
    }
}
