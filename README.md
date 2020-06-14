# Matrix

A Swift Package made for [[matrix]](https://matrix.org)

The SDK contains: `Matrix`, `MatrixClient`.

if you need all libraries simply import `MatrixSDK`

## Usage



### Matrix

The global implemtation of [matrix] spécifications.



### MatrixClient

To get started with a [matrix] client you can create a instance:
```Swift
let client = MatrixClient()
```
> This will create a client to communicate with the default `matrix.org` homeserver.


To communicate with another home server you need to specifie the protection space and a operation queue to create the client:
```Swift
/// The protection space for the domaine `exemple.com` 
let protectionSpace : URLProtectionSpace(host: "exemple.com", port: 443, protocol: "https", realm: nil, authenticationMethod: nil)

/// The matrix client to communicate with the `exemple.com` homeserver
let client = MatrixClient(protection: protectionSpace, operation: .main)

```
