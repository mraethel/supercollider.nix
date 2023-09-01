{ 
  numBuffers ? 1024 * 256,
  memSize ? 8192 * 32,
  numWireBufs ? 64,
  maxNodes ? 1024 * 32,
  numOutputBusChannels ? 2,
  numInputBusChannels ? 2,
  numBusChannels ? 2,
  dirtsamples,
  sync ? false,
  port ? 57120,
  outBusChannel ? 0,
  latency ? 0.3,
  customStartupFiles ? [],
  customSoundFiles ? [],
  lib,
  writeText
}: writeText "superdirt.sc" ''
(
s.reboot {
    s.options.numBuffers = ${ toString numBuffers };
    s.options.memSize = ${ toString memSize };
    s.options.numWireBufs = ${ toString numWireBufs };
    s.options.maxNodes = ${ toString maxNodes };
    s.options.numOutputBusChannels = ${ toString numOutputBusChannels };
    s.options.numInputBusChannels = ${ toString numInputBusChannels };
    s.waitForBoot {
        ~dirt.stop;
        ~dirt = SuperDirt(${ toString numBusChannels }, s);
        ~dirt.loadSoundFiles("${ dirtsamples.src }/*");
        ${ lib.concatMapStringsSep "\n" (soundFile: "~dirt.loadSoundFiles(\"${ soundFile.src }\"${ lib.optionalString (soundFile ? namingFunction) ", namingFunction: ${ soundFile.namingFunction }"});") customSoundFiles }
        ${ lib.optionalString sync "s.sync;" }
        ~dirt.start(${ toString port }, ${ toString outBusChannel } ! ${ toString numBusChannels });
        ${ lib.concatMapStringsSep "\n" (startupFile: "\"${ startupFile }\".load;") customStartupFiles }
    };
    s.latency = ${ toString latency };
};
)
''
