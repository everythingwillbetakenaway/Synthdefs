(
SynthDef(\sd, { | out=0 |
	var osc1, osc2, env;
	osc1 = WhiteNoise.ar;
	osc2 = FSinOsc.ar(200);
	env = EnvGen.kr(Env.perc(0, 0.05), doneAction: 2);
	Out.ar(out, Pan2.ar(LPF.ar(Mix([osc1, osc2]), 12000), 0, env));
}).add;
)


Synth(\sd);