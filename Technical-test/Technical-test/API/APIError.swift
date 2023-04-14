//
//  APIError.swift
//  Technical-test
//
//  Created by Andrew on 13.04.2023.
//

import Foundation

enum ErrorType {
    case defaultError
    case parsingError
    case endpointError
    case serverError
    case customError(String)
    
    var localizedTitle: String {
        switch self {
        default:
            return "GeneralError.Title".localized
        }
    }
 
    var localizedMessage: String {
        switch self {
        case .defaultError:
            return "GeneralError.Message".localized
        case .parsingError:
            return "ErrorMessage.Parsing".localized
        case .endpointError:
            return "ErrorMessage.Endpoint".localized
        case .serverError:
            return "ErrorMessage.ServerError".localized
        case let .customError(message):
            return message
        }
    }
}

final class APIError: Error, Decodable {
    
    var title = "GeneralError.Title".localized
    var message = "GeneralError.Message".localized
    
    init(_ type: ErrorType = .defaultError) {
        self.title = type.localizedTitle
        self.message = type.localizedMessage
    }
}

extension APIError: LocalizedError {
    var errorDescription: String? {
        return self.message
    }
}


