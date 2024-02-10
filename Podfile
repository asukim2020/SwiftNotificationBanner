# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'
def shared_pods
  # Json
#  pod 'JSONModel'
#  pod 'SHXMLParser'
end

target 'ToastTestProject' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!
  pod 'NotificationBannerSwift', '~> 3.0.0'
  pod 'RxSwift'
  pod 'RxCocoa'
  pod 'RxGesture'

  # Pods for MCPTX
  shared_pods
end

post_install do |installer|
  installer.generated_projects.each do |project|
    project.targets.each do |target|
        target.build_configurations.each do |config|
            config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '11.0'
         end
    end
  end
end
