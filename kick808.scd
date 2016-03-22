
(
SynthDef("kick808", {arg out = 0, freq1 = 240, freq2 = 60, amp = 12, ringTime = 100, rel = 10000, dist = 1.5, pan = 0, tott, durr;
    var snd, env;
	snd = Ringz.ar(
		in: Impulse.ar(0), // single impulse
		freq: XLine.ar(freq1, freq2, 0.1),
		decaytime: ringTime);
	env = EnvGen.ar(Env.perc(0.001, rel, amp), doneAction: 2);
	snd = (1.0 - dist) * snd + (dist * (snd.distort));
	snd = snd * env;
	snd = Limiter.ar(snd, tott, durr) * 0.5 *(1/tott);
	//snd = Clip.ar(snd, -1 * tott, tott);
	//	snd = Fold.ar(snd, -1 * tott, tott);
	//	snd = Wrap.ar(snd, -1 * tott, tott);
	Out.ar(0, Pan2.ar(snd, pan));
}).add;


)

{ SinOsc.ar(200, 0, 0.5) }.plot;

SinOsc
(
Pbind(
	\instrument, "kick808",
	\dur, 0.004,
	\amp, 1,
	\rel, 0.9,
	\dist, 0.015,
	\tott, 0.5,
	\durr, 0.01
).play;
)

Pulse.ar


// modulate frequency
{ Pulse.ar(XLine.kr(40,4000,6),0.1, 0.2) }.play;