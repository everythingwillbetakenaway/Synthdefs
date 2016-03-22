(
SynthDef(\pwmbling,{|out= 0 freq = 440 amp = 0.1 gate=1 lforate = 4.85 lfowidth= 0.5 cutoff= 12000 rq=0.25 pan = 0.0|

	var lfo, pulse, filter, env;
	var basefreq =  ((freq.cpsmidi)+[0,12.12]).midicps;

	lfo = LFTri.kr(lforate*[1,1.01],Rand(0,2.0)!2);

	pulse = Pulse.ar(basefreq,lfo*lfowidth+0.5);

	env = EnvGen.ar(Env.adsr(0.0,1.0,0.2,1.5),gate,doneAction:2);

	filter = RLPF.ar(pulse,(cutoff*(env.squared))+100,rq);

	Out.ar(out,Pan2.ar(Mix(filter)*env*amp,pan));

}).add
)


(
Pbind(
	\instrument,\pwmbling,
	\midinote,Prand([0,1,3,5,6,7,10]+60,inf),
	\dur,Pwrand([0.25,0.5],[0.92,0.08],inf),
	\lfowidth,Pn(Pseries(0.0,0.07,7),inf),
	\cutoff,Pstutter(8,Pn(Pseries(10000,-1000,9),inf))
).play
)

