Pod::Spec.new do |s|

  s.name         = 'MEGATree'
  s.version      = '1.0.1'
  s.summary      = 'Objective-C AVLTree implementation'

  s.description  = <<-DESC
                   Implementation based on MIT's Intro to algorithms lecture
                   http://video.mit.edu/watch/introduction-to-algorithms-lecture-6-avl-trees-avl-sort-14062/
                   DESC

  s.homepage     = 'https://github.com/jamesbouker/MEGATree'

  s.license      = 'MIT'

  s.author       = { 'Jimmy Bouker' => 'james.bouker@gmail.com' }

  s.source       = { :git => 'https://github.com/jamesbouker/MEGATree.git', :tag => s.version }

  s.source_files  = 'MEGATree/*.{h,m}'
  s.public_header_files = 'MEGATree/MEGATree.h'

  s.requires_arc = true

  s.ios.deployment_target = '6.0'
  s.osx.deployment_target = '10.8'

end
