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
        ${ lib.optionalString sync "s.sync;" }
        ~dirt.start(${ toString port }, ${ toString outBusChannel } ! ${ toString numBusChannels });
        (
            ~d1 = ~dirt.orbits[0]; ~d2 = ~dirt.orbits[1]; ~d3 = ~dirt.orbits[2];
            ~d4 = ~dirt.orbits[3]; ~d5 = ~dirt.orbits[4]; ~d6 = ~dirt.orbits[5];
            ~d7 = ~dirt.orbits[6]; ~d8 = ~dirt.orbits[7]; ~d9 = ~dirt.orbits[8];
            ~d10 = ~dirt.orbits[9]; ~d11 = ~dirt.orbits[10]; ~d12 = ~dirt.orbits[11];
        );
    };
    s.latency = ${ toString latency };
};
)
''
