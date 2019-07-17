proc `or`*(s1, s2: string): string =
  ## Return s1 if it is not empty, else return s2 (even if it is empty).
  ##
  if s1.len > 0:
    return s1
  s2
