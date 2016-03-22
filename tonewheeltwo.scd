
(
SynthDef(\tonewheeltwo,{|out= 0 freq = 440 amp = 0.1 gate=1 lforate = 4.85 lfowidth= 0.1 cutoff= 5000 rq=0.25 pan = 0.0|

	var lfo, pulse, filter, env;

	lfo = LFTri.kr(lforate*[1,1.01],Rand(0,2.0)!2);

	pulse = Pulse.ar( (((freq*[1,3]).cpsmidi) + (lfo*lfowidth)).midicps,[0.5,0.51],[0.4,0.6]);

	env = EnvGen.ar(Env.adsr(0.0,0.0,1.0,0.1),gate,doneAction:2);

	filter = BLowPass4.ar(pulse,cutoff,rq);

	filter= BPeakEQ.ar(filter,500,1.0,3);

	Out.ar(out,Pan2.ar(Mix(filter)*env*amp,pan));

}).add
)


(
Pbind(
	\instrument,\tonewheeltwo,
	\midinote,Prand([48,50,52,60,64,67,58,72],inf),
	\dur,0.5,
	\rq,Pstutter(6,Pn(Pseries(0.75,-0.1,6),inf)),
	\lfowidth,Pstutter(7,Pn(Pseries(0.0,0.05,10),inf)),
	\cutoff,Pstutter(8,Pn(Pseries(2000,1000,4),inf))
).play
)


