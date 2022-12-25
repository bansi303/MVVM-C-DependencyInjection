import Foundation

protocol HTTPClient {
    func sendRequest<T: Decodable>(request: RequestBuilder, responseModal: T.Type, completionHandler: @escaping (T?, RequestError?) -> ())
}

extension HTTPClient {

    func sendRequest<T: Decodable>(request: RequestBuilder, responseModal: T.Type, completionHandler: @escaping (T?, RequestError?) -> ()) {
        
        if !Reachability.isConnectedToNetwork() {
            completionHandler(nil, RequestError(type: ErrorType.NoInternet, httpStatus: 0, message: "ServiceError : The Internet connection appears to be offline"))
        }
        else {
            if let urlRequest = request.buildRequest() {
                URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
                    if let httpResponse = response as? HTTPURLResponse {
                        guard error == nil else {
//                            LoggerHelper.log("Response Error: \(String(describing: error))")
                            completionHandler(nil, RequestError(type: ErrorType.Server, httpStatus: httpResponse.statusCode, message: "ServiceError : \(error?.localizedDescription ?? "Unknown Error")"))
                            return
                        }
                        
                        guard let responseData = data else {
//                            LoggerHelper.log("Response Error: \(String(describing: error))")
                            completionHandler(nil, RequestError(type: ErrorType.Server, httpStatus: httpResponse.statusCode, message: "ServiceError : \(error?.localizedDescription ?? "Unknown Error")"))
                            return
                        }
                        
                        switch httpResponse.statusCode {
                        case 200...299:
                            DispatchQueue.main.async {
                                do {
                                    let decodedResponse = try JSONDecoder().decode(T.self, from: responseData)
    //                                LoggerHelper.log("Response Result: \(parsedResponse)")
                                    completionHandler(decodedResponse, nil)
                                } catch (let error) {
    //                                LoggerHelper.log("Response Error: \(error)")
                                    completionHandler(nil, (error as? RequestError))
                                }
                            }
                        case 401:
                            completionHandler(nil, RequestError(type: ErrorType.unauthorized, httpStatus: httpResponse.statusCode, message: "ServiceError : \(error?.localizedDescription ?? "Unknown Error")"))
                        default:
                            completionHandler(nil, RequestError(type: ErrorType.unexpectedStatusCode, httpStatus: httpResponse.statusCode, message: "ServiceError : \(error?.localizedDescription ?? "Unknown Error")"))
                        }
                    }
                    else{
                        print(error ?? "Outer error")
                    }
                }.resume()
            }
        }
    }
}
