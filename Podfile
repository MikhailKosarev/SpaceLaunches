platform :ios, '15.0'

# Use frameworks instead of static libraries for Pods.
use_frameworks!

target 'SpaceLaunches' do

    # Reactive
    pod 'RxSwift', '~> 6.0'
    pod 'RxCocoa', '~> 6.0'
    pod 'Action', '~> 5.0'
    pod 'RxSwiftExt', '~> 6.0'
    pod 'RxDataSources', '~> 5.0'

    # Network
    pod 'Moya/RxSwift', '~> 15.0'

    # ImageCaching
    pod 'Kingfisher', '~> 7.0'

    # Layout
    pod 'SnapKit', '~> 5.0'

    # A Swift mixin to use UITableViewCells, UICollectionViewCells in a type-safe way
    pod 'Reusable', '~> 4.0'

    # Linter
    pod 'SwiftLint', '~> 0.50'
end

target 'SpaceLaunchesTests' do

    ## Testing
    pod 'RxBlocking', '~> 6.0'
    pod 'RxTest', '~> 6.0'

    # Network
    pod 'Moya/RxSwift', '~> 15.0'
end

post_install do |installer|
   installer.pods_project.targets.each do |target|
     target.build_configurations.each do |config|
       config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '15.0'
     end
   end
end