//
//  Request.swift
//  eisenhower
//
//  Created by Léo Riberon-Piatyszek on 15/01/2020.
//  Copyright © 2020 epitech. All rights reserved.
//

import Foundation

class Request {
    private let endpoint = "http://vps.lemartret.com:3000";
    
    func getUser(email: String, password: String) -> Void {
        // body parameters initialization
        let bodyParameters: Dictionary = [
            "login": email,
            "passord": password
        ];
        let jsonData = try? JSONSerialization.data(withJSONObject: bodyParameters, options: []);
        
        // URL Request initialization
        let session = URLSession.shared;
        guard let urlEndpoint = URL(string: self.endpoint + "/users/login") else { return }
        var urlRequest: URLRequest = URLRequest(url: urlEndpoint);
        urlRequest.httpMethod = "POST";
        urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type");
        let task = session.uploadTask(with: urlRequest, from: jsonData) { data, response, error in
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
                break;
            case 401:
                break;
            case 422:
                break;
            default:
                break;
            }
            let responseString = String(data: data, encoding: .utf8)
            print(responseString!);
        }
        task.resume();
    }
}
