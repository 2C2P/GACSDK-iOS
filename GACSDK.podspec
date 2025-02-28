
  Pod::Spec.new do |spec|
  spec.name         = 'GACSDK'
  spec.version      = '1.0.0'
  spec.summary      = 'A description of GACSDK.'
  spec.description  = 'The SDK build for easy to use from GAC 2c2p.'
  spec.homepage     = 'https://github.com/2C2P/GACSDK-iOS'
  spec.license      = { :type => 'MIT', :file => 'LICENSE' }
  spec.author       = { 'Tanawat Arthan' => 'tanawat.art@2c2p.com' }
  spec.source       = { :git => 'https://github.com/2C2P/GACSDK-iOS.git', :tag => spec.version }
  spec.ios.deployment_target = '13.0'
  spec.resource_bundles = {
     'GACSDKResources' => ['GACSDK/**/*.storyboard', 'GACSDK/**/*.xib', 'GACSDK/**/*.png', 'GACSDK/Resources/**/*']
  }
  spec.swift_version = '5.0'
  spec.requires_arc = true
  spec.frameworks    = 'UIKit'
  spec.vendored_frameworks = "XCFrameworks/GACSDK.xcframework"
  spec.dependency 'Alamofire','~> 5.9.1'
  spec.dependency 'ObjectivePGP'
  spec.dependency 'CryptoSwift','~> 1.8'
  spec.dependency 'SVProgressHUD'
  spec.dependency 'OTPFieldView'
  spec.dependency 'MaterialComponents'
 
end
