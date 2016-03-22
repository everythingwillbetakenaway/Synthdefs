(
SynthDef(\fatvelocitybass,{|out= 0 freq = 440 amp = 0.1 gate=1 cutoff= 12000 rq=0.25 lagTime=0.01 pan = 0.0|

	var lfo, osc, filter, env;

	var basefreq =  ((freq.lag(lagTime).cpsmidi)+[0,11.95,31.03]).midicps;

	osc = Saw.ar(basefreq,[0.5,0.4,0.1]); //+PinkNoise.ar(Line.kr(1.0,0,0.03));

	env = EnvGen.ar(Env.adsr(0.01,1.0,1.0,0.25),gate,doneAction:2);

	filter = BLowPass4.ar(osc,100+((amp.squared)*(freq+cutoff)),rq);

	Out.ar(out,Pan2.ar(Mix(filter)*env*amp*0.8,pan));

}).add
)


(
PmonoArtic(
	\fatvelocitybass,
	\midinote,Pseq([13,18,3,1,3,1,3,1,4,1,3]+36,inf),
	\dur,Pseq([0.5,0.5,0.5,0.5,1.0,0.5,1.5,0.5,1.0,0.5,1.0],inf),
	\amp,Pseq([0.7,1.0,0.5,0.6,0.4,0.7,0.8,0.3,0.6,0.4,0.7],inf),
	\cutoff,3000,
	\rq,0.1
).play
)




