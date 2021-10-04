import Foundation

protocol Sharing {
    @discardableResult
    func post(message: String) -> Bool
}

class FBSharer: Sharing {
    func post(message: String) -> Bool {
        print("Message \(message) shared on Facebook")
        return true
    }
}

class TwitterSharer: Sharing {
    func post(message: String) -> Bool {
        print("Message \(message) shared on Twitter")
        return true
    }
}

extension RedditPoster: Sharing {
    func post(message: String) -> Bool {
        self.share(text: message, completionHandler: nil)
        return true
    }
}

public enum Platform: CustomStringConvertible {
    case facebook
    case twitter
    case reddit
    
    public var description: String {
        switch self {
        case .facebook:
            return "Facebook Sharer"
        case .twitter:
            return "Twitter Sharer"
        case .reddit:
            return "Reddit Sharer"
        }
    }
}

public class Sharer {
    private let services: [Platform: Sharing] = [
        .facebook: FBSharer(),
        .twitter: TwitterSharer(),
        .reddit: RedditPoster()
    ]
    
    public func share(message: String, serviceType: Platform) -> Bool {
        guard let service = services[serviceType] else { return false }
        
        let result = service.post(message: message)
        return result
        
    }
    
    public func shareEverywhere(message: String) {
        services.values.forEach { service in
            service.post(message: message)
        }
    }
}

let sharer = Sharer()
sharer.shareEverywhere(message: "First post!")
