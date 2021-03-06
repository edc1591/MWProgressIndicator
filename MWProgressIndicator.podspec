Pod::Spec.new do |s|
  s.name         = "MWProgressIndicator"
  s.version      = "1.0.2"
  s.summary      = "Custom progress indicator used in MenuWeather."
  s.homepage     = "http://menuweather.com"
  s.license      = 'MIT'
  s.author       = { "Evan Coleman" => "evan@edc.me" }
  s.source       = { :git => "https://github.com/edc1591/MWProgressIndicator.git", :tag => "1.0.2" }
  s.platform     = :osx, '10.7'
  s.source_files = 'MWProgressIndicator/MWProgressIndicator.{h,m}'
  s.requires_arc = true
end