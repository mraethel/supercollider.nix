{
  quark,
  writeText
}: writeText "${ quark.name }_sclang_conf.yaml" ''
  includePaths:
    - ${ quark.src }
''
