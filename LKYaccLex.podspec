Pod::Spec.new do |s|
  s.name         = "LKYaccLex"
  s.version      = "0.1.0"
  s.summary      = "Yacc/Lex Utility"
  s.description  = <<-DESC
Library for Yacc/Lex(Bison/Flex).
                   DESC
  s.homepage     = "https://github.com/lakesoft/LKYaccLex"
  s.license      = { :type => 'MIT', :file => 'LICENSE' }
  s.author       = { "Hiroshi Hashiguchi" => "xcatsan@mac.com" }
  s.source       = { :git => "https://github.com/lakesoft/LKYaccLex.git", :tag => s.version.to_s }

  s.platform     = :ios, '7.0'
  s.requires_arc = true

  s.source_files = 'Classes/*'

end
