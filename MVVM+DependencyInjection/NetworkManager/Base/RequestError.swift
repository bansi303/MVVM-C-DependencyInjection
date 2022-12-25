//
//  RequestError.swift
//  MVVM+DependencyInjection
//
//  Created by Bansi Hirpara on 2022-06-05.
//

enum ErrorType: Error {
    case decode
    case invalidURL
    case noResponse
    case unauthorized
    case unexpectedStatusCode
    case unknown
    case NoInternet
    case ModalParse
    case Server
    
    var customMessage: String {
        switch self {
        case .decode:
            return "Decode error"
        case .unauthorized:
            return "Session expired"
        default:
            return "Unknown error"
        }
    }
}

struct RequestError: Error {
    let type: ErrorType
    let httpStatus: Int
    let message: String
}
