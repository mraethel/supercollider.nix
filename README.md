# supercollider.nix
## Structure
```
flake.nix
├── lib
│   ├── supercolliderQuarks(.nix)       # Contains all Quarks information
│   │   └── quarks...                   # Long, Long, Long list of Quarks
│   │       ├── src                     # e.g. fetchFromGithub or other fetchers
│   │       ├── dependencies    (opt)   # Recursive list of dependencies (watch out for dependency cycles!)
│   │       ├── confPath                # String of paths to the sclang_conf.yaml files of the quark and its dependencies (see lib/getQuarkConfPath for details!)
│   │       └── startupFile     (opt)   # Path of the default startupFile used to setup the quark and to be passed to sclang/scide shell applications
│   ├── startupFiles                    
│   │   └── startupFile(.sc/.nix)...    # Collection of startupFiles 
│   ├── writeQuarkConf(.nix)            # Generates ${ quark }_sclang_conf.yaml by simply including quark.src
│   └── getQuarkConfPath(.nix)          # Returns path of ${ quark }_sclang_conf.yaml concatenated with confPaths of quark.dependencies
├── overlays
│   └── supercollider(.nix)             # Overlay for the unwrapped SuperCollider adding the SCLANG_CONF_PATH (https://github.com/supercollider/supercollider/pull/6049) environment variable
└── packages
    ├── supercollider-unwrapped         # The unwrapped SuperCollider
    ├── supercollider(.nix)             # Wrapper for the unwrapped SuperCollider utilizing the SCLANG_CONF_PATH environment variable (notice the new quarks argument!)
    ├── supercollider-with-superdirt    # Wrapping the unwrapped SuperCollider with sc3-plugins and SuperDirt (and its dependencies!)
    └── sclang-with-superdirt(.nix)     # Shell application parsing a SuperDirt Startup File to the sclang executable of the supercollider-with-superdirt package
```
## But where is Tidal?
To use Tidal you need to have this flake's `sclang-with-superdirt` and [mitchmindtree's](https://github.com/mitchmindtree/tidalcycles.nix) `tidal` + `vim-tidal` installed.
Run `sclang-with-superdirt` in one shell and open your Tidal project in another.

You can pass a custom startup file to `sclang-with-superdirt` by overriding it's package in your flake.nix like so (please think of a better package name than I did):
```
sclang-with-superdirt-and-custom-startupFile = supercollider.packages.${ system }.sclang-with-superdirt.override {
    startupFile = pkgs.callPackage ./path/to/custom-startupFile.nix {
        inherit (supercollider.lib.${ system }.supercolliderQuarks) dirtsamples;
    };
}; ...assumes you have imported this flake as 'supercollider'.
```
In order to let SuperDirt know the location of DirtSamples we need to pass their store path.
That is why the startupFile should be Nix file rather than anything else.
However if you keep your own copy of DirtSamples you can simply pass `startupFile = ./path/to/custom-startupFile.sc` and set the according location of DirtSamples in your `custom_startupFile.sc`.

For the default startupFile there are some basic options you can configure.
If for example you wish to increase the number of output channels to 4, you can do it this way:
```
sclang-with-superdirt-and-custom-startupFile = supercollider.packages.${ system }.sclang-with-superdirt.override {
    startupFile = supercollider.lib.${ system }.supercolliderQuarks.superdirt.startupFile.override {
        numOutputBusChannels = 4;
    };
};
```
Have a look at [the SuperDirt startupFile](lib/startupFiles/superdirt.nix) and [this example startupFile](https://github.com/musikinformatik/SuperDirt/blob/develop/superdirt_startup.scd?plain=1) for reference.

## Thanks to ...
[mitchmindtree](https://github.com/mitchmindtree/tidalcycles.nix)
[ardek66](https://github.com/ardek66/nix-livecode)
