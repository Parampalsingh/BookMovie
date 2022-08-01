//
//  NetworkCall.swift
//  BookMyMovie
//
//  Created by Parampal Singh on 30/07/22.
//

import Foundation

class NetworkManager {
    
   // typealias ResponseHandler = (ServerResponse<T>) -> ()
    typealias Parameters = [String:Any]
    typealias HTTPHeaders = [String:String]
    
    enum HTTPMethod: String {
        case post = "POST"
        case get = "GET"
    }
    
//    class var isConnected: Bool {
////        let reachability = Reachability.forInternetConnection()
//        let status = reachability?.currentReachabilityStatus()
//        return status != .NotReachable
//    }
    
    //MARK: Post Request
    class func post<T: Codable>(_ type: T.Type, webpath: WebPath, params: Parameters = [:], headers: HTTPHeaders = [:], completion: @escaping (ServerResponse<T>) -> ()) {
        
        guard let url = URL(string: webpath.path) else {
            completion(.failure(.invalidUrl))
            return
        }
        
       // let headers = httpHeaders.merging(headers) { (_, new) in new }
        debugPrintRequest(webPath: webpath.path, method: .post, params: params, headers: headers)
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        let boundary = "Boundary-\(UUID().uuidString)"
        let body = generateMultipartFormDataBody(boundary: boundary, params: params)
        request.httpBody = body
        request.addValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        self.networkCall(type,request: request, completion: completion)
    }
    
    //MARK: Get Request
    class func get<T: Codable>(_ type: T.Type, webpath: WebPath, params: Parameters = [:], headers: HTTPHeaders = [:], completion: @escaping (ServerResponse<T>) -> ()) {
        
        let queryString = params.keys.reduce("?") { k1, k2 in
            let value = "\(params[k2]!)".addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
            return k1 + "\(k2)=\(value)&"
        }
        
        guard let url = URL(string: webpath.path + queryString) else {
            completion(.failure(.invalidUrl))
            return
        }
        
        debugPrintRequest(webPath: webpath.path, method: .post, params: params, headers: headers)
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers
        self.networkCall(type,request: request, completion: completion)
        
    }
}
 
private extension NetworkManager {
    
    class func networkCall<T: Codable>(_ type: T.Type, request: URLRequest, completion: @escaping (ServerResponse<T>) -> ()) {
        let session = URLSession.shared
        let task = session.dataTask(with: request) { data, response, error in
            if let data = data {
                self.debugPrintResponse(data: data)
                if let model = try? JSONDecoder().decode(T.self, from: data) {
                    completion(.success(model))
                } else {
                    completion(.failure(.serialization))
                }
            } else if let error = error {
                completion(.failure(.other(error.localizedDescription)))
            } else {
                completion(.failure(.noResponse))
            }
        }
        task.resume()
    }
    
    class func generateMultipartFormDataBody(boundary: String, params: [String: Any]) -> Data? {
        
        let parameters: [[String: String]] = params.keys.compactMap {
            guard let value = params[$0] else { return nil }
            return ["key": $0,
                    "value": "\(value)",
                    "type": "text"]
        }
        
        var body = ""
        for param in parameters {
            let paramName = param["key"]!
            body += "--\(boundary)\r\n"
            body += "Content-Disposition:form-data; name=\"\(paramName)\""
            if param["contentType"] != nil {
                body += "\r\nContent-Type: \(param["contentType"]!)"
            }
            let paramType = param["type"]!
            if paramType == "text" {
                let paramValue = param["value"]!
              body += "\r\n\r\n\(paramValue)\r\n"
            }
        }
        body += "--\(boundary)--\r\n";
        return body.data(using: .utf8)
    }
}

private extension NetworkManager {
    
    //MARK: Debug Request
    class func debugPrintRequest(webPath: String, method: HTTPMethod, params: Parameters, headers: HTTPHeaders) {
        print("url: \(webPath)")
        print("method: \(method)")
        print("headers: \(headers)")
        if let bodydata = try? JSONSerialization.data(withJSONObject: params, options: .prettyPrinted) {
            let body = String(data: bodydata, encoding: .ascii)
            print("body: \(body ?? "")")
        }
    }
    
    //MARK: Debug Response
    class func debugPrintResponse(data: Data) {
        guard let object = try? JSONSerialization.jsonObject(with: data) else { return }
        if let response = object as? [String:Any] {
            if let responsedata = try? JSONSerialization.data(withJSONObject: response, options: .prettyPrinted) {
                let response = String(data: responsedata, encoding: .ascii)
                print("response: \(response ?? "")")
            }
        }
        else if let response = object as? Array<Any> {
            print("response array: \(response)")
        }
        else if let response = object as? String {
            print("response string: \(response)")
        }
        else if let response = object as? Int {
            print("response number: \(response)")
        } else if let response = object as? Bool {
            print("response boolean: \(response)")
        } else {
            print("response n/a: \(object)")
        }
    }
}
