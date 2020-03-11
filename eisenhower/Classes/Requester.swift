//
//  Requester.swift
//  eisenhower
//
//  Created by Léo Riberon-Piatyszek on 21/01/2020.
//  Copyright © 2020 epitech. All rights reserved.
//

import Foundation
import PromiseKit

enum ErrorApi: Error {
    case MissingParameter;
    case NotFound;
    case DuplicateEntry;
    case AuthenticationFailure;
    case NoJwt;
    case Unknown;
}

class Requester {
    let endpoint = "http://vps.lemartret.com:3000";
    
    public func createUrlEndpoint(route: String) -> URL {
        return URL(string: self.endpoint + route)!;
    }
    
    public func createRequest(endpoint: URL, method: String, body: Data?) -> URLRequest {
        var urlRequest: URLRequest = URLRequest(url: endpoint);
        urlRequest.httpMethod = method;
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type");
        urlRequest.setValue("application/json", forHTTPHeaderField: "Accept");
        if (method == "POST" || method == "PUT" || method == "PATCH") {
            urlRequest.httpBody = body;
        }
        return urlRequest;
    }
    
    public func handleRequest(request: URLRequest) -> Promise<Dictionary<String, AnyObject>> {
        return Promise<Dictionary<String, AnyObject>> { seal in
            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                guard let data = data,
                    let httpResponse = response as? HTTPURLResponse,
                    error == nil else {
                        print(error ?? "Unknown Error.");
                        return;
                    }
                switch httpResponse.statusCode {
                case 200 ..< 300:
                    if (httpResponse.statusCode != 204) {
                        let responseJSON = try? JSONSerialization.jsonObject(with: data, options: [])
                        if let responseJSON = responseJSON as? [String: Any] {
                            return seal.fulfill(responseJSON as [String : AnyObject])
                        }
                    }
                    break;
                case 401:
                    print("Auth failed")
                    return seal.reject(ErrorApi.AuthenticationFailure)
                case 403:
                    print("No JWT")
                    return seal.reject(ErrorApi.NoJwt)
                case 404:
                    print("Not Found")
                    return seal.reject(ErrorApi.NotFound)
                case 409:
                    print("Duplicate entry")
                    return seal.reject(ErrorApi.DuplicateEntry)
                case 422:
                    print("Missing Args")
                    return seal.reject(ErrorApi.MissingParameter)
                default:
                    print("WTF")
                    return seal.reject(ErrorApi.Unknown)
                }
            }
            task.resume()
        }
    }
}
