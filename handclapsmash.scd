
(
SynthDef(\handclapsmash,{|out= 0 amp = 0.1 gate=1 cutoff= 12000 rq=0.5 releaseTime=0.5 pan=0.0|

	var noise, filter, filterenv, env;

	noise = WhiteNoise.ar;

	filterenv = EnvGen.ar(Env([0.0,1.0,0.3,0.0],[0.0,0.3,0.3]));
	//this involves a gate control, less use here
	//filterenv = EnvGen.ar(Env.adsr(0.0,0.3,0.3,0.3),gate);

	filter = BHiPass.ar(RLPF.ar(noise,cutoff*filterenv,rq),150);

	//body
	filter = BPeakEQ.ar(filter,440,1.0,8);
	//snap
	filter = BPeakEQ.ar(filter,1200,1.0,14);

	//no gate, fixed percussion sound
	env = EnvGen.ar(Env.perc(0.005,releaseTime),doneAction:2);

	Out.ar(out,Pan2.ar(filter*env*amp,pan));

}).add;


//with dirty attack
SynthDef(\handclapsmash2,{|out= 0 amp = 0.1 gate=1 cutoff= 12000 cutoff2=10000 rq=0.5 modamount=0.0 modrate=50 releaseTime=0.7 pan=0.0|

	var noise, filter, filterenv, modulation, env;

	noise = WhiteNoise.ar;

	filterenv = EnvGen.ar(Env([0.0,1.0,0.3,0.0],[0.0,0.3,0.3]));

	modulation = (LFSaw.ar(modrate).range(0.0,1.0))*EnvGen.ar(Env([1,1,0,0],[0.1,0.0,1.0]));

	//filter = BHiPass.ar(RLPF.ar(noise,cutoff*filterenv*(1.0+(modamount*modulation)),rq),150); //alternative
	filter = BHiPass.ar(RLPF.ar(noise,cutoff*filterenv+ (cutoff2*modamount*modulation),rq),150);

	//body
	filter = BPeakEQ.ar(filter,440,1.0,8);
	//snap
	filter = BPeakEQ.ar(filter,1200,1.0,14);

	//no gate, fixed percussion sound
	env = EnvGen.ar(Env.perc(0.005,releaseTime),doneAction:2);

	//amp modulation too not very effective ((1.0-modamount)+(modamount*modulation))
	Out.ar(out,Pan2.ar(filter*env*amp,pan));

}).add;


)




(
Pbind(
	\instrument,\handclapsmash,
	\dur,0.5,
	\rq,1.0
).play
)



(
Pbind(
	\instrument,\handclapsmash2,
	\dur,0.5,
	\cutoff,Pstutter(2,Pn(Pseries(12000,-1000,11),inf)),
	\cutoff2, Pstutter(3,Pn(Pseries(10000,-1000,9),inf)),
	\rq,1.0,
	\modrate,Pstutter(8,Pn(Pseries(25,5,7),inf)),
	\modamount,Pstutter(4,Pseq([0.1,0.3,0.5,0.6,0.7,0.9],inf)),
	\releaseTime,Pstutter(2,Pn(Pseries(0.8,-0.1,6),inf))
).play
)

