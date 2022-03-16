# Uncomment the next line to define a global platform for your project
platform :ios, '10.0'

target 'Jihat' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!
  
  # Pods for Jihat
  pod 'IQKeyboardManagerSwift'
  pod 'Alamofire', '~> 5.0.0-rc.3'
  pod 'PromisedFuture'
  pod "TTGSnackbar"
  pod 'SkeletonView'
  pod 'NotificationBannerSwift', '~> 3.0.0'
  pod 'Kingfisher'
  pod 'LabelSwitch'
  pod 'MBRadioCheckboxButton'
#  pod 'ImagePicker'
  pod 'FlagPhoneNumber'
  pod 'SideMenu', '~> 6.0'
  pod 'SoundWave'
  pod 'ImagePicker', :git => 'https://github.com/hyperoslo/ImagePicker.git'
  pod 'PryntTrimmerView', '4.0.0'
  pod 'SteviaLayout'
  
  # Code Checks
  pod 'SwiftLint'
  
  post_install do |installer|
    installer.pods_project.targets.each do |target|
      target.build_configurations.each do |config|
        config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '10.0'
        config.build_settings['GCC_WARN_INHIBIT_ALL_WARNINGS'] = "YES"
      end
    end
  end
  
end
