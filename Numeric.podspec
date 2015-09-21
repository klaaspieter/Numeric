Pod::Spec.new do |s|
  s.name                  =  "Numeric"
  s.version               =  "2.0.0"
  s.summary               =  "Swift numeric extensions"
  s.homepage              =  "https://github.com/klaaspieter/Numeric"
  s.license               =  "MIT"
  s.author                =  { "Klaas Pieter Annema" => "klaaspieter@annema.me" }
  s.social_media_url      =  "http://twitter.com/klaaspieter"
  s.ios.deployment_target =  "8.0"
  s.osx.deployment_target =  "10.10"
  s.source                =  { :git => "https://github.com/klaaspieter/Numeric.git", :tag => s.version }
  s.source_files          =  "Numeric", "Numeric/**/*.swift"
  s.requires_arc          =  true
end
