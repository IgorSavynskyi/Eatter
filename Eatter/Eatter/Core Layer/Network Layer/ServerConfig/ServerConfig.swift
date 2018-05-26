import Foundation

private enum HostPath: String {
    case base = "https://public.je-apis.com"
}

enum EndPoint {
    static let restaurants = "/restaurants"
}

struct ServerConfig {
    let baseUrl: String
    let headers: HeadersDict
    let timeout: TimeInterval = 40.0    /// Global timeout for any request
    let emptyDataStatusCodes: Set<Int> = [204, 205]
    
    // MARK: - API
    static func defaultConfig() -> ServerConfig {
        return ServerConfig(baseUrl: HostPath.base.rawValue, headers: ServerConfig.defaultHeaders())
    }
    
    // MARK: - Private API
    private static func defaultHeaders() -> HeadersDict {
        return ["Accept-Tenant": "uk",
                "Accept-Language": "en-GB",
                "Authorization" : "Basic VGVjaFRlc3Q6bkQ2NGxXVnZreDVw",
                "Host": "public.je-apis.com"]
    }
    
}

