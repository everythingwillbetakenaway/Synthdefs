
(

SynthDef(\spookystrings,{|out= 0 freq = 440 amp = 0.1 gate=1 cutoff=8000 rq=0.2 lfowidth=0.01 lforate=3.8 pan=0.0|

	var pulse, filter, env, lfo;

	lfo = LFTri.kr(lforate,Rand(0,2.0)!2);

	//LFO only on second oscillator
	pulse = Mix(Saw.ar(freq*[1,1.001]*[1.0,1.0+(lfowidth*lfo)]))*0.5;

	filter = BHiPass.ar(pulse,cutoff,rq);

	env = EnvGen.ar(Env.adsr(0.1,0.0,1.0,3),gate,doneAction:2);

	Out.ar(out,Pan2.ar(filter*env*amp,pan));

}).add;

SynthDef(\spookyeffect, {|out =0 gate= 1 delaytime=0.25 phaserate=0.1|
	var source = In.ar(out,2);
	var delay,phaser;

	var env = Linen.kr(gate, 0.0, 1, 0.1, 2);

	delay= DelayN.ar(source,0.8,delaytime);

	phaser = delay;
	//phaser = AllpassN.ar(delay,0.04,SinOsc.kr(phaserate,0,0.005,0.035)); //not working that well, too obvious, need to make more subtle

	Out.ar(out,phaser);

}).add;

SynthDef(\spookystrings2,{|out= 0 freq = 440 amp = 0.1 gate=1 cutoff=8000 rq=0.2 pan=0.0|

	var saw, pulse, filter, env, lfo, pulsewidthlfo;

	lfo = LFTri.kr([3.5,5],Rand(0,2.0)!2);

	pulsewidthlfo = SinOsc.kr(4.5);

	saw = Saw.ar(freq*(1.0+(0.052*lfo[0])));

	pulse = Pulse.ar(freq*(1.0+(0.072*lfo[1])),pulsewidthlfo*0.25+0.5);

	//combine, equal mix
	pulse = 0.5*(saw+pulse);

	//filter specification not the clearest, so just going for slow attack to brightness
	filter = BLowPass.ar(pulse,XLine.kr(678,cutoff,0.378),rq);

	env = EnvGen.ar(Env.adsr(0.1,0.0,1.0,3),gate,doneAction:2);

	Out.ar(out,Pan2.ar(filter*env*amp,pan));

}).add;

)

(
Pfx(
	Pbind(
		\instrument, \spookystrings,
		\midinote,Pseq([69,67,62,59,55],inf),
		\dur,Pseq([9.5,1.5,1.0,1.5,2.5],inf),
		\amp,0.2,
		\lfowidth,0.04,
		\cutoff,1000,
		\rq,0.1
	),
	\spookyeffect
).play
)


(
Pfx(
	Pbind(
		\instrument,\spookystrings2,
		\midinote,Pseq([69,67,62,59,55],inf),
		\dur,Pseq([5.5,1.5,1.0,1.5,2.5],inf),
		\amp,0.2,
		\cutoff,10000,
		\rq,0.5
	),
	\spookyeffect
).play
)

