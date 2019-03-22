# Package

version       = "0.1.2"
author        = "Xabi Bello"
description   = "A wrapper to notification libraries"
license       = "MIT"
srcDir        = "src"
installExt    = @["nim"]
bin           = @["notify"]


# Dependencies

requires "nim >= 0.19.4"

when defined(nimdistros):
  import distros
  if detectOs(Linux):
    foreignDep "libnotify"
