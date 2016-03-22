(
var numChannels=2;//4  //replace 2 by 4 if you want to try a quadrophonic setup

SynthDef(\impulsetrain1, {arg freq=440, amp=0.1,attack=0.01, sustain=0.1, decay=0.01,pan=0.0, bandwidth=100;
var source, filter, env;

env= EnvGen.ar(Env([0,1,1,0],[attack, sustain, decay]), doneAction:2);

source= Impulse.ar(freq);

filter= BPF.ar(source*env*amp*10,freq,bandwidth/freq);

Out.ar(0,PanAz.ar(numChannels,filter,pan))
}).send(s);

)