(
	SynthDef(\res, { | out=0 gate=1 freq=40 fltBus |
		var aEnv, osc, flt;
		aEnv = EnvGen.kr(Env.perc(0, 0.7), gate, doneAction: 2);
		osc = Mix([Saw.ar(freq), Pulse.ar(freq / 2, 0.5)]);
		flt = RLPF.ar(osc, In.kr(fltBus, 1), 0.1, aEnv);
			ReplaceOut.kr(fltBus, LFNoise1.kr(0.3, 1000, 1500));

		Out.ar(out, Pan2.ar(flt, 0));
	}).add;

)


Synth(\res);
