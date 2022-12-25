import Foundation

enum APIEnvironment {
    case development
    case staging
    case production
    
    func baseURL () -> String {
        return "https://\(domain())/\(route())"
    }
    
    func domain() -> String {
        switch self {
        case .development:
            return "randomuser.me"
        case .staging:
            return "randomuser.me"
        case .production:
            return "randomuser.me"
        }
    }
    
    func route() -> String {
        return "api/"
    }
}

struct APIConfig {
    static let appEnvironment = (AppConfig.environment == AppEnvironment.development) ? APIEnvironment.development : APIEnvironment.production
    static let xApiKey = ""
    static let clientKey = ""
    static let baseURL = appEnvironment.baseURL()
    static var authorizationToken = ""
}
