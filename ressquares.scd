(

SynthDef(\ressquares,{|out= 0 freq = 440 amp = 0.1 gate=1 cutoff=8000 rq=0.8 pan=(-0.1)|

	var pulse, filter, env;

	//2 cents detune for second oscillator
	pulse = Mix(Pulse.ar( ((freq.cpsmidi)+[0,0.02]).midicps, 0.5))*0.5;

	filter =  BLowPass.ar(pulse,100+cutoff,rq);

	env = EnvGen.ar(Env.adsr(0.002,0.1,1.0,0.2),gate,doneAction:2);

	Out.ar(out,Pan2.ar(filter*env*amp,pan));

}).add;


SynthDef(\synthdistortion, {|out =0 gate= 1|
	var source = In.ar(out,2);
	var env = Linen.kr(gate, 0.0, 1, 0.1, 2);
	var abs, excess,output;

	abs = source.abs;

	excess = (abs-0.1).max(0.0).min(0.9)/0.9;

	//original plus sinusoidal perturbation of amount based on absolute amplitude
	output = source+(excess*(sin(excess*2pi*5)*0.5-0.5));

	XOut.ar(out,env,output*env);

}).add;

)


//quite loud, be careful
(
Pfx(
	Pbind(
		\instrument,\ressquares,
		\midinote,Pseq([12,0,0,0,3,0,7,0]+36,inf),
		\dur,0.25,
		\amp,Pstutter(8,Pn(Pseries(0.2,0.08,8),inf)),
		\cutoff,Pstutter(8,Pn(Pseries(100,125,11),inf)),
		\rq,Pstutter(4,Pn(Pseries(0.2,-0.02,9),inf)),
		\pan,-0.1
	),
	\synthdistortion
).play
)

