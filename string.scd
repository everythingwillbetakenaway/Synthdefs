(

SynthDef(\string, { | out=0 gate=1 freq=1000 |
	var aEnv, osc, flt;
	aEnv = EnvGen.kr(Env.asr(0.2, 1, 0.5), gate, doneAction: 2);
	osc = Saw.ar([LFCub.kr(0.3, Rand(0, 1), freq * 0.003, freq), freq, LFCub.kr(0.7, Rand(0, 1), freq * 0.001, freq)]);
	flt = LPF.ar(osc, 1500, aEnv);
	Out.ar(out, flt);
}).add;
)


Synth(\string);