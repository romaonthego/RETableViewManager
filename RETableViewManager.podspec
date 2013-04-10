Pod::Spec.new do |s|
  s.name        = 'RETableViewManager'
  s.version     = '0.0.1.2'
  s.authors     = { 'Roman Efimov' => 'romefimov@gmail.com' }
  s.homepage    = 'https://github.com/romaonthego/REMenu'
  s.summary     = 'Data driven content manager for UITableView.'
  s.source      = { :git => 'https://github.com/romaonthego/RETableViewManager' }
  s.license     = { :type => "MIT", :file => "LICENSE" }

  s.platform = :ios, '5.0'
  s.requires_arc = true
  s.source_files = 'RETableViewManager/Cells', 'RETableViewManager/Items', 'RETableViewManager'
  s.public_header_files = 'RETableViewManager/Cells/*.h', 'RETableViewManager/*.h', 'RETableViewManager/Items/*.h'
  s.resources = 'RETableViewManager/RETableViewManager.bundle'

  s.ios.deployment_target = '5.0'

  s.dependency 'REFormattedNumberField', '~> 1.0.4'
end
