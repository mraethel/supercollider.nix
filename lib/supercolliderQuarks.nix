{
  fetchFromGitHub,
  writeQuarkConf,
  pkgs
}: rec {
  vowel = {
    name = "vowel";
    src = fetchFromGitHub {
      owner = "supercollider-quarks";
      repo = "vowel";
      rev = "master";
      sha256 = "zfF6cvAGDNYWYsE8dOIo38b+dIymd17Pexg0HiPFbxM=";
    };
    dependencies = [ ];
    confPath = builtins.concatStringsSep ":" ([ (writeQuarkConf vowel) ] ++ (builtins.catAttrs "confPath" vowel.dependencies));
  };
  dirtsamples = {
    name = "dirtsamples";
    src = fetchFromGitHub {
      owner = "tidalcycles";
      repo = "dirt-samples";
      rev = "master";
      sha256 = "Zl2bi9QofcrhU63eMtg+R6lhV9ExQS/0XNTJ+oq65Uo=";
    };
    dependencies = [ ];
    confPath = builtins.concatStringsSep ":" ([ (writeQuarkConf dirtsamples) ] ++ (builtins.catAttrs "confPath" dirtsamples.dependencies));
  };
  superdirt = {
    name = "superdirt";
    src = fetchFromGitHub {
      owner = "musikinformatik";
      repo = "superdirt";
      rev = "master";
      sha256 = "GtnqZeMFqFkVhgx2Exu0wY687cHa7mNnVCgjQd6fiIA=";
    };
    dependencies = [ vowel dirtsamples ];
    confPath = builtins.concatStringsSep ":" ([ (writeQuarkConf superdirt) ] ++ (builtins.catAttrs "confPath" superdirt.dependencies));
  };
}
