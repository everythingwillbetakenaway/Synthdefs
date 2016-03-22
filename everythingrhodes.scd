(
SynthDef(\everythingrhodes,{|out= 0 freq = 440 amp = 0.1 gate=1 lforate = 4.85 lfowidth= 0.5 cutoff= 2000 rq=0.5 pan = 0.0|

	var pulse, filter, env;

	pulse = Pulse.ar(freq*[1,33.5.midiratio],[0.2,0.1],[0.7,0.3]);

	env = EnvGen.ar(Env.adsr(0.0,1.0,0.8,3.0),gate,doneAction:2);

	//keyboard tracking filter cutoff
	filter = BLowPass4.ar(pulse,(cutoff*(env.squared))+200+freq,rq);

	Out.ar(out,Pan2.ar(Mix(filter)*env*amp,pan));

}).add;


//chorus and compression
SynthDef(\choruscompresseffect, {|out =0 gate= 1|
	var source = In.ar(out,2);
	var chorus;
	var env = Linen.kr(gate, 0.1, 1, 0.1, 2);

	chorus= Splay.ar(Array.fill(4,{
		var maxdelaytime= rrand(0.005,0.02);

		DelayC.ar(source[0], maxdelaytime,LFNoise1.kr(Rand(0.1,0.6),0.25*maxdelaytime,0.75*maxdelaytime) )
	}));

	chorus = Compander.ar(4*(source + chorus),source,0.4,1,4);

	XOut.ar(out,env,chorus);

}).add;

)



(
Pfx(
	Pbind(
		\instrument,\everythingrhodes,
		\midinote,Pseq([12,8,7,0,[-12,4,12],[-12,4,12],[-12,4,12],[-11,5,12],[-11,5,12],[-9,7,12],7]+48,inf),
		\dur,Pseq([0.5,0.5,0.5,0.5,1.5,1.0,1.0,1.0,1.0,2.0,0.5],inf),
		\cutoff,Pstutter(11,Pn(Pseries(500,500,4),inf))
	),
	\choruscompresseffect
).play
)