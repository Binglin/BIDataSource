
Pod::Spec.new do |s|

  s.name         = "BIDataSource"
  s.version      = "0.0.1"
  s.summary      = "a protocol oriented  wrapper of UITableViewDataSource and UITableViewDelegate of UITableView"

  s.homepage     = "https://github.com/Binglin/BIDataSource"
  s.license      = { :type => "MIT" }

  s.author             = { "Binglin" => "269042025@qq.com" }
  # s.social_media_url   = "http://twitter.com/Binglin"

  s.platform     = :ios, "8.0"
  # s.platform     = :ios, "5.0"

  #  When using multiple platforms
  # s.ios.deployment_target = "5.0"
  # s.osx.deployment_target = "10.7"
  # s.watchos.deployment_target = "2.0"
  # s.tvos.deployment_target = "9.0"

  s.source       = { :git => "https://github.com/Binglin/BIDataSource.git", :tag => s.version }

  s.source_files  = "BIDataSource/BIDataSource"

  s.requires_arc = true

  s.dependency 'UITableView+FDTemplateLayoutCell'

end
