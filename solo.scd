(
	SynthDef(\solo, { | out=0 gate=1 freq=90 |
		var aEnv, fEnv, osc, flt;
		aEnv = EnvGen.kr(Env.asr(0.2, 1, 2), gate);
		fEnv = EnvGen.kr(Env.adsr(0.4, 1.2, 0.7, 2), gate, 800);
		osc = Saw.ar(Lag.kr(freq, 0.1) * [1, 1.005]);
		flt = LPF.ar(osc, fEnv + 600, aEnv);
		Out.ar(out, flt);
	}).add;
)

Synth(\solo);