(

SynthDef(\spacetheremin,{|out= 0 freq = 440 amp = 0.1 gate=1 lforate = 6 lfowidth= 0.5 cutoff= 4000 rq=0.25 lagTime=0.1 pan=0.0|

	var lfo, osc, filter, env;

	lfo = LFTri.kr(lforate+(LFNoise1.kr(5,0.3,0.3)),Rand(0,2.0));

	osc = Saw.ar((freq.lag(lagTime).cpsmidi+(lfo*lfowidth)).midicps,0.5);

	filter = BLowPass4.ar(osc,cutoff.lag(lagTime*4),rq);

	env = EnvGen.ar(Env.adsr(0.6,0.0,1.0,0.05),gate,doneAction:2);

	Out.ar(out,Pan2.ar(filter*env*amp.lag(lagTime*4),pan));

}).add;


SynthDef(\spacereverb,{|out =0 gate= 1 threshold= 0.1 amp=0.1|

	var a,c,z,y,in;
	var env = Linen.kr(gate, 0.1, 1, 0.1, 2);

	c = 6; // number of comb delays
	a = 4; // number of allpass delays

	in=In.ar(out,2);

	// reverb predelay:
	z = DelayN.ar(in, 0.048,0.048);

	y=Mix.arFill(c,{CombL.ar(z,0.1,rrand(0.01, 0.1),5)});

	// chain of 4 allpass delays on each of two channels (8 total) :
	a.do({ y = AllpassN.ar(y, 0.051, [rrand(0.01, 0.05),rrand(0.01, 0.05)], 1) });

	Out.ar(out,Pan2.ar(y,0)*env*amp);

}).add;

)



(
Pfx(
	Pmono(
		\spacetheremin,
		\amp,Prand([0.4,0.45,0.5,0.55,0.5],inf),
		\midinote,Prand([0,2,3,5,6,8,9,11]+60,inf), //octotonic
		\dur,Prand([1.0,1.5,0.5,0.75,1.25,2.0,0.57],inf),
		\lagTime,Pstutter(7,Pn(Pseries(0.05,0.05,8),inf)),
		\lfoRate,Pstutter(9,Pn(Pseries(6,0.5,5),inf)),
		\cutoff,Pstutter(11,Prand([1000,1500,2000,3000],inf))
	),
	\spacereverb
).play
)



