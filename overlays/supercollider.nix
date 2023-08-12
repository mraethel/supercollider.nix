src: final: prev: {
  supercollider = prev.supercollider.overrideAttrs (super: {
    pname = "supercollider-unwrapped";
    inherit src;
  });
}
