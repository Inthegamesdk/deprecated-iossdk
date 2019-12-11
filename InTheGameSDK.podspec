
Pod::Spec.new do |spec|

  spec.name         = "InTheGameSDK"
  spec.version      = "1.0.0"
  spec.summary      = "SDK for the In The Game engagement platform."
  spec.description  = "This SDK allows you to easily integrate the In The Game platform in a video player in your app."

  spec.homepage     = "https://www.inthegame.io/"
  spec.license      = "MIT"
  spec.platform     = :ios, "11.4"

  spec.source       = { :git => "https://github.com/itaiarbel1/iossdk", :tag => "1.0.0" }
  spec.source_files  = "InTheGame"

  spec.swift_version = "5" 

end
