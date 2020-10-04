//
//  Router.swift
//  mapsTest
//
//  Created by Андрей Садовщиков on 03.10.2020.
//

import Foundation
import Alamofire

enum Router: URLRequestConvertible {
    
    private var basePath: String {
        switch self {
        case .getAuth: return
             "https://test.globars.ru"
        case .getSession: return
             "http://test.globars.ru"
        case .getUnits: return
             "http://test.globars.ru"
        }
    }
    
    case getAuth(login: String, password: String)
    case getSession
    case getUnits(id: String)
    
    private var path: String {
        switch self {
        case .getAuth: return
            "/api/auth/login"
        case .getSession: return
            "/api/tracking/sessions"
        case .getUnits(let id): return
            "/api/tracking/units/" + id
        }
    }
    
    private var method: HTTPMethod {
        switch self {
        case .getAuth: return
            .post
        case .getSession: return
            .post
        case .getUnits: return
            .post
        }
    }
    
    private var parameters: [String : String] {
        switch self {
        case .getAuth(let login, let password): return
            ["username" : login, "password" : password]
        case .getSession: return
            [:]
        case .getUnits: return
            [:]
        }
    }

    
    func asURLRequest() throws -> URLRequest {
        let url = try basePath.asURL()
        var urlRequest = URLRequest(url: url.appendingPathComponent(path))
        urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")

        urlRequest.method = method
        if !parameters.isEmpty
        {
            urlRequest.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: [])
        }
        
        switch self {
        case .getAuth:
            return try URLEncoding.queryString.encode(urlRequest, with: parameters)
        case .getSession:
            return try URLEncoding.default.encode(urlRequest, with: parameters)
        case .getUnits:
            return try URLEncoding.default.encode(urlRequest, with: parameters)
            
        }
        
        
    }
}
