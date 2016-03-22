///////IYICE DUZENLENMESI GEREKIO

(
SynthDef(\goeysynth, {
arg freq=440,amp=0.1, sustain=0.1, pan=0.0;
var source, env;

source= LPF.ar(Mix(LFPar.ar(freq*[0.999,1.001],0,amp)).distort,EnvGen.kr(Env([10000,2000,4000,1000],[0.005,Rand(0.009,0.05),0.005])));

env= EnvGen.kr(Env([0,1,0.4,0.7,0],[Rand(0.001,0.005),0.005,0.005,sustain]), doneAction:2);

Out.ar(0,Pan2.ar(source*env,pan))

}).send(s);

//preferred version if you have the FreeVerb UGen, commented out by default
//SynthDef(\goeyfx, {
//ReplaceOut.ar(0,FreeVerb.ar(In.ar(0,2),0.33,1.5))
//}).send(s);

//adapted from JmC reverb
SynthDef(\goeyfx, {
var a,c,z,y,in;
c = 2; // number of comb delays
a = 3; // number of allpass delays

in=In.ar(0,2);
// reverb predelay time :
z = DelayN.ar(in, 0.048,0.048);

//for delaytime if want modulation-	//LFNoise1.kr(0.1.rand, 0.04, 0.05)
y=Mix.arFill(c,{CombL.ar(z,0.1,rrand(0.01, 0.1),5)});

// chain of 4 allpass delays on each of two channels (8 total) :
a.do({ y = AllpassN.ar(y, 0.051, [rrand(0.01, 0.05),rrand(0.01, 0.05)], 1) });

// add original sound to reverb and play it :
Out.ar(0,(0.2*y));

}).send(s);

)