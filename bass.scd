


//pp. 30-31 Synth bass layers

(
SynthDef(\bassfoundation,{|out= 0 freq = 440 amp = 0.1 gate=1 cutoff= 1000 rq=0.5 pan=0.0|

	var osc, filter, env, filterenv;

	osc = Saw.ar(freq);

	filterenv = EnvGen.ar(Env.adsr(0.0,0.5,0.2,0.2),gate,doneAction:2);
	filter =  RLPF.ar(osc,cutoff*filterenv+100,rq);

	env = EnvGen.ar(Env.adsr(0.01,0.0,0.9,0.05),gate,doneAction:2);

	Out.ar(out,Pan2.ar(filter*env*amp*2,pan));

}).add;


SynthDef(\basshighend,{|out= 0 freq = 440 amp = 0.1 gate=1 cutoff= 3000 rq=0.1 drive = 10.0 pan=0.0|

	var osc, filter, env, filterenv;
	var ab;

	//osc = Mix(VarSaw.ar(freq*[0.25,1,1.5],Rand(0.0,1.0)!3,0.9,[0.5,0.4,0.1]));
	osc = Mix(Saw.ar(freq*[0.25,1,1.5],[0.5,0.4,0.1]));
	//osc = Mix(DPW4Saw.ar(freq*[0.25,1,1.5],[0.5,0.4,0.1]));
	filterenv = EnvGen.ar(Env.adsr(0.0,0.5,0.2,0.2),gate,doneAction:2);
	filter =  RLPF.ar(osc,cutoff*filterenv+100,rq);

 	//distortion
 	//filter = filter.distort.softclip;

	ab = abs(filter);
 	filter = (filter*(ab + drive)/(filter ** 2 + (drive - 1) * ab + 1));

	//remove low end
	filter = BLowShelf.ar(filter,300,1.0,-12);
	//dip at 1600Hz
	filter = BPeakEQ.ar(filter,1600,1.0,-6);

	env = EnvGen.ar(Env.adsr(0.01,0.0,0.9,0.05),gate,doneAction:2);

	Out.ar(out,Pan2.ar(filter*env*amp*2,pan));

}).add;

)




(
Pbind(
	\instrument,\bassfoundation,
	\midinote,36,
	\dur,0.5,
	\rq,1.0
).play
)


(
Pbind(
	\instrument,\basshighend,
	\midinote,36,
	\dur,0.5,
	\rq,1.0
).play
)


//combination
(
p = Pbind(
	\midinote,Pstutter(4,Pseq([36,43,39,31],inf)),
	\dur,0.5,
	\rq,Pstutter(4,Pn(Pseries(1.0,-0.1,8),inf)),
	\cutoff,Pstutter(4,Pn(Pseries(8000,-1000,7),inf))
);

Ppar([
	Pset(\instrument,Pseq([\bassfoundation],inf),p),
	Padd(\instrument,\basshighend,p)
]).play;
)