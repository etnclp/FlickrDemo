platform :ios, '10.0'

use_frameworks!
source 'https://github.com/CocoaPods/Specs.git'

inhibit_all_warnings!

def common_pods
  pod 'Moya/RxSwift'
end

target 'Flickr' do
  common_pods

  pod 'MBProgressHUD'
  pod 'Kingfisher'
  pod 'XCGLogger'
  pod 'IQKeyboardManagerSwift'
  pod 'RxCocoa'
  pod 'RxOptional'
  pod 'RxDataSources'
  pod 'XCoordinator/RxSwift', '1.3.0'
  pod 'Action', '~> 3.9'
  pod 'SwiftLint'
end

target 'FlickrTests' do
  common_pods
  pod 'Quick'
  pod 'Nimble'
end

target 'FlickrUITests' do
  common_pods
  pod 'Quick'
  pod 'Nimble'
end