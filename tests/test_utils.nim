import unittest

import notifypkg/utils


suite "OR for strings, python-like":
  setup:
    var s1: string = "s1"
    var s2: string = "s2"
    var empty: string = ""

  test "s1 is returned if it is not empty":
    check ((s1 or s2) == s1)

  test "s2 is returned if s1 or s2 are empty":
    check ((empty or s2) == s2)
    check ((empty or empty) == empty)
