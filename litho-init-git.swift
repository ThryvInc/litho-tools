#!/usr/bin/swift

import Foundation

let gitignore = """
.DS_Store

build/
*.pbxuser
!default.pbxuser
*.mode1v3
!default.mode1v3
*.mode2v3
!default.mode2v3
*.perspectivev3
!default.perspectivev3
xcuserdata
*.xccheckout
*.moved-aside
DerivedData
*.hmap
*.ipa
*.dsym.zip
*.xcuserstate

Pods/

fastlane/report.xml
fastlane/test_output
screenshots/
output

"""
try! gitignore.write(toFile: ".gitignore", atomically: true, encoding: .utf8)
