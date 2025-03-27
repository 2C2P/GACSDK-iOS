# GACSDK-iOS
The SDK is built for easy integration with GAC 2C2P.

## GACSDK Usage Guide  

## Introduction  
This guide provides instructions on how to configure and initialize the GACSDK in your iOS project.  

## Installation  

To install GACSDK using CocoaPods, add the following to your `Podfile`:  
```ruby
target 'MyApp' do
  pod 'GACSDK'
end
```
Then run:

pod install

## Usage
specifies the minimum supported iOS version of 14.0 in your Podfile section. Let me know if you'd like to make any other changes!

Ensure that GACSDK is added to your project If not, follow the installation instructions provided in the official documentation.

Configuration and Initialization

To configure and initialize the GACSDK, use the following code snippet:
```ruby
let config = GACSDKConfiguration.Builder()
    .setEnvironment("---Environment---")
    .setAuthorizationKey("---KEY_oauth---")
    .setGacAesIV("---KEY_AesIV---")
    .setGacAesKey("---KEY_AesKey---")
    .setGacPGPPassword("---KEY_Password---")
    .setGacPGPPublicKey("---KEY_PGPPublic---")
    .setGacPGPPrivateKey("---KEY_PGPPrivate---")
    .build()

GACSDKApp.initialize(with: config)
```
## Parameters Explanation

setEnvironment("---Environment---"): Specifies the environment (e.g., sandbox or production).\n
setAuthorizationKey("---KEY_oauth---"): Sets the authorization key for authentication.\n
setGacAesIV("---KEY_AesIV---"): Sets the AES IV for encryption.\n
setGacAesKey("---KEY_AesKey---"): Sets the AES key for encryption.\n
setGacPGPPassword("---KEY_Password---"): Sets the PGP password for decryption.\n
setGacPGPPublicKey("---KEY_PGPPublic---"): Sets the PGP public key for encryption.\n
setGacPGPPrivateKey("---KEY_PGPPrivate---"): Sets the PGP private key for decryption.\n


## Registering a Wallet

To register a wallet using GACSDK, call the registerWallet method:
```ruby
GACSDKApp().registerWallet { result in
    switch result {
    case .success(let value):
        print("Register Success: \(value)")
    case .failure(let error):
        print("Register Failed: \(error.localizedDescription)")
    }
}
```

Handling Result

The registerWallet method returns a completion handler with a Result type:
Success (.success(walletInfo)): Contains the registered wallet details.
Failure (.failure(error)): Contains an error description if registration fails.


## Registering Liveness

After successfully registering a wallet, you can proceed with liveness registration:
```ruby
GACSDKApp().registerLiveness(customerImageBase64:String,completion: { result  in
    switch result {
    case .success(let result):
        print("Liveness Registration Success: \(result)")
    case .failure(let error):
        print("Liveness Registration Failed: \(error.localizedDescription)")
    }
}
```


Handling Result

The registerLiveness method returns a completion handler with a Result type:
Success (.success(walletInfo)): Contains the registered wallet details.
Failure (.failure(error)): Contains an error description if registration fails.

## Notes

Ensure all configuration values are correctly set before initializing the SDK.

If using production mode, replace .sandbox with .production.

Keep sensitive keys secure and do not expose them in public repositories.

Support

For further assistance, please refer to the official documentation or contact support.
