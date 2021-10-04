import Foundation

// Ao compartilhar apenas com facebook e twitter, podemos utilizar o polimorfismo para implementarmos o share, porém, ao adicionarmos um "framework", com um código diferente para o compartilhamento com o reddit, precisamos adicionar uma condicional e fazer isso em um projeto real a complexidade pode ser muito alta e a manutenção pode ser custosa. Nesse caso precisamos usar o THE ADAPTER

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
    private lazy var redditPoster = RedditPoster()
    
    private let services: [Platform: Sharing] = [
        .facebook: FBSharer(),
        .twitter: TwitterSharer()
        //.reddit: RedditPoster() - não é possivel incluir pois não adota o protocolo Sharing, portanto terá que ser tratado separadamente
    ]
    
    public func share(message: String, serviceType: Platform) -> Bool {
        if serviceType == .reddit {
            redditPoster.share(text: message, completionHandler: nil)
            return true
        } else {
            guard let service = services[serviceType] else { return false }
        
            let result = service.post(message: message)
            return result
        }
    }
    
    public func shareEverywhere(message: String) {
        services.values.forEach { service in
            service.post(message: message)
        }
        redditPoster.share(text: message, completionHandler: nil)
    }
}

let sharer = Sharer()
sharer.shareEverywhere(message: "First post!")
