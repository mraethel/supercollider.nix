{
  getQuarkConfPath,
  inputs,
  pkgs
}: rec {
  vowel = {
    name = "vowel";
    src = inputs.vowel;
    confPath = getQuarkConfPath vowel;
  };
  dirtsamples = {
    name = "dirtsamples";
    src = inputs.dirtsamples;
    confPath = getQuarkConfPath dirtsamples;
  };
  superdirt = {
    name = "superdirt";
    src = inputs.superdirt;
    dependencies = [ vowel dirtsamples ];
    confPath = getQuarkConfPath superdirt;
    startupFile = pkgs.callPackage ./startupFiles/superdirt.nix { inherit dirtsamples; };
  };
  mraethel = {
    name = "mraethel";
    src = inputs.mraethel;
    dependencies = [ superdirt ];
    confPath = getQuarkConfPath mraethel;
    startupFile = ./startupFiles/mraethel.sc;
  };
  drumachines = {
    name = "drumachines";
    src = inputs.drumachines;
    dependencies = [ superdirt ];
    confPath = getQuarkConfPath drumachines;
    startupFile = ./startupFiles/drumachines.sc;
  };
}
