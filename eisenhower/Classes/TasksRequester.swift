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
    let token: String;
    
    init(token: String) {
        self.token = token;
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
    
    public func fetchTasks() throws -> [String: Any] {
        // URL Request initialization
        let urlEndpoint = createUrlEndpoint(route: "/tasks");
        let urlRequest = createRequest(endpoint: urlEndpoint, method: "GET", body: nil);
        return try await(handleRequest(request: urlRequest))
    }
    
    public func fetchTasks(parameters: [String: String]?) throws -> [String: Any] {
        // URL Request initialization
        var urlEndpoint: URL;
        let importance = parameters?["importance"]
        let urgence = parameters?["urgence"]
        urlEndpoint = createUrlEndpoint(route: "/tasks?urgence=\(urgence!)&importance=\(importance!)")
        //urlEndpoint = createUrlEndpoint(route: "/tasks");
        let urlRequest = createRequest(endpoint: urlEndpoint, method: "GET", body: nil);
        return try await(handleRequest(request: urlRequest))
    }
    
    public func fetchTasksNumber(parameters: [String: String]) throws -> [String: Any] {
        // URL Request initialization
        let importance = parameters["importance"]
        let urgence = parameters["urgence"]
        let urlEndpoint = createUrlEndpoint(route: "/tasks/total?urgence=\(urgence!)&importance=\(importance!)")
        let urlRequest = createRequest(endpoint: urlEndpoint, method: "GET", body: nil);
        return try await(handleRequest(request: urlRequest))
    }
    
    public func fetchRemovedTasks() throws -> [String: Any] {
        // URL Request initialization
        let urlEndpoint = createUrlEndpoint(route: "/tasks/history")
        let urlRequest = createRequest(endpoint: urlEndpoint, method: "GET", body: nil);
        return try await(handleRequest(request: urlRequest))
    }
    
    public func fetchRemovedTasks(parameters: [String: String]?) throws -> [String: Any] {
        // URL Request initialization
        let importance = parameters?["importance"]
        let urgence = parameters?["urgence"]
        let urlEndpoint = createUrlEndpoint(route: "/tasks/history?urgence=\(urgence!)&importance=\(importance!)")
        let urlRequest = createRequest(endpoint: urlEndpoint, method: "GET", body: nil);
        return try await(handleRequest(request: urlRequest))
    }
    
    public func deleteTask(id: Int) -> Void {
        // URL Request initialization
        let urlEndpoint = createUrlEndpoint(route: "/tasks/" + String(id))
        let urlRequest = createRequest(endpoint: urlEndpoint, method: "DELETE", body: nil);
        handleRequest(request: urlRequest)
    }
    
    func updateTask(id: Int, urgent: Int, important: Int, title: String, description: String, deadline: Date) throws -> Void {
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
        handleRequest(request: urlRequest);
    }
    
    func createTask(urgence: Int, importance: Int, title: String, description: String, deadline: Date) throws -> Void {
        struct newInformations: Codable {
            var urgence: Int;
            var importance: Int;
            var title: String;
            var description: String;
            var deadline: String;
            var status: String;
        }
        
        let formatter = ISO8601DateFormatter()
        
        // body parameters initialization
        let bodyData = newInformations(urgence: urgence, importance: importance, title: title, description: description, deadline: formatter.string(from: deadline), status: "open");
        guard let jsonData = try? JSONEncoder().encode(bodyData) else { throw ErrorApi.MissingParameter };
        
        // URL Request initialization
        let urlEndpoint = createUrlEndpoint(route: "/tasks/")
        let urlRequest = createRequest(endpoint: urlEndpoint, method: "POST", body: jsonData);
        handleRequest(request: urlRequest)
    }
    
    func deleteAllTasks() -> Void {
        let urlEndpoint = createUrlEndpoint(route: "/tasks/all")
        let urlRequest = createRequest(endpoint: urlEndpoint, method: "DELETE", body: nil);
        handleRequest(request: urlRequest)
    }
}
