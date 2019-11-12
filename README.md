# BaseNetworking
Network things simplifier

Пример использования:
1. Создаем `EndPoint`:
```swift
import Foundation
import BaseNetworkingLibrary

public enum InfoEndPoint {
    case root
}

extension InfoEndPoint: AppEndPointType {
    public typealias ResponseTypes = InfoRouteResponses
    public typealias RequestBodyTypes = Never
    
    public var path: String {
        switch self {
        case .root:
            return "info"
        }
    }
    
    public var httpMethod: HTTPMethod {
        switch self {
        case .root:
            return .get
        }
    }
    
    public var task: HTTPTask {
        switch self {
        case .root:
            return .request
        }
    }
    
    public var headers: HTTPHeaders? {
        switch self {
        case .root:
            return nil
        }
    }
}
```

2. Создаем `ApiRoute`:
```swift
import Foundation
import BaseNetworkingLibrary

final public class InfoApiRoute: ApiRoute {
    public typealias EndPoint = InfoEndPoint
    public typealias RootCompletion = ((_ result: Result<InfoRouteResponses.Root, Error>) -> Void)
    public let router = Router<EndPoint>()
    
    public func getServerInfo(completion: @escaping RootCompletion) {
        router.request(.root) { [unowned self] data, response, error in
            completion(self.defaultRequestHandler(data, response, error))
        }
    }
    
    public init() {}
}
```

3. Наслаждаемся качественным Network модулем без каких-либо сторонних библиотек и фреймворков
