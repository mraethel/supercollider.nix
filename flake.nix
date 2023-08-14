{
  inputs = {
    supercollider = {
      url = "git+https://github.com/mraethel/supercollider?ref=topic/pass-multiple-sclang-configurations&submodules=1";
      flake = false;
    };
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = {
    self,
    supercollider,
    nixpkgs,
    flake-utils,
    ...
  }: {
    overlays.supercollider = import ./overlays/supercollider.nix supercollider;
  } // flake-utils.lib.eachDefaultSystem (system: let
    pkgs = import nixpkgs {
      inherit system;
      overlays = [ self.overlays.supercollider ];
    };
  in rec {
    packages = {
      supercollider-unwrapped = pkgs.supercollider;
      supercollider = pkgs.callPackage ./packages/supercollider.nix { inherit (packages) supercollider-unwrapped; };
      supercollider-with-superdirt = packages.supercollider.override {
        plugins = [ pkgs.supercolliderPlugins.sc3-plugins ];
        quarks = [ lib.supercolliderQuarks.superdirt ];
      };
      sclang-with-superdirt = pkgs.callPackage ./packages/sclang-with-superdirt.nix {
        supercollider = packages.supercollider-with-superdirt;
        inherit (lib.supercolliderQuarks.superdirt) startupFile;
      };
    };
    lib = {
      writeQuarkConf = quark: pkgs.callPackage ./lib/writeQuarkConf.nix { inherit quark; };
      getQuarkConfPath = quark: pkgs.callPackage ./lib/getQuarkConfPath.nix { inherit quark; inherit (lib) writeQuarkConf; };
      supercolliderQuarks = pkgs.callPackage ./lib/supercolliderQuarks.nix { inherit (lib) getQuarkConfPath; };
    };
  });
}
