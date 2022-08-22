//
//  URLSession+NetworkTransport.swift
//  
//
//  Created by Norman Barnard on 8/20/22.
//

import Foundation

public enum NetworkTransportError: Error {
    case badResponse(URLResponse)
    case badData(Error, Data)
}

public protocol NetworkTransport {
    func fetch<Payload: Decodable>(request: URLRequest) async throws -> Payload
}

extension URLSession {
    public func fetch<Payload: Decodable>(request: URLRequest) async throws -> Payload {
        let (data, response) = try await data(for: request)
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw NetworkTransportError.badResponse(response)
        }
        let jsonDecoder = JSONDecoder()
        do {
            return try jsonDecoder.decode(Payload.self, from: data)
        } catch {
            throw NetworkTransportError.badData(error, data)
        }
    }
}
