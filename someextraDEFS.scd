
(
{
	var trig, snd;
	trig = Impulse.ar(7) * SinOsc.ar(331);
	snd = GVerb.ar(trig, 1) * RLPF.ar(LFSaw.ar(333), LFNoise1.kr(2, 4, 100).midicps);
	snd = Select.ar(
		ToggleFF.ar(Impulse.ar(7) * SinOsc.ar(11.326)),
		[snd, Normalizer.ar(snd * LFPulse.ar(3000), 0.1)]
	);
	Limiter.ar(snd);
}.play;
)
