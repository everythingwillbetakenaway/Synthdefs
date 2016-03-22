(

SynthDef('closedhat', {

	var hatosc, hatenv, hatnoise, hatoutput;

	hatnoise = {LPF.ar(WhiteNoise.ar(1),8000)};

	hatosc = {HPF.ar(hatnoise,2400)};
	hatenv = {Line.ar(1, 0, 0.1)};

	hatoutput = (0.5 * hatosc * hatenv);

	Out.ar(0,
		Pan2.ar(hatoutput, 0)
	);

}).add;


)

Synth(\closedhat);