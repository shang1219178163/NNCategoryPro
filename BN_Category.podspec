
Pod::Spec.new do |s|

  s.name         = "BN_Category"
  s.version      = "1.3.3"
  s.summary      = "分类-项目通用方法封装."

  s.description  = <<-DESC
                    项目封装的实现主体,主要通过分类实现
                   DESC

   s.homepage     = "https://github.com/shang1219178163/BN_Category"
   # s.screenshots  = "www.example.com/screenshots_1.gif", "www.example.com/screenshots_2.gif"

   s.license      = { :type => "MIT", :file => "LICENSE" }
   s.author       = { "BIN" => "shang1219178163@gmail.com" }

   s.platform     = :ios, '9.0'
   s.ios.deployment_target = '9.0'
   s.requires_arc = true

   s.source       = { :git => "https://github.com/shang1219178163/BN_Category.git", :tag => "#{s.version}" }

   s.source_files = "BN_Category/*"
   s.public_header_files = "BN_Category/*.h"

   s.frameworks = 'UIKit', 'CoreFoundation', 'CoreText', 'CoreGraphics', 'CoreImage',
   'CoreLocation','CoreTelephony', 'GLKit','QuartzCore', 'ImageIO','Accelerate',
   'AssetsLibrary', 'MobileCoreServices', 'SystemConfiguration','ImageIO',
   'JavaScriptCore','WebKit'

   s.dependency 'BN_Globle'
   s.dependency 'BN_Kit'

   s.dependency 'AESCrypt-ObjC'
   s.dependency 'FLAnimatedImage'
   s.dependency 'IQKeyboardManager'
   s.dependency 'GTMBase64'
   s.dependency 'MBProgressHUD'
   s.dependency 'MJExtension'
   s.dependency 'SDWebImage'
   s.dependency 'Toast'
   s.dependency 'YYModel'


  # ――― Resources ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  A list of resources included with the Pod. These are copied into the
  #  target bundle with a build phase script. Anything else will be cleaned.
  #  You can preserve files from being cleaned, please don't preserve
  #  non-essential files like tests, examples and documentation.
  #

  # s.resource  = "icon.png"
  # s.resources = "Resources/*.png"

  # s.preserve_paths = "FilesToSave", "MoreFilesToSave"


  # ――― Project Linking ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  Link your library with frameworks, or libraries. Libraries do not include
  #  the lib prefix of their name.
  #

  # s.framework  = "SomeFramework"
  # s.frameworks = "SomeFramework", "AnotherFramework"

  # s.library   = "iconv"
  # s.libraries = "iconv", "xml2"


  # ――― Project Settings ――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  If your library depends on compiler flags you can set them in the xcconfig hash
  #  where they will only apply to your library. If you depend on other Podspecs
  #  you can include multiple dependencies to ensure it works.

  # s.requires_arc = true

  # s.xcconfig = { "HEADER_SEARCH_PATHS" => "$(SDKROOT)/usr/include/libxml2" }
  # s.dependency "JSONKit", "~> 1.4"

end
