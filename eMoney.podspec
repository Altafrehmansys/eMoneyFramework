
Pod::Spec.new do |spec|

  spec.name         = "eMoney"
  spec.version      = "1.0.0"
  spec.summary      = "This is eMoney SDK"

  spec.description  = "This is eMoney Framework. We will update this later"

  spec.homepage     = "https://github.com/Altafrehmansys/eMoneyFramework"
  spec.license      = "MIT"

  spec.author       = { "Altaf Ur Rehman" => "altaf.rehman@systemsltd.com" }
  spec.platform     = :ios, "13.0"
  spec.source       = { :http => "https://drive.google.com/file/d/1KR3RrPi9IXsV_r17Tdj5mylwlhDlBbfB/view?usp=share_link" }

  spec.source_files  = "eMoney/**/*.{swift}"
  spec.swift_version = "5.0"
  spec.static_framework = true
  spec.dependency 'LeanSDK'
  spec.dependency 'Alamofire'
  spec.dependency 'DropDown'
  spec.dependency 'NVActivityIndicatorView'
  spec.dependency 'Kingfisher'
  spec.dependency 'SwiftyTesseract'
  spec.dependency 'TensorFlowLiteSwift'
  spec.dependency 'SwiftMessages'
  spec.dependency 'FSPagerView'
  spec.dependency 'lottie-ios'
end
