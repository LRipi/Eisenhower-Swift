//
//  Request.swift
//  eisenhower
//
//  Created by Léo Riberon-Piatyszek on 15/01/2020.
//  Copyright © 2020 epitech. All rights reserved.
//

import Foundation
import AwaitKit

class EisenhowerRequester: Requester {
    func login(email: String, password: String) throws -> [String: Any] {
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
    
    func register(email: String, password: String, name: String) throws -> [String: Any] {
        struct register: Codable {
            var login: String;
            var password: String;
            var name: String;
        }
        // body parameters initialization
        let bodyData = register(login: email, password: password, name: name);
        guard let jsonData = try? JSONEncoder().encode(bodyData) else { throw ErrorApi.MissingParameter };
        
        // URL Request initialization
        let urlEndpoint = createUrlEndpoint(route: "/users/create")
        let urlRequest = createRequest(endpoint: urlEndpoint, method: "POST", body: jsonData);
        return try await(handleRequest(request: urlRequest))
    }
    
    func passwordForgotten(email: String) throws -> [String: Any] {
        struct passwordForgotten: Codable {
            var login: String;
        }
        // body parameters initialization
        let bodyData = login(login: email);
        guard let jsonData = try? JSONEncoder().encode(bodyData) else { throw ErrorApi.MissingParameter };
        
        // URL Request initialization
        let urlEndpoint = createUrlEndpoint(route: "/users/forgotten")
        let urlRequest = createRequest(endpoint: urlEndpoint, method: "POST", body: jsonData);
        return try await(handleRequest(request: urlRequest))
    }
}
