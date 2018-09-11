Pod::Spec.new do |s|
  s.name             = "KRNCalendar"
  s.version          = "0.0.1"
  s.summary          = "A Calendar view for iOS"
  s.description      = <<-DESC
Features
1. Shows a calendar within the specified inrterval (startYear - endYear)
2. Simple dataSource base on dates
3. Customisable for your needs
DESC

  s.homepage         = "https://github.com/kireyin/KRNCalendar"
  s.license          = 'MIT'
  s.author           = { "Kireyin" => "abrispot@gmail.com" }
  s.source           = { :git => "https://github.com/kireyin/KRNCalendar.git", :tag => '0.0.1' }
  s.platform	     = :ios, '9.1'
  s.swift_version    = '4.2'
  s.requires_arc     = true
  s.source_files     = 'KRNCalendar/KRNCalendar/*/*'
  s.frameworks	     = 'UIKit'
  s.resources        = ["KRNCalendar/KRNCalendar/CalendarViewCell.xib", "KRNCalendar/KRNCalendar/CalendarReusableView.xib"]
end