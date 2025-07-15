// Nice synth sound taken from the thread "Epic Pads" in the SC mailing list
// http://new-supercollider-mailing-lists-forums-use-these.2681727.n2.nabble.com/Epic-Pads-td7487382.html

(
{
	var freq = { [60,64,65,67].choose.midicps * LFNoise2.ar(1,0.01,1) }!24;
	var gen = LFSaw.ar(freq) * 0.1;
	var fmod = LFCub.ar(1/1).range(1, MouseX.kr(1,16));
	var rqmod = LFNoise2.ar(1/8).range(0.1,1.0);
	var snd = RLPF.ar(gen, freq * fmod, rqmod);
	Splay.ar(snd)
}.play;
)

