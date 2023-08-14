{
  supercollider,
  startupFile,
  writeShellApplication
}: writeShellApplication {
  name = "sclang-with-superdirt";
  runtimeInputs = [ supercollider ];
  text = "sclang ${ startupFile }";
}
