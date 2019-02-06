Pod::Spec.new do |s|

s.name                    = "VideoBackground"
s.version                 = "0.2.0"
s.license                 = { :type => "MIT", :file => "LICENSE"}

s.homepage                = "https://github.com/mruvim/VideoBackground"
s.summary                 = "Lightweight view to display background video"
s.author                  = { "Ruvim Miksanskiy" => "ruva@codingroup.com" }
s.source                  = { :git => "https://github.com/mruvim/VideoBackground.git", :tag => s.version, :branch => "master"}

s.screenshot              = "http://codingroup.com/assets/external/video-background.gif"

s.platform                = :ios, "11.0"
s.requires_arc            = true

s.ios.deployment_target   = "11.0"
s.source_files            = "VideoBackground/**/*.swift"

end
