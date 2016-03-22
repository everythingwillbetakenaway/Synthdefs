(

SynthDef(\whoorgan,{|out= 0 freq = 440 amp = 0.1 gate=1 cutoff=8000 rq=0.8 pan=(-0.1)|

	var osc, filter, env;
	var basefreq =  ((freq.cpsmidi)+[0,0.1]).midicps;

	//osc = Mix(Blip.ar(basefreq,16))*0.5;

  	osc = Mix.fill(10,{|i| SinOsc.ar(basefreq*(i+1),0.0,(0.25+(0.75*LFNoise0.kr(10.1+i,0.5,0.5)))/(1.0+(0.5*i)))})*0.2;

	filter =  BLowPass.ar(osc,2000+(amp*cutoff),rq);

	env = EnvGen.ar(Env.adsr(0.02,0.1,0.9,1.0),gate,doneAction:2);

	Out.ar(out,Pan2.ar(Mix(filter)*env*amp,pan));

}).add;


SynthDef(\filtereffect, {|out =0 gate= 1|
	var source = In.ar(out,2);
	var env = Linen.kr(gate, 0.0, 1, 0.1, 2);
	var output;

	output = BLowPass.ar(BLowPass.ar(source,SinOsc.ar(0.25,0,5000,5500),0.4),(200+(5000*SinOsc.ar(4.01,0.5,0.5,0.5))),0.6);

	//output = BLowPass.ar(source,SinOsc.ar(0.275,0,5000,5500),0.1);

	XOut.ar(out,env,output*env);

}).add;

)


(
Pfx(
	Pbind(
		\instrument,\whoorgan,
		\midinote,Pseq([7,5,4,0]+60,inf),
		\dur,0.5,
		\amp,Pstutter(8,Pn(Pseries(0.3,0.05,8),inf)),
		\cutoff,8000
	),
	\filtereffect
).play
)

