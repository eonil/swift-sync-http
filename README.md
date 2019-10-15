SyncHTTP
=========
Eonil, 2019.

[![Build Status](https://api.travis-ci.org/eonil/swift-sync-http.svg)](https://travis-ci.org/eonil/swift-sync-http)

Performs several HTTP calls synchronously in most reliable way.

- There are small needs for synchronous HTTP calls in Swift.
- Unfortunately `URLSession` is asynchronous only.
- There are several pitfalls to make it synchronous.

This library provide these features.

- Synchronous HTTP call using `URLSession`.
- This does not involve semaphore or lock.
    - Semaphores are likely to cause some subtle issues with `URLSession`.
    - Based on repeated thread sleeping.
- Carefully designed and tuned for short-running, CLI programs.
    - Never cached.
    - State-less.
    - Fails faster than default. 10 second timeout.
- Maybe doesn't work well in other situations.

- Future proof simple API.
    - Implementation can be replaced for better one later.
    - You don't have to change your code.

Getting Started
-------------------
Add Swift package.

    .package(url: "https://github.com/eonil/swift-sync-http", from: "0.0.0"),


Import.

    import SyncHTTP
    
And use.
    
    let reply = try SyncHTTP.get(address: "https://google.com")
    FileHandle.standardOutput.write(reply)


License & Credits
----------------------
Licensed under "MIT License".
Copyright(C) Eonil 2019. 
