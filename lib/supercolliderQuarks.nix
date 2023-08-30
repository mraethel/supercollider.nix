{
  getQuarkConfPath,
  fetchFromGitHub,
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
    confPath = getQuarkConfPath vowel;
  };
  dirtsamples = {
    name = "dirtsamples";
    src = fetchFromGitHub {
      owner = "tidalcycles";
      repo = "dirt-samples";
      rev = "master";
      sha256 = "Zl2bi9QofcrhU63eMtg+R6lhV9ExQS/0XNTJ+oq65Uo=";
    };
    confPath = getQuarkConfPath dirtsamples;
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
    confPath = getQuarkConfPath superdirt;
    startupFile = pkgs.callPackage ./startupFiles/superdirt.nix { inherit dirtsamples; };
  };
  mraethel = {
    name = "mraethel";
    src = fetchFromGitHub {
      owner = "mraethel";
      repo = "mraethel.quark";
      rev = "master";
      sha256 = "5qUN6iTM58A+Ff7zUBFhv+rID5ualbIILcc98pNr/eo=";
    };
    dependencies = [ superdirt ];
    confPath = getQuarkConfPath mraethel;
    startupFile = ./startupFiles/mraethel.sc;
  };
}
