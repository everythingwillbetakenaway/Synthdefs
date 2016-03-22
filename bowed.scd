(
SynthDef(\bowed, { arg out=0, amp=1.0, gate=1, freq=420, bowOffset = 0.0, bowSlope = 0.5, bowPosition = 0.75, vibFreq=6.127, vibGain=0.0;
	var betaRatio = 0.027236 + (0.2*bowPosition);
	var baseDelay = freq.reciprocal;
	var lastOut = LocalIn.ar(2);
	var vibrato = SinOsc.ar(vibFreq, 0, vibGain);
	var neckDelay = baseDelay*(1.0-betaRatio) + (baseDelay*vibrato);
	var neck = DelayL.ar(lastOut[0], 0.05, neckDelay);
	var bridge = DelayL.ar(lastOut[1], 0.025, baseDelay*betaRatio);
	var stringFilter = OnePole.ar(bridge*0.95, 0.55);
	var adsr = amp*EnvGen.ar(Env.adsr(0.02, 0.005, 1.0, 0.01), gate, doneAction: 2);
	var bridgeRefl = stringFilter.neg;
	var nutRefl = neck.neg;
	var stringVel = bridgeRefl + nutRefl;
	var velDiff = adsr - stringVel;
	var slope = 5.0 - (4.0*bowSlope);
	var bowtable = (( ((velDiff+bowOffset)*slope) + 0.75 ).abs ).pow(-4).clip(0, 1);
	var newVel = velDiff*bowtable;
	LocalOut.ar([bridgeRefl, nutRefl] + newVel);
	Out.ar(out, Resonz.ar( bridge*0.5, 500, 0.85 ) );
}, [\ir, 0,0, 0, 0, 0, 0, 0, 0]).store;
)

Synth(\bowed);