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

post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '14.0'
      config.build_settings['BUILD_LIBRARY_FOR_DISTRIBUTION'] = 'YES'
    end
  end
end

```

In Xcode, go to your project's Build Settings menu. In the Build Options section, set the property ENABLE_USER_SCRIPT_SANDBOXING to 'No'.

## Add Camera Permission in Info.plist

Add NSCameraUsageDescription to specify a message that will be displayed when your app asks for camera access.
```ruby
<key>NSCameraUsageDescription</key>
<string>We need access to your camera to...</string>
```

Then run:
```ruby
pod install
```

## Usage
Specifies the minimum supported iOS version of 14.0 in your Podfile section.

Ensure that GACSDK is added to your project If not, follow the installation instructions provided in the official documentation.

Configuration and Initialization

To configure and initialize the GACSDK, use the following code snippet:
```ruby
let config = GACSDKConfiguration.Builder()
    .setEnvironment("---Environment---")
    .setAuthorizationKey("---KEY_oauth---")
    .setAesIV("---KEY_AesIV---")
    .setAesKey("---KEY_AesKey---")
    .setPGPPassword("---KEY_Password---")
    .setPGPPublicKey("---KEY_PGPPublic---")
    .setPGPPrivateKey("---KEY_PGPPrivate---")
    .build()

GACSDKAPP.initialize(with: config)
```
## Parameters Explanation

setEnvironment("---Environment---"): Specifies the environment (e.g., sandbox or production).<br/>
setAuthorizationKey("---KEY_oauth---"): Sets the authorization key for authentication.<br/>
setAesIV("---KEY_AesIV---"): Sets the AES IV for encryption.<br/>
setAesKey("---KEY_AesKey---"): Sets the AES key for encryption.<br/>
setPGPPassword("---KEY_Password---"): Sets the PGP password for decryption.<br/>
setPGPPublicKey("---KEY_PGPPublic---"): Sets the PGP public key for encryption.<br/>
setPGPPrivateKey("---KEY_PGPPrivate---"): Sets the PGP private key for decryption.<br/>


## Registering a Wallet

To register a wallet using GACSDK, call the registerWallet method:
```ruby
GACSDKAPP().registerWallet { result in
        switch result {
           case .success(let response):
                print("Registration Success: \(response)")
              
           case .failure(let error):
                print("Registration Failed: \(error)")
           default : break
                
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
GACSDKAPP().registerLiveness(customerImageBase64:String,completion: { result  in
        switch result {
           case .success(let response):
                print("Registration Liveness Success: \(response)")
           case .failure(let error):
                print("Registration Liveness Failed: \(error)")
            default : break
                
        }
})
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
