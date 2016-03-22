(
SynthDef(\blowbotl, { arg out=0, amp=1.0, freq= 20, rq=0.1, gate=1, noise=0.1, vibFreq=5.2, vibGain=0.9;
	var lastOut = LocalIn.ar(1);
	var adsr = amp*EnvGen.ar(Env.adsr(0.005, 0.01, 1.0, 0.010), gate, doneAction: 2);
	var vibrato = SinOsc.ar(vibFreq, 0, vibGain);
	var pressureDiff = (adsr+vibrato) - lastOut;
	var jet = (pressureDiff * (pressureDiff.squared - 1.0)).clip2(1.0);
	var randPressure = WhiteNoise.ar(noise)*adsr*(1.0 + pressureDiff);

	var resonator = Resonz.ar(adsr+randPressure - (jet*pressureDiff), freq, rq);
	LocalOut.ar(resonator);
	Out.ar(out, LeakDC.ar(resonator));
}).add;
)



Synth(\blowbotl);