(

SynthDef(\winwoodlead,{|out= 0 freq = 440 amp = 0.1 gate=1 cutoff=8000 rq=0.8 lfowidth=0.01 lforate= 8 lagamount=0.01 pan=0.0|

	var pulse, filter, env, lfo;

	lfo = LFTri.kr(lforate,Rand(0,2.0)!2);

	pulse = Mix(Pulse.ar((freq.lag(lagamount))*[1,1.001]*(1.0+(lfowidth*lfo)),[0.2,0.19]))*0.5;

	filter =  RLPF.ar(pulse,cutoff,rq);

	//remove low end
	filter = BLowShelf.ar(filter,351,1.0,-9);

	env = EnvGen.ar(Env.adsr(0.01,0.0,0.9,0.05),gate,doneAction:2);

	Out.ar(out,Pan2.ar(filter*env*amp,pan));

}).add;

)



//Pmono allows use of the lag between setting frequency values
(
Pmono(
	\winwoodlead,
	\midinote,Pseq([Pshuf([60,76,77,76,74,72],2)],inf),
	\dur,Pseq([0.5,1.0,0.5,0.5,0.5,1.0],inf),
	\amp,Pseq([0,1,1,1,1,1],inf),
	\lagamount,0.1,
	\lfowidth,Pstutter(6,Pseq([0.0,0.01,0.02,0.03,0.05,0.1],inf)),
	\cutoff,Pstutter(6,Pn(Pgeom(2000,1.5,5),inf))
).play
)



