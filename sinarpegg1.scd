(
SynthDef(\sinarpegg1, {arg freq=440, amp=0.1,attack=0.01, sustain=0.1, decay=0.01,pan=0.0;
var source, filter, env;

source= SinOsc.ar(EnvGen.kr(Env([1,2,3,4,5,6]*freq,(0.2*attack).dup(5))));

filter= CombN.ar(source*EnvGen.kr(Env([1,1,0],[attack,0.01])),0.025,0.025,5);

env= EnvGen.kr(Env([0,0,1,1,0],[attack, 0.01,sustain, decay]), doneAction:2);

Out.ar(0,PanAz.ar(numChannels,filter*env*0.5*amp,pan))
}).send(s);
)


Synth(\sinarpegg1);