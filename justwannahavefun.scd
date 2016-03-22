(

//added some modulation to ring frequency to roughen sound a bit
SynthDef(\justwannahavefun,{|out= 0 freq = 440 amp = 0.1 ringTime=10.0 pan=(-0.1)|

	var impulse, filter, env;

  	impulse = Impulse.ar(0);

	filter = Ringz.ar(impulse,(freq.cpsmidi + (Rand(0.2,1.2)*SinOsc.kr(Rand(10,50)))).midicps,ringTime);

	env = EnvGen.ar(Env([0.0,1.0,1.0,0.0],[0.001,0.04,0.04]),doneAction:2);

	Out.ar(out,Pan2.ar((filter.softclip(0.9))*env*amp,pan));

}).add;


SynthDef(\gatedreverb,{|out =0 gate= 1 threshold= 0.1 amp=0.1|

	var a,c,z,y,in;
	var env = Linen.kr(gate, 0.1, 1, 0.1, 2);

	c = 5; // number of comb delays
	a = 4; // number of allpass delays

	in=In.ar(out,2);

	gate = if((in.mean)>threshold,in.mean,DC.ar(0)!2);

	// reverb predelay time :
	z = gate; //DelayN.ar(gate, 0.048,0.048);

	//for delaytime if want modulation-	//LFNoise1.kr(0.1.rand, 0.04, 0.05)
	y=Mix.arFill(c,{CombL.ar(z,0.1,rrand(0.01, 0.1),rrand(1.5,4))});

	// chain of 4 allpass delays on each of two channels (8 total) :
	a.do({ y = AllpassN.ar(y, 0.051, [rrand(0.01, 0.05),rrand(0.01, 0.05)], 1) });

	Out.ar(out,Pan2.ar(y,0)*env*amp);

}).add;


)

//reverb a bit excessive and resonant, but isn't that fun in itself, Cyndi?
(
Pfx(
	Pbind(
		\instrument,\justwannahavefun,
		\amp,0.5,
		\pan,Pfunc({1.0.rand}),
		\midinote,Pseq(((6!14)++(3!14))+72,inf),
		\dur,Pseq([0.5,0.25,0.5,0.5,0.25,0.5,1.5],inf),
		\ringTime,Pstutter(7,Pn(Pseries(0.1,0.3,8),inf))
	),
	\gatedreverb
).play
)
