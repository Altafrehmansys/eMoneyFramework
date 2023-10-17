
Pod::Spec.new do |spec|

  spec.name         = "eMoney"
  spec.version      = "1.0.0"
  spec.summary      = "This is eMoney SDK"

  spec.description  = "This is eMoney Framework. We will update this later"

  spec.homepage     = "https://github.com/Altafrehmansys/eMoneyFramework"
  spec.license      = "MIT"

  spec.author       = { "Altaf Ur Rehman" => "altaf.rehman@systemsltd.com" }
  spec.platform     = :ios, "13.0"
  spec.source       = { :git => "https://github.com/Altafrehmansys/eMoneyFramework.git", :tag => spec.version.to_s }

  spec.source_files  = "eMoney/**/*.{swift}"
  spec.swift_version = "5.0"
  spec.dependency 'LeanSDK'
  spec.dependency 'Alamofire'
  spec.dependency 'DropDown'

end
