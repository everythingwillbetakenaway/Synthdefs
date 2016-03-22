(
SynthDef(\bd, { | out=0 |
	var osc, env;
	osc = FSinOsc.ar(450);
	env = EnvGen.ar(Env.perc(0, 0.55), doneAction: 2);
	Out.ar(out, Pan2.ar(osc, 0, env));
}).add;

)
Synth(\bd);