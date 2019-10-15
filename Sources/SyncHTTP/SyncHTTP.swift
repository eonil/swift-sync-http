
import Foundation

public enum SyncHTTP {
    public enum Issue: Error {
        /// We couldn't parse supplied address as a URL.
        case badAddress
        /// I don't know why, Underlying `URLSession` worked in unexpected way.
        case internalClientError
    }
}
public extension SyncHTTP {
    /// Performs synchronous HTTP call.
    @discardableResult
    static func call(
        method:String,
        address:String,
        query: [URLQueryItem] = [],
        headers: [(name:String,value:String)] = [],
        body:Data = Data()) throws -> (status:Int, body:Data)
    {
        guard let u = URL(string: address) else { throw Issue.badAddress }
        var req = URLRequest(
            url: u,
            cachePolicy: .reloadIgnoringLocalAndRemoteCacheData,
            timeoutInterval: 10)
        req.httpMethod = method
        for (n,v) in headers {
            req.addValue(v, forHTTPHeaderField: n)
        }
        var reply = Data()
        /// We need to make a session object.
        /// This is key to make this work. This won't work with shared session.
        let conf = URLSessionConfiguration.ephemeral
        let sess = URLSession(configuration: conf)
        let task = sess.dataTask(with: req) { data, _, _ in
            reply = data ?? Data()
        }
        task.resume()
        while task.state != .completed {
            Thread.sleep(forTimeInterval: 0.1)
        }
        FileHandle.standardOutput.write(reply)
        if let err = task.error {
            throw err
        }
        guard let res = task.response as? HTTPURLResponse else { throw Issue.internalClientError }
        return (res.statusCode,reply)
    }
}
public extension SyncHTTP {
    /// Convenient method to perform GET string request simply.
    /// - Note:
    ///     This does not consider HTTP status into success/failure.
    ///     Returning result can be non 2xx status.
    static func get(address:String) throws -> String {
        let reply = try call(method: "GET", address: address, body: Data()).body
        return String(data: reply, encoding: .utf8) ?? ""
    }
    /// Convenient method to perform POST string request simply.
    /// - Parameter query:
    ///     Query parameters will be attached at the end of URL.
    ///     Note that this is NOT a url-encoded post form.
    ///     You need to encode them yourself and supply them as `body` parameter.
    /// - Note:
    ///     This does not consider HTTP status into success/failure.
    ///     Returning result can be non 2xx status.
    static func post(address:String, body:String) throws {
        try call(method: "POST", address: address, body: body.data(using: .utf8) ?? Data())
    }
}
