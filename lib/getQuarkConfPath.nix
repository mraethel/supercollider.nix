{
  quark,
  writeQuarkConf,
  lib
}: builtins.concatStringsSep ":" (
  (lib.singleton
    (writeQuarkConf quark))
++(lib.optionals (quark ? dependencies)
    (builtins.catAttrs "confPath" quark.dependencies)))
