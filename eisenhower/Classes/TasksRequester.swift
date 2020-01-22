//
//  TasksRequester.swift
//  eisenhower
//
//  Created by Léo Riberon-Piatyszek on 21/01/2020.
//  Copyright © 2020 epitech. All rights reserved.
//

import Foundation
import AwaitKit

class TasksRequester: Requester {
    private var token: String;
    
    init(token: String) {
        self.token = token;
    }
    
    public override func createRequest(endpoint: URL, method: String, body: Data?) -> URLRequest {
        var urlRequest: URLRequest = URLRequest(url: endpoint);
        urlRequest.httpMethod = method;
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type");
        urlRequest.setValue("application/json", forHTTPHeaderField: "Accept");
        urlRequest.setValue("x-access-token", forHTTPHeaderField: self.token)
        if (method == "POST" || method == "PUT" || method == "PATCH") {
            urlRequest.httpBody = body;
        }
        return urlRequest;
    }
    
    public func fetchTasks(parameters: [String: Int]?) throws -> [String: Any] {
        // URL Request initialization
        let urlEndpoint = createUrlEndpoint(route: "/tasks/")
        let urlRequest = createRequest(endpoint: urlEndpoint, method: "GET", body: nil);
        return try await(handleRequest(request: urlRequest))
    }
    
    public func fetchTasksNumber(parameters: [String: Int]) throws -> [String: Any] {
        // URL Request initialization
        let urlEndpoint = createUrlEndpoint(route: "/tasks/total")
        let urlRequest = createRequest(endpoint: urlEndpoint, method: "GET", body: nil);
        return try await(handleRequest(request: urlRequest))
    }
    
    public func fetchRemovedTasks(parameters: [String: Int]?) throws -> [String: Any] {
        // URL Request initialization
        let urlEndpoint = createUrlEndpoint(route: "/tasks/history")
        let urlRequest = createRequest(endpoint: urlEndpoint, method: "GET", body: nil);
        return try await(handleRequest(request: urlRequest))
    }
    
    public func deleteTask(id: Int) throws -> [String: Any] {
        // URL Request initialization
        let urlEndpoint = createUrlEndpoint(route: "/tasks/" + String(id))
        let urlRequest = createRequest(endpoint: urlEndpoint, method: "DELETE", body: nil);
        return try await(handleRequest(request: urlRequest))
    }
    
    func updateTask(id: Int, urgent: Int, important: Int, title: String, description: String, deadline: Date) throws -> [String: Any] {
        struct newInformations: Codable {
            var urgent: Int;
            var important: Int;
            var title: String;
            var description: String;
            var deadline: Date;
        }
        // body parameters initialization
        let bodyData = newInformations(urgent: urgent, important: important, title: title, description: description, deadline: deadline);
        guard let jsonData = try? JSONEncoder().encode(bodyData) else { throw ErrorApi.MissingParameter };
        
        // URL Request initialization
        let urlEndpoint = createUrlEndpoint(route: "/tasks/" + String(id))
        let urlRequest = createRequest(endpoint: urlEndpoint, method: "PUT", body: jsonData);
        return try await(handleRequest(request: urlRequest))
    }
    
    func createTask(urgent: Int, important: Int, title: String, description: String, deadline: Date) throws -> [String: Any] {
        struct newInformations: Codable {
            var urgent: Int;
            var important: Int;
            var title: String;
            var description: String;
            var deadline: Date;
        }
        // body parameters initialization
        let bodyData = newInformations(urgent: urgent, important: important, title: title, description: description, deadline: deadline);
        guard let jsonData = try? JSONEncoder().encode(bodyData) else { throw ErrorApi.MissingParameter };
        
        // URL Request initialization
        let urlEndpoint = createUrlEndpoint(route: "/tasks/")
        let urlRequest = createRequest(endpoint: urlEndpoint, method: "POST", body: jsonData);
        return try await(handleRequest(request: urlRequest))
    }
}
