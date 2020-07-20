//
//  RequestEntity.swift
//  iOSProjectBootStrap
//
//  Created by carvak on 18/07/2020.
//  Copyright © 2020 0. All rights reserved.
//

import Foundation

// Base Protocol To be used by all classes that
// represent an object
protocol RequestEntity {
    // update or return final request
    mutating func request() -> Self?
}

protocol UrlRequestEntity: RequestEntity {
    // read only properties
    var requestUrl: String {get}
    // read-write properties
    var requestPath: [String] {get set}
    var requestQuery: [(String,String)] {get set}
    var requestHeaders: [String:String] {get set}
    var requestHttpMethod: String? {get set}
    var requestHttpBody: Data? {get set}
    var requestHttpBodyStream: InputStream? {get set}
    
    // init
    init?(url: String)
}

//MARK: - RequestURLComponents helper
/// Genarate URL from URLComponents
extension URLRequest {
    private struct RequestURLComponents {
        static var path: [String] = []
        static var queryParamters: [(String,String)] = []
        static var url: String = ""
        private static var urlComponents: URLComponents?
        
        static func fullyFormedUrl() -> URL? {
            // url
            var url = self.url
            if let lastChar =  url.last,
                lastChar != "/" {
                // add backslash
                url += "/"
            }
            self.urlComponents = URLComponents(string: url)
            //path
            let path = self.path.reduce("", { (result: String, path: String) -> String in
                return result + "/" + path
            })
            self.urlComponents?.path = path
            // query
            let urlQueryItems = self.queryParamters.map { (query:(key: String, value:String)) -> URLQueryItem in
                return URLQueryItem(name: query.key, value: query.value)
            }
            self.urlComponents?.queryItems = urlQueryItems
            return self.urlComponents?.url
        }
        
        static func reset() {
            self.path.removeAll()
            self.queryParamters.removeAll()
            self.url = ""
            self.urlComponents = nil
        }
        
    }
}

//MARK: - UrlRequestEntity
extension URLRequest: UrlRequestEntity {
    
    mutating func request() -> URLRequest? {
        // update request
        self.url = RequestURLComponents.fullyFormedUrl()!
        // reset
        RequestURLComponents.reset()
        return self
    }
    
    init?(url: String) {
        RequestURLComponents.url = url
        if let finalUrl = URL(string: url) {
            self.init(
                url: finalUrl,
                cachePolicy: .useProtocolCachePolicy,
                timeoutInterval: 60.0
            )
        } else {
            return nil
        }
    }
    
    var requestUrl: String {
        return self.url?.absoluteString ?? ""
    }
    
    var requestPath: [String] {
        set {
            RequestURLComponents.path.append(contentsOf: newValue)
        }
        get {
            return RequestURLComponents.path
        }
    }
    
    var requestQuery: [(String,String)] {
        set {
            RequestURLComponents.queryParamters.append(contentsOf: newValue)
        }
        get {
            return RequestURLComponents.queryParamters
        }
    }
    
    var requestHeaders: [String : String] {
        set {
            self.allHTTPHeaderFields = newValue
        }
        get {
            return self.allHTTPHeaderFields ?? [:]
        }
    }
    
    var requestHttpMethod: String? {
        set {
            self.httpMethod = newValue
        }
        get {
            return self.httpMethod
        }
    }
    
    var requestHttpBody: Data? {
        set {
            self.httpBody = newValue
        }
        get {
            return self.httpBody
        }
    }
    
    var requestHttpBodyStream: InputStream? {
        set {
            self.httpBodyStream = newValue
        }
        get {
            return self.httpBodyStream
        }
    }
}
