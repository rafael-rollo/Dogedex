//
//  APIRequest.swift
//  Dogedex
//
//  Created by rafael.rollo on 28/10/21.
//

import Foundation
import Alamofire

class APIRequest {
    
    ///
    /// Provide a simple API request interface as a service.
    /// Uses the Alamofire networking services wrapping the URLSession implementation details
    /// - returns: some decodable object
    ///
    static func execute<T: Decodable>(resource: Resource,
                                      httpMethod: HTTPMethod? = .get,
                                      body: Data? = nil,
                                      headers: HTTPHeaders? = nil,
                                      onCompletion: @escaping (T) -> Void,
                                      onFailure: @escaping (Error) -> Void) {
        
        guard let url = resource.buildEndpointURL() else {
            onFailure(NSError(domain: "Error creating URL", code: -11, userInfo: nil))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = httpMethod?.rawValue
        request.httpBody = body
        
        if body != nil {
            request.setValue("application/json", forHTTPHeaderField: "Content-type")
        }
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        
        if let headers = headers {
            headers.forEach { request.addValue($0.value, forHTTPHeaderField: $0.name) }
        }
        
        request.cachePolicy = NSURLRequest.CachePolicy.returnCacheDataElseLoad
        
        AF.request(request).validate(statusCode: 200..<300)
                .responseDecodable(of: T.self) { response in
            switch response.result {
            case .success(let value):
                onCompletion(value)

            case .failure(let error):
                onFailure(error)
            }
        }
    }
}

enum Resource {
    case breeds
    case dogsBy(Breed)
    
    fileprivate func buildEndpointURL() -> URL? {
        switch self {
        case .breeds:
            return Endpoint(path: "/breeds/list/all").value
    
        case let .dogsBy(breed):
            return Endpoint(path: "/breed/\(breed.title)/images").value
        }
    }
}

fileprivate struct Endpoint {
    let path: String
    
    var value: URL? {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "dog.ceo"
        components.path = "/api\(self.path)"

        return components.url
    }
}
