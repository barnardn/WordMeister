//
//  APIEndpoint.swift
//  
//
//  Created by Norman Barnard on 8/20/22.
//

import Foundation

public enum APIHeader {
    case contentType(String)
    case rapidAPIKey(String)
    case rapidAPIHost(String)

    public var asTuple: (String, String) {
        switch self {
            case .contentType(let contentType):
                return ("content-type", contentType)
            case .rapidAPIKey(let apiKey):
                return ("X-RapidAPI-Key", apiKey)
            case .rapidAPIHost(let host):
                return ("X-RapidAPI-Host", host)
        }
    }
}

public enum HTTPMethod: String {
    case get
    case post
    case put
    case delete
    case update

    var asString: String { self.rawValue }
}

public protocol Endpoint {
    var asRequest: URLRequest { get }
}

public struct APIEndpoint: Endpoint {
    public let host: URL
    public let path: String
    public let additionalHeaders: [APIHeader]?
    public let queryParameters: [URLQueryItem]?
    public let method: HTTPMethod

    internal init(
        host: URL,
        path: String,
        additionalHeaders: [APIHeader]? = nil,
        queryParameters: [URLQueryItem]? = nil,
        method: HTTPMethod = .get
    ) {
        self.host = host
        self.path = path
        self.additionalHeaders = additionalHeaders
        self.queryParameters = queryParameters
        self.method = method
    }

    public var asRequest: URLRequest {
        let requestURL = host.appending(path: path).appending(queryItems: queryParameters ?? [])
        var request = URLRequest(url: requestURL)
        request.httpMethod = method.asString
        additionalHeaders?.forEach {
            let (key, value) = $0.asTuple
            request.setValue(value, forHTTPHeaderField: key)
        }
        return request
    }

}

