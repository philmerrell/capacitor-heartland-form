
  Pod::Spec.new do |s|
    s.name = 'CapacitorHeartlandForm'
    s.version = '0.0.1'
    s.summary = 'Native view for accepting payment through Heartland SDK'
    s.license = 'MIT'
    s.homepage = 'https://github.com/philmerrell/capacitor-heartland-form.git'
    s.author = 'Phil Merrell'
    s.source = { :git => 'https://github.com/philmerrell/capacitor-heartland-form.git', :tag => s.version.to_s }
    s.source_files = 'ios/Plugin/Plugin/**/*.{swift,h,m,c,cc,mm,cpp}'
    s.resource_bundles = {
      'CapacitorHeartlandForm' => ['ios/Plugin/Plugin/**/*.{storyboard,xib}']
    }
    s.ios.deployment_target  = '11.0'
    s.dependency 'Capacitor'
    s.dependency 'CreditCardForm'
    s.dependency 'Stripe'
    s.dependency 'Heartland-iOS-SDK'
  end