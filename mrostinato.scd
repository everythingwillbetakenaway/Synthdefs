(
SynthDef(\mrostinato,{|out= 0 freq = 440 amp = 0.1 gate=1 lforate = 10 lfowidth= 0.5 pan = 0.0|

	var lfo, pulse, filter, env;

	lfo = LFTri.kr(lforate,Rand(0,2.0)!3);

	pulse = Pulse.ar(freq*[1,1.01,0.5],lfo*lfowidth+0.5);

	env = EnvGen.ar(Env.adsr(0.01,0.05,0.5,0.1),gate,doneAction:2);

	Out.ar(out,Pan2.ar(Mix(pulse)*env*amp,pan));

}).add
)


(
PmonoArtic(
	\mrostinato,
	\octave,Pseq([3,3,4,4],inf),
	\scale,[0,2,3,5,7,8,10],
	\degree,Pstutter(16,Pseq([0,2,5,3],inf)),
	\dur,0.25,
	\lfowidth,Pstutter(8,Pn(Pseries(0.0,0.05,7),inf)),
	\lforate,Pstutter(5,Pn(Pseries(0.5,0.2,11),inf)),
	\pan,Pstutter(2,Prand([-0.5,-0.3,0.3,0.5],inf))
).play
)


 //richer sequence with some heavier moments
(
Pbind(
	\instrument,\mrostinato,
	\sustain,Pstutter(64,Prand([0.1,0.5,0.7],inf)),
	\octave,Pseq([3,3,4,4,3,3,5,2],inf),
	\scale,[0,2,3,5,7,8,10],
	\degree,Pstutter(16,Prand([0,-1,1,2,-3,5,6,3,4,2],inf)),
	\dur,0.25,
	\lfowidth,Pstutter(8,Pn(Pseries(0.0,0.05,7),inf)),
	\lforate,Pstutter(5,Pn(Pseries(0.5,0.2,11),inf)),
	\pan,Pstutter(2,Prand([-0.5,-0.3,0.3,0.5],inf))
).play
)

