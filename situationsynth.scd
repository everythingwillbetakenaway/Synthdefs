(

SynthDef(\situationsynth,{|out= 0 freq = 440 amp = 0.1 gate=1 cutoff=8000 rq=0.8 lfowidth=0.001 lforate= 3.3 pan=(-0.1)|

	var pulse, filter, env, filterenv, lfo;

	lfo = LFTri.kr(lforate,Rand(0,2.0)!2);

	pulse = Mix(Pulse.ar((((freq.cpsmidi)+[0,0.14])+(lfo*lfowidth)).midicps,[0.5,0.51]+(lfowidth*lfo)))*0.5;

	filterenv = EnvGen.ar(Env([0.0,1.0,0.3,0.0],[0.005,0.57,0.1],-3));

	filter =  RLPF.ar(pulse,100+(filterenv*cutoff),rq);

	env = EnvGen.ar(Env.adsr(0.002,0.57,1.0,0.3),gate,doneAction:2);

	Out.ar(out,Pan2.ar(filter*env*amp,pan));

}).add;


SynthDef(\yazoodelayeffect, {|out =0 gate= 1 pan= 0.1|
	var source = In.ar(out,2);
	var delay;
	var env = Linen.kr(gate, 0.0, 1, 0.1, 2);

	delay= DelayC.ar(source[0].distort,0.25,0.25);

	Out.ar(out,Pan2.ar(delay*env,pan));

}).add;

)


//says original tempo 118, we'll keep 120 for note as it's so close.

//Pmono allows use of the lag between setting frequency values
(
Pfx(
	Pbind(
		\instrument,\situationsynth,
		\midinote,Pseq([1,1,13,1,-1,-1,-1,11,8,11,13,1,1,13,1,-1,-1,11,16,15,11,13]+60,inf),	\dur,Pseq([0.5,0.5,0.5,0.25,0.5,0.5,0.25,0.25,0.25,0.25,0.25,0.5,0.5,0.5,0.25,0.5,0.5,0.25,0.25,0.25,0.25,0.25],inf),
		\lfowidth,0.2,
		\cutoff,6000,
		\rq,0.6,
		\pan,-0.1,
		\amp,0.3
	),
	\yazoodelayeffect
).play
)



