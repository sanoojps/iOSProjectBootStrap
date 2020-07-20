//
//  RequestProvider.swift
//  iOSProjectBootStrap
//
//  Created by carvak on 28/06/2020.
//  Copyright © 2020 0. All rights reserved.
//

import Foundation

public let RequestProviderErrorDomain: String = "com.RequestProvider.error"

typealias ErrorHandler = (Error?)->()

protocol RequestProvider {
    associatedtype Entity: RequestEntity
    var requestEntity: Entity? {get}
    var error: ErrorHandler? {get}
    func error(_ error: @escaping ErrorHandler) -> Self
    mutating func request() -> Entity?
    // for covenience there is a provision
    // to pass on a preconfigured requestEntity
    // takes the most precedence
    init(_ requestEntity: @autoclosure () -> Entity?)
}

protocol UrlRequestProvider: RequestProvider where Entity:UrlRequestEntity {
    func url(_ url: String) -> Self
    func path(_ path: String...) -> Self
    func query(_ queryParamters: (String,String)...) -> Self
    func httpMethod(_ httpMethod: String) -> Self
    func headers(_ headers: (String,String)...) -> Self
    func httpBody(_ httpBody: Data) -> Self
    func httpBodyStream(_ httpBodyStream: InputStream) -> Self
}

class HTTPUrlRequestProvider: UrlRequestProvider {
    
    func request() -> URLRequest? {
        return self.requestEntity?.request()
    }
    
    typealias Entity = URLRequest
    
    required init(_ requestEntity: @autoclosure () -> Entity? = nil) {
        self.requestEntity = requestEntity()
    }

    // read only properties
    private(set) var url: String = ""
    private(set) var error: ErrorHandler? = nil
    private(set) var requestEntity: Entity?
    
    func url(_ url: String) -> Self {
        self.url = url
//        // ckeck for trailing backslash
//        if let lastChar =  url.last,
//            lastChar != "/" {
//            // add backslash
//            self.url += "/"
//        }
//        self.urlComponents = URLComponents.init(string: url)
        
        if self.requestEntity == nil {
            self.requestEntity = Entity(url: url)
        }
        return self
    }
    
    func path(_ path: String...) -> Self {
//        let path = path.reduce("", { (result: String, path: String) -> String in
//            return result + "/" + path
//        })
//        self.urlComponents?.path = path
        
        self.requestEntity?.requestPath = path
        return self
    }
    
    func query(_ queryParamters: (String,String)...) -> Self {
//        let urlQueryItems = queryParamters.map { (query:(key: String, value:String)) -> URLQueryItem in
//            return URLQueryItem(name: query.key, value: query.value)
//        }
//        guard var queryItems = self.urlComponents?.queryItems else {
//            self.urlComponents?.queryItems = urlQueryItems
//            return self
//        }
//        queryItems.append(contentsOf: urlQueryItems)
//        self.urlComponents?.queryItems = queryItems
        
        self.requestEntity?.requestQuery = queryParamters
        return self
    }
    
    func error(_ error: @escaping ErrorHandler) -> Self {
        self.error = error
        return self
    }

    func httpBodyStream(_ httpBodyStream: InputStream) -> Self {
        self.requestEntity?.requestHttpBodyStream = httpBodyStream
        return self
    }
    
    func httpMethod(_ httpMethod: String) -> Self {
        self.requestEntity?.requestHttpMethod = httpMethod
        return self
    }
    
    func headers(_ httpHeaders: (String, String)...) -> Self {
        self.requestEntity?.requestHeaders = httpHeaders.reduce(into: [:], { (result:inout [String:String], headers:(key:String, value:String)) in
            return result[headers.key] = headers.value
        })
        return self
    }
    
    func httpBody(_ httpBody: Data) -> Self {
        self.requestEntity?.requestHttpBody = httpBody
        return self
    }
    
//    func request() -> URLRequest? {
//        if self.requestEntity != nil {
//            return self.requestEntity?.request()
//        }
////        // Request is "nil"
////        // Propagate error
////
////        // error while creating a request via builder using
////        // url components
////        guard let _ = self.urlComponents?.url,
////            let _ = self.urlComponents?.host
////            else {
////                let error = NSError(
////                    domain: RequestProviderErrorDomain,
////                    code: 999999,
////                    userInfo: [
////                        NSLocalizedDescriptionKey :
////                        "Failed to create URL object from \(self.url) and \(self.urlComponents?.path ?? "")"
////                ])
////                self.error?(error)
////                return nil
////        }
//        
//        // all other errors
//        let error = NSError(
//            domain: RequestProviderErrorDomain,
//            code: 999998,
//            userInfo: [
//                NSLocalizedDescriptionKey :
//                "Unknown Error. Failed to create URL object"
//        ])
//        
//        self.error?(error)
//        return nil
//    }
    
}


func testHTTPRequestProvider() {
    let httpRequestProvider =
        HTTPUrlRequestProvider()
            .url("https://example.com")
            .path("what","is","path")
            .headers(("a","b"))
            .error { (error: Error?) in
                print(error as Any)
        }
        .request()
    
}

func testHTTPURLRequestProvider() {
    let httpRequestProvider =
        HTTPUrlRequestProvider(URLRequest.init(url: URL.init(string: "")!))
            .error { (error: Error?) in
                print(error as Any)
        }
        .request()
    
}


