Pod::Spec.new do |s|
  s.name         = "TableViewHelper"
  s.version      = "2.2"
  s.summary      = "Easily hide and show UITableView Rows"
  s.homepage	 = "https://github.com/AaronBratcher/TableViewHelper"

  s.license      = "MIT"
  s.author             = { "Aaron Bratcher" => "aaronlbratcher@yahoo.com" }
  s.social_media_url   = "http://twitter.com/AaronLBratcher"

  s.platform     = :ios, "10.0"
  s.swift_versions = "5.0"
  s.source       = { :git => "https://github.com/AaronBratcher/TableViewHelper.git", :tag => s.version }
  s.source_files  = "TableViewHelper", "TableViewHelper/TableViewHelper/**/*.{h,m,swift}"
end
