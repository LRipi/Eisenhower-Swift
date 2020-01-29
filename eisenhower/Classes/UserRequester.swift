//
//  UserRequester.swift
//  eisenhower
//
//  Created by Léo Riberon-Piatyszek on 21/01/2020.
//  Copyright © 2020 epitech. All rights reserved.
//

import Foundation
import AwaitKit

final class UserRequester: Requester {
    let token: String;
    
    init(token: String) {
        self.token = token
    }
    
    public override func createRequest(endpoint: URL, method: String, body: Data?) -> URLRequest {
        var urlRequest: URLRequest = URLRequest(url: endpoint);
        urlRequest.httpMethod = method;
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type");
        urlRequest.setValue("application/json", forHTTPHeaderField: "Accept");
        urlRequest.setValue(self.token, forHTTPHeaderField: "x-access-token")
        if (method == "POST" || method == "PUT" || method == "PATCH") {
            urlRequest.httpBody = body;
        }
        return urlRequest;
    }
    
    func me() throws -> [String: Any] {
        // URL Request initialization
        let urlEndpoint = createUrlEndpoint(route: "/users/login")
        let urlRequest = createRequest(endpoint: urlEndpoint, method: "GET", body: nil);
        return try await(handleRequest(request: urlRequest))
    }
    
    func updateProfile(email: String, password: String, name: String) throws -> [String: Any] {
        struct newInformations: Codable {
            var login: String;
            var password: String;
            var name: String;
        }
        // body parameters initialization
        let bodyData = newInformations(login: email, password: password, name: name);
        guard let jsonData = try? JSONEncoder().encode(bodyData) else { throw ErrorApi.MissingParameter };
        
        // URL Request initialization
        let urlEndpoint = createUrlEndpoint(route: "/users")
        let urlRequest = createRequest(endpoint: urlEndpoint, method: "PUT", body: jsonData);
        return try await(handleRequest(request: urlRequest))
    }
    
    func deleteProfile() throws -> [String: Any] {
        // URL Request initialization
        let urlEndpoint = createUrlEndpoint(route: "/users")
        let urlRequest = createRequest(endpoint: urlEndpoint, method: "DELETE", body: nil);
        return try await(handleRequest(request: urlRequest))
    }
    
    func updatePassword(password: String) throws -> [String: Any] {
        struct newPassword: Codable {
            var password: String;
        }
        // body parameters initialization
        let bodyData = newPassword(password: password);
        guard let jsonData = try? JSONEncoder().encode(bodyData) else { throw ErrorApi.MissingParameter };
        
        // URL Request initialization
        let urlEndpoint = createUrlEndpoint(route: "/users/password")
        let urlRequest = createRequest(endpoint: urlEndpoint, method: "PATCH", body: jsonData);
        return try await(handleRequest(request: urlRequest))
    }
}
