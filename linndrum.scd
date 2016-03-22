//LinnDrum:
// p. 23 get the samples from http://machines.hyperreal.org/manufacturers/Linn/LinnDrum/
//The website is a nice resource; there are other sample kits there like Roland TR-909 and TR-808
 //I've just demoed a patch with three samples (kick, snare, hat): I've used Patterns below, though my personal preference would be explicit Busses, Groups, Synths and {}.fork for full control of routings


 //load samples (assumed mono)
(
var basepath = "/Users/EmanTnuocca/Desktop/∞/g_smpl/!aa/";

b = ["kick","sd","chh"].collect{|val| Buffer.read(s,basepath++val++".wav") };

//b[0].numChannels.postln; should be 1 for mono

)



(

SynthDef(\sampleplay,{|out= 0 bufnum = 0 amp = 0.1 gate=1 pan = 0.0|

	var playbuf, env;

	playbuf = PlayBuf.ar(1,bufnum);

	env = EnvGen.ar(Env.adsr(0.0,0.0,1.0,0.1),gate,doneAction:2);

	Out.ar(out,Pan2.ar(playbuf*env*amp,pan));

}).add;

SynthDef(\samplecompress,{|out =0 gain=2 reduction=8 ratio=3 gate= 1 attackTime=0.016 relaxTime=0.05|

	var source = In.ar(out,2);
	var compression;
	var env = Linen.kr(gate, 0.0, 1, 0.1, 2);

	compression= Compander.ar(2*source,source,(-8).dbamp,1.0,ratio.reciprocal,attackTime,relaxTime);

	XOut.ar(out,env, compression);

}).add;

SynthDef(\sampleeq1,{|out =0 gate= 1|

	var source = In.ar(out,2);
	var env = Linen.kr(gate, 0.0, 1, 0.1, 2);
	var eq;

	eq= BLowShelf.ar(source,100,1.0,3);
	eq= BPeakEQ.ar(eq,600,1.0,-3);

	XOut.ar(out,env,eq);

}).add;

SynthDef(\sampleeq2,{|out =0 gate= 1|

	var source = In.ar(out,2);
	var env = Linen.kr(gate, 0.0, 1, 0.1, 2);
	var eq;

	eq= BHiPass(150,0.3);

	XOut.ar(out,env,eq);

}).add;


SynthDef(\samplereverb,{|out =0 gate= 1|

	var source = In.ar(out,2);
	var env = Linen.kr(gate, 0.0, 0.3, 0.1, 2);
	var reverb;

	reverb= FreeVerb.ar(source,1.0,0.6,0.6);

	XOut.ar(out,env,reverb);

}).add;


)



(
var kick, snare,hat;

s.latency= 0.1;

kick = Pbind(
	\instrument, \sampleplay,
	\bufnum,b[0],
	\dur,1.0,
	\pan,0.0,
	\amp, 0.5
);


snare = Pbind(
	\instrument, \sampleplay,
	\bufnum,b[1],
	\dur,Pseq([1.25,0.75,2.0],inf),
	\bus,16,
	\amp,0.45,
	\pan,0.0
);

hat = Pbind(
	\instrument, \sampleplay,
	\bufnum,b[2],
	\dur,Pseq(0.5!8++(0.25!16),inf),
	\amp, 0.15,
	\pan,Pseq(0.3!8++((-0.3)!16),inf)
);


//Pfxb organises private busses for each sound
Ptpar([
	0.0,
	Pfxb(Pfx(kick,\samplecompress),\sampleeq1),
	1.0,
	Pfxb(Pfx(snare,\samplecompress,\gain,1,\reduction,10,\ratio,2,\attackTime,0.02),\samplereverb),
	0.0,
	Pfxb(hat,\sampleeq2)
]).play


)
TempoClock.default.tempo = 2;






