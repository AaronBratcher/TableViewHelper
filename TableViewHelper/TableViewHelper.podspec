Pod::Spec.new do |s|
  s.name         = "TableViewHelper"
  s.version      = "2.0"
  s.summary      = "Easily hide and show UITableView Rows"
  s.homepage	 = "https://github.com/AaronBratcher/TableViewHelper"

  s.license      = "MIT"
  s.author             = { "Aaron Bratcher" => "aaronbratcher1@gmail.com" }
  s.social_media_url   = "http://twitter.com/AaronLBratcher"

  s.platform     = :ios, "9.0"
  s.source       = { :git => "https://github.com/AaronBratcher/TableViewHelper.git", :tag => "2.0" }
  s.source_files  = "TableViewHelper", "TableViewHelper/TableViewHelper/**/*.{h,m,swift}"
end
