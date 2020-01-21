//
//  Request.swift
//  eisenhower
//
//  Created by Léo Riberon-Piatyszek on 15/01/2020.
//  Copyright © 2020 epitech. All rights reserved.
//

import Foundation
import PromiseKit
import AwaitKit

enum ErrorApi: Error {
    case MissingParameter;
    case NotFound;
    case DuplicateEntry;
    case AuthenticationFailure;
    case NoJwt;
    case Unknown;
}

class Request {
    private let endpoint = "http://vps.lemartret.com:3000";
    
    private func createUrlEndpoint(route: String) -> URL {
        return URL(string: self.endpoint + route)!;
    }
    
    private func createRequest(endpoint: URL, method: String, body: Data) -> URLRequest {
        var urlRequest: URLRequest = URLRequest(url: endpoint);
        urlRequest.httpMethod = method;
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type");
        urlRequest.setValue("application/json", forHTTPHeaderField: "Accept");
        if (method == "POST") {
            urlRequest.httpBody = body;
        }
        return urlRequest;
    }
    
    private func handleRequest(request: URLRequest) -> Promise<[String: Any]> {
        return Promise<[String: Any]> { seal in
            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                if (error != nil) {
                    print(error!);
                    return;
                }
                guard let data = data,
                    let httpResponse = response as? HTTPURLResponse,
                    error == nil else {
                        print(error ?? "Unknown Error.");
                        return;
                    }
                switch httpResponse.statusCode {
                case 200:
                    let responseJSON = try? JSONSerialization.jsonObject(with: data, options: [])
                    if let responseJSON = responseJSON as? [String: Any] {
                        return seal.fulfill(responseJSON)
                    }
                    break;
                case 401:
                    return seal.reject(ErrorApi.AuthenticationFailure)
                case 422:
                    return seal.reject(ErrorApi.MissingParameter)
                default:
                    return seal.reject(ErrorApi.Unknown)
                }
            }
            task.resume()
        }
    }
    
    func getUser(email: String, password: String) throws -> [String: Any] {
        struct login: Codable {
            var login: String;
            var password: String;
        }
        // body parameters initialization
        let bodyData = login(login: email, password: password);
        guard let jsonData = try? JSONEncoder().encode(bodyData) else { throw ErrorApi.MissingParameter };
        
        // URL Request initialization
        let urlEndpoint = createUrlEndpoint(route: "/users/login")
        let urlRequest = createRequest(endpoint: urlEndpoint, method: "POST", body: jsonData);
        return try await(handleRequest(request: urlRequest))
    }
}
