import Foundation

public class RedditPoster {
    public init() {}
    
    public func share(text: String, completionHandler: ((Error?) -> Void)?) {
        print("Message \(text) posted to Reddit")
        completionHandler?(nil)
    }
}
