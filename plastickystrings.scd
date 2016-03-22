//book claims 5.9KHz LFO rate: possible typo...
(
SynthDef(\plastickystrings,{|out= 0 freq = 440 amp = 0.1 gate=1 lforate = 5900 lfowidth= 0.01 cutoff= 12000 rq=0.5 pan=0.0|

	var lfo, saw, filter, env;

	lfo = LFTri.ar(lforate,Rand(0,2.0));

	saw = Saw.ar(freq*(1.0+(lfowidth*lfo)),0.5);

	//filter = BBandPass.ar(saw,freq,4);
	filter = BHiPass.ar(saw,freq,rq); 	//or using cutoff

	env = EnvGen.ar(Env.adsr(0.4,0.0,1.0,1.0),gate,doneAction:2);

	Out.ar(out,Pan2.ar(filter*env*amp,pan));

}).add;


SynthDef(\choruseffect2, {|out =0 gate= 1|
	var source = In.ar(out,2);
	var chorus;
	var env = Linen.kr(gate, 0.1, 1, 0.1, 2);

	chorus= Mix.fill(17, {
		var maxdelaytime= rrand(0.005,0.02);
		DelayC.ar(source, maxdelaytime,LFNoise1.kr(Rand(4.5,10.5),0.25*maxdelaytime,0.75*maxdelaytime) )

	});

	XOut.ar(out,env,0.5*chorus);

}).add;

)


//goldfrapp number 1 riff
(
Pfx(
	Ppar([
		Pbind(
			\instrument, \plastickystrings,
			\amp, 0.2,
			[\midinote,\dur],Pseq([[72,1.5],[68,6.5],[72,1.5],[68,1.5],[61,5.0]],inf),
			\lfowidth,Pn(Pseries(0.0,0.001,16),inf),
			\lforate,5900, //5.9?
			\rq,Pn(Pseries(0.9,-0.05,8),inf)
		),
		Pbind(
			\instrument, \plastickystrings,
			\amp, 0.3,
			[\midinote,\dur],Pseq([[44,8.0],[37,8.0]],inf),
			\lfowidth,Pn(Pseries(0.0,0.001,16),inf),
			\lforate,5.9,
			\rq,0.9
		),
	]),
	\choruseffect2
).play
)



