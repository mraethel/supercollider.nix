{
  mkShell,
  python3,
  clang-tools_8,
  llvmPackages_8
}: mkShell {
  name = "scformat";
  packages = [
    python3
    clang-tools_8
    llvmPackages_8.clang-unwrapped.python
  ];
  shellHook = "SC_CLANG_FORMAT_DIFF=${ llvmPackages_8.clang-unwrapped.python }/share/clang/clang-format-diff.py tools/clang-format.py formatall & exit";
}
