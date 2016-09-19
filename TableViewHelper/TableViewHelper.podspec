Pod::Spec.new do |s|
  s.name         = "TableViewHelper"
  s.version      = "2.0"
  s.summary      = "Easily hide and show UITableView Rows"

  s.license      = "MIT"
  s.author             = { "Aaron Bratcher" => "aaronbratcher1@gmail.com" }
  s.social_media_url   = "http://twitter.com/AaronLBratcher"

  s.platform     = :ios, "8.0"
  s.source       = { :git => "https://github.com/AaronBratcher/TableViewHelper", :tag => "2.0" }
  s.source_files  = "TableViewHelper", "TableViewHelper/**/*.{h,m,swift}"
end
