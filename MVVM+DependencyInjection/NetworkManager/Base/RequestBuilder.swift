//
//  RequestHandler.swift
//  MVVM+DependencyInjection
//
//  Created by Bansi Hirpara on 2022-06-05.
//
import Foundation

protocol RequestBuilder {
    var path: String { get }
    var method: RequestMethod { get }
    var header: [String: String]? { get }
    var bodyParams: [String: String]? { get }
    
    func buildRequest() -> URLRequest?
}

extension RequestBuilder {
    
    var header: [String: String]? {
        return [
            "Authorization": "Bearer \(APIConfig.authorizationToken)",
            "Content-Type": "application/json;charset=utf-8",
            "x-api-key": APIConfig.xApiKey
        ]
    }
    
    func buildRequest() -> URLRequest? {
        if let urlString = (APIConfig.baseURL + path).addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed), var url = URL(string: urlString) {
            var urlRequest = URLRequest(url: url)
            setHeaders(request: &urlRequest)
            urlRequest.httpMethod = method.rawValue
            
            switch method {
            case .get:
                if let bodyParams = bodyParams, bodyParams.keys.count > 0 {
                    url = setQueryParams(parameters: bodyParams, url: url)
                    urlRequest = URLRequest(url: url)
                }
            case .post, .put, .delete, .patch:
                if let bodyParams = bodyParams, bodyParams.keys.count > 0 {
                    let bodyData = try? JSONSerialization.data(
                        withJSONObject: bodyParams,
                        options: []
                    )
                    urlRequest.httpBody = bodyData
                }
            }
//            LoggerHelper.log("Request url: \(urlRequest)")
//            LoggerHelper.log("Request params: \(method == .POST ? params : [:])")
            return urlRequest
        }
        return nil
    }
    
    /// To append query parameters if http request method is GET
    ///
    /// - Parameter parameters -  Query parameters, collection of key-value pairs
    /// - Returns: Url with query parametes apeended Ex: http://www.test.com?param1=a&param2=b
    func setQueryParams(parameters:[String: Any], url: URL) -> URL {
        var components = URLComponents(url: url, resolvingAgainstBaseURL: false)
        components?.queryItems = parameters.map { element in URLQueryItem(name: element.key, value: String(describing: element.value) ) }
        return components?.url ?? url
    }
    
    /// To  append header to every request
    ///
    /// - Parameter request -  url request to append header to
    func setHeaders(request: inout URLRequest) {
        for (key, value) in (header ?? [:]) {
            request.setValue(value, forHTTPHeaderField: key)
        }
//        request.setValue(APIConfig.xApiKey, forHTTPHeaderField: "x-api-key")
//        request.setValue(APIConfig.authorizationToken, forHTTPHeaderField: "Authorization")
//        request.setValue("applcation/json", forHTTPHeaderField: "content-type")
    }
}
