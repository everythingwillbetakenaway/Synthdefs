(
SynthDef(\voicform, { arg out=0, gate=1, freq=440, amp=0.25, voiceGain=0.25, noiseGain=0.2, sweepRate=0.01;

	var voiced = Pulse.ar(freq, 0.1, voiceGain);
	var onezero = OneZero.ar(voiced, -0.9);
	var onepole = OnePole.ar(onezero, 0.97 - (amp*0.2));
	var noise = WhiteNoise.ar(noiseGain*0.1);
	var excitation = onepole + noise;

	var ffreqs = Control.names([\ffreq]).kr([770, 1153, 2450, 3140]);
	var fradii = Control.names([\bw]).kr([0.950, 0.970, 0.780, 0.8]);
	var famps = Control.names([\gain]).kr([1.0, 0.355, 0.0355, 0.011]);

	var filters = TwoPole.ar(excitation, Lag.kr(ffreqs, sweepRate), Lag.kr(fradii, sweepRate), Lag.kr(famps, sweepRate) );

	Out.ar(out, amp*Mix(filters) );
}).add;
)
Synth(\voicform);
