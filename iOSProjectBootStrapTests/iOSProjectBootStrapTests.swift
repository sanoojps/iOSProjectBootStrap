//
//  iOSProjectBootStrapTests.swift
//  iOSProjectBootStrapTests
//
//  Created by carvak on 27/06/2020.
//  Copyright © 2020 0. All rights reserved.
//

import XCTest
@testable import iOSProjectBootStrap

class iOSProjectBootStrapTests: XCTestCase {
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testPathsToPath() {
        let path = ["go","here"].reduce("", { (result: String, path: String) -> String in
            if result.isEmpty {
                return path
            } else {
                return result + "/" + path
            }
        })
        
        XCTAssert(path == "go/here")
    }
    
    func testHttpUrlRequestProvider() {
        let httpRequestProvider = HTTPUrlRequestProvider()
            .url("https://example.com")
            .path("what","is","path")
            .error { (error: Error?) in
                XCTAssertNil(error)
        }
        .request()
        
        XCTAssertNotNil(httpRequestProvider)
    }
    
    func testHttpUrlRequestProviderError() {
        let httpRequestProvider = HTTPUrlRequestProvider()
            .url("")
            .path("","","")
            .error { (error: Error?) in
                XCTAssertNotNil(error)
        }
        .request()
        
        XCTAssertNil(httpRequestProvider)
    }
    
    func testURLComponents() {
        let url = "https://example.com"
        let path = "/what/is/path"
        var components = URLComponents.init(string: url)
        components?.path = path
        
        XCTAssertNotNil(components)
    }
    
    func testHttpUrlRequestProviderQueryParameters(){
        
        let queryParamters = [
            ("a","b"),
            ("c","d")
        ]
        
        let httpRequestProvider = HTTPUrlRequestProvider()
            .url("https://example.com")
            .path("what","is","path")
            .query(
                queryParamters[0]
        )
            .query(
                queryParamters[1]
        )
            .error { (error: Error?) in
                XCTAssertNil(error)
        }
        .request()
        
        XCTAssertNotNil(httpRequestProvider)
        XCTAssertNotNil(httpRequestProvider?.url)
        
    }
    
    
    func testHttpUrlRequestProviderSideLoadingRequest(){
        
        let url = "https://example.com"
        let path = "/what/is/path"
        var components = URLComponents.init(string: url)
        components?.path = path
        
        let request = URLRequest.init(url: components!.url!)
        
        
        let httpRequestProvider = HTTPUrlRequestProvider(request)
            .error { (error: Error?) in
                XCTAssertNil(error)
        }
        .request()
        
        
        XCTAssertNotNil(httpRequestProvider)
        XCTAssertNotNil(httpRequestProvider?.url)
        
    }
    
    func testHttpUrlRequestProviderSideLoadingNilRequest(){
        
        let httpRequest = HTTPUrlRequestProvider(nil)
            .error { (error: Error?) in
                XCTAssertNotNil(error)
        }
        .request()
        
        
        XCTAssertNil(httpRequest)
    }
    
    func testUrlRequestAppending(){
        
        let url = "https://example.com"
        let path = "/what/is/path"
        var httpRequest = URLRequest.init(url: URL.init(string: url)!)
        let newUrl = URL.init(string: path, relativeTo: httpRequest.url)
        httpRequest.url = newUrl
        
        XCTAssertNotNil(httpRequest)
    }
    
    
    func testUrlRequestKeypaths() {
        let url = "https://example.com"
        let path = "/what/is/path"
        
        var components = URLComponents.init(string: url)
//        components?[keyPath: \URLComponents.path] = path
        
        components?.dispatch(path: \URLComponents.path, data: path)
        components?.dispatch(path: \URLComponents.queryItems, data: [URLQueryItem(name: "a", value: "b")])
        
    }
    
}

protocol DispatchProviding {
    mutating func dispatch<State>(path:WritableKeyPath<Self,State>, data:State)
}

extension URLComponents: DispatchProviding {
    mutating func dispatch<State>(path: WritableKeyPath<URLComponents, State>, data: State) {
        switch data {
        case is String:
            self[keyPath: path] = data
            break
        case is [URLQueryItem]:
            self[keyPath: path] = data
        default:
            break
        }
    }

}


struct Action<Source,State> {
    var type: String
    var keyPath: WritableKeyPath<Source, State>
    var state: State
}

struct Store<Source: Hashable> {
   
}
