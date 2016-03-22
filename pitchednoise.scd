(
SynthDef(\pitchednoise, {arg freq=440, amp=0.1,attack=0.01, sustain=0.1, decay=0.01,pan=0.0, bandwidth=100;
var source, filter, env;

env= EnvGen.ar(Env([0,1,1,0],[attack, sustain, decay]), doneAction:2);

source= WhiteNoise.ar;

filter= BPF.ar(source*env*2*amp,freq,bandwidth/freq);

Out.ar(0,PanAz.ar(numChannels,filter,pan))
}).send(s);
)

Synth(\pitchednoise);