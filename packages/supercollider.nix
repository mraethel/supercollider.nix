{
  symlinkJoin,
  makeWrapper,
  supercollider-unwrapped,
  plugins ? [],
  quarks ? [],
}: symlinkJoin {
  name = "supercollider-${ supercollider-unwrapped.version }";
  paths = [ supercollider-unwrapped ] ++ plugins;

  nativeBuildInputs = [ makeWrapper ];

  postBuild = ''
    for exe in $out/bin/*; do
      wrapProgram $exe \
        --set SC_PLUGIN_DIR     "$out/lib/SuperCollider/plugins" \
        --set SC_DATA_DIR       "$out/share/SuperCollider" \
        --set SCLANG_CONF_PATH  "${ builtins.concatStringsSep ":" (builtins.catAttrs "confPath" quarks) }"
    done
  '';

  pname = "supercollider";
  inherit ( supercollider-unwrapped ) version meta;
}
