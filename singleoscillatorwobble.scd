//vibrato on oscillator
(
SynthDef(\singleoscillatorwobble,{|out= 0 freq = 440 amp = 1.0 gate=1 lforate = 10 lfowidth= 0.5 cutoff= 12000 rq=0.5 pan=0.0|

	var lfo, pulse, filter, env;

	lfo = LFTri.kr(lforate,Rand(0,2.0)!2);

	pulse = Pulse.ar(freq*(1.0+(lfowidth*lfo)),0.5);

	filter = RLPF.ar(pulse,cutoff,rq);

	env = EnvGen.ar(Env.adsr(0.01,0.0,1.0,0.5),gate,doneAction:2);

	Out.ar(out,Pan2.ar(filter*env*amp*0.5,pan));

}).add;


SynthDef(\choruseffect, {|out =0 gate= 1|
	var source = In.ar(out,2);
	var chorus;
	var env = Linen.kr(gate, 0.1, 1, 0.1, 2);

	chorus= Mix.fill(7, {

		var maxdelaytime= rrand(0.005,0.02);

		DelayC.ar(source, maxdelaytime,LFNoise1.kr(Rand(4.5,10.5),0.25*maxdelaytime,0.75*maxdelaytime) )

	});

	XOut.ar(out,env, chorus);

}).add;

)



(
Pmono(
	\singleoscillatorwobble,
	\midinote,Pseq([0,3,8,7,5,8,7,3]+48,inf),
	\dur,Pseq((0.5!8) ++ (1.0!8) ++ (2.0!8),inf),
	\lfowidth,Pn(Pseries(0.0,0.01,7),inf),
	\lforate,Pn(Pseries(2,1,11),inf),
	\rq,Pn(Pseries(0.9,-0.1,5),inf)
).play
)


(
var p =
Pbind(
	\instrument, \singleoscillatorwobble,
	\tempo,2,
	\midinote,Pseq([0,3,8,7,5,8,7,3]+36,24),
	\dur,Pseq((0.5!8) ++ (1.0!8) ++ (2.0!8),1),
	\lfowidth,Pn(Pseries(0.0,0.01,7),4),
	\lforate,Pn(Pseries(2,1,11),3),
	\rq,Pn(Pseries(0.9,-0.1,5),6)
);


Pseq([p,Pfx(p,\choruseffect)],inf).play
)



//trying it on its own
a = Synth(\singleoscillatorwobble);
a.release



