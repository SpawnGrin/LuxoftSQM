//
//  BaseNetworkService.swift
//  Technical-test
//
//  Created by Andrew on 13.04.2023.
//

import Foundation

final class BaseNetworkService {
    
    var session: URLSession?
    var currentDataTask: URLSessionDataTask?
    
    private let domainPath = "https://www.swissquote.ch/"
    
    func request(with endpoint: String?) -> Result<URLRequest, APIError> {
        if let url = URL(string: domainPath + (endpoint ?? "")) {
            var request = URLRequest(url: url)
            request.timeoutInterval = 30
            return .success(request)
        } else {
            return .failure(.init(.endpointError))
        }
    }
    
    func perform(_ requestModel: RequestModel, _ result: @escaping (Swift.Result<Data, APIError>) -> ()) {
        var request: URLRequest = requestModel.request
        request.httpMethod = requestModel.method.rawValue
        
        do {
            if requestModel.method != .get {
                request.httpBody = try JSONSerialization.data(
                    withJSONObject: requestModel.parameters ?? [:],
                    options: .prettyPrinted
                )
            }
        } catch let error as NSError {
            print(error.localizedDescription)
            result(.failure(.init(.parsingError)))
        }
        session = URLSession(
            configuration: .default,
            delegate: nil,
            delegateQueue: URLSession.shared.delegateQueue
        )
        currentDataTask = session?.dataTask(
            with: request,
            completionHandler: { [weak self] (data, response, error) in
                DispatchQueue.main.async {
                    self?.handleResponse(requestModel, result, data, response, error as NSError?)
                }
                self?.session?.finishTasksAndInvalidate()
            })
        currentDataTask?.resume()
    }
    
    private func handleResponse(
        _ requestModel: RequestModel,
        _ result: @escaping (Swift.Result<Data, APIError>) -> (),
        _ data: Data?,
        _ response: URLResponse?,
        _ error: NSError?
    ) {
        let httpResponse = response as? HTTPURLResponse
        let statusCode = httpResponse?.statusCode ?? 100
        let responseCodeGroup = statusCode / 100
        
        switch responseCodeGroup {
        case 2:
            result(.success(data ?? Data()))
        case 4:
            if let message = error?.localizedDescription {
                result(.failure(.init(.customError(message))))
            } else {
                result(.failure(.init(.defaultError)))
            }
        case 5:
            result(.failure(.init(.serverError)))
        default:
            let connectionLostErrorCode = -1009
            if error?.code == connectionLostErrorCode {
                result(.failure(.init(.customError("ErrorMessage.ConnectionLost".localized))))
            } else {
                result(.failure(.init(.defaultError)))
            }
        }
    }
}
