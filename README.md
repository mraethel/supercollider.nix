# supercollider.nix
## Structure
```
flake.nix
├── lib
│   ├── supercolliderQuarks(.nix)       # Contains all Quarks information
│   │   └── quarks...                   # Long, Long, Long list of Quarks
│   │       ├── src                     # e.g. fetchFromGithub or other fetchers
│   │       ├── dependencies            # Recursive list of dependencies (watch out for dependency cycles!)
│   │       └── confPath                # Path of ${ quark }_sclang_conf.yaml concatenated with confPaths of quark.dependencies
│   └── writeQuarkConf(.nix)            # Generates ${ quark }_sclang_conf.yaml by simply including quark.src
├── overlays
│   └── supercollider(.nix)             # Overlay for the unwrapped SuperCollider adding the SCLANG_CONF_PATH (https://github.com/supercollider/supercollider/pull/6049) environment variable
└── packages
    ├── supercollider-unwrapped         # The unwrapped SuperCollider
    ├── supercollider(.nix)             # Wrapper for the unwrapped SuperCollider utilizing the SCLANG_CONF_PATH environment variable (notice the new quarks argument!)
    ├── supercollider-with-superdirt    # Wrapping the unwrapped SuperCollider with sc3-plugins and SuperDirt (and its dependencies!)
    └── sclang-with-superdirt(.nix)     # Shell application parsing a SuperDirt Startup File to the sclang executable of the supercollider-with-superdirt package (starting SuperDirt of course!)
```
## But where is Tidal?
To use Tidal you need to have this flake's `sclang-with-superdirt` and [mitchmindtree's](https://github.com/mitchmindtree/tidalcycles.nix) `tidal` + `vim-tidal` (mandatory!) installed.
Run `sclang-with-superdirt` in one shell and open your Tidal project in another.
Now pray that it works!

## Thanks to ...
[mitchmindtree](https://github.com/mitchmindtree/tidalcycles.nix)
[ardek66](https://github.com/ardek66/nix-livecode)
