//
//  UserEndPoints.swift
//  MVVM+DependencyInjection
//
//  Created by Bansi Hirpara on 2022-06-07.
//

enum UserEndPoints {
    case GetUser(Int)
}

extension UserEndPoints: RequestBuilder {
    var path: String {
        switch self {
        case .GetUser:
            return ""
        }
    }
    
    var method: RequestMethod {
        switch self {
        case .GetUser:
            return .get
        }
    }
    
    var bodyParams: [String : String]? {
        switch self {
        case .GetUser(let userCount):
            return ["results": "\(userCount)"]
        }
    }
}
