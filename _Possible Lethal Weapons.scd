  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  %%                                                                           %%
  %%                                                                           %%
  %%     %%           %%   %%       %%%%%%             %        %%%%%%%%%%     %%
  %%     %%           %%   %%       %%  %%            %%%       %%%%%%%%%%     %%
  %%     %%           %%%%%%%       %%%%%%           %% %%          %%         %%
  %%     %%           %%%%%%%       %% %%           %%%%%%%         %%         %%
  %%     %%      000  %%   %%  000  %%  %%   000   %%     %%   000  %%         %%
  %%     %%%%%%  000  %%   %%  000  %%   %%  000  %%       %%  000  %%         %%
  %%        __________________________________________________________         %%
  %%        [{|-~Language Harmonics Reverberator Abstraction Task~-|}]         %%
  %%%%%%%%%%&--------------------------------------------------------%%%&%%%%%%%%
			/*&Mother of all nodes&*/
"/Users/EmanTnuocca/Desktop/3/defs 2.0/z-multitrack.scd".load;
"/Users/EmanTnuocca/Desktop/3/defs 2.0/z-multitrackCLOSE.scd".load;

"/Users/EmanTnuocca/Google Drive/_rut/SC CODES/defs 1.0/z-multitrack.scd".load;
"/Users/EmanTnuocca/Google Drive/_rut/SC CODES/defs 1.0/z-multitrackCLOSE.scd".load;

//git clone https://github.com/cannc4/Spatial-Orchestra.git

git pull

git add .
git commit -m “Sampler”
git push

/*                                  instrument overview                          /* */ */ OUTDATED /*
-DrumSmpl // Stable           14 par
-SumanGuru //Stable           7 par
-P5pwm //Stable               7 par
-Massaka //Stable             13par
-Acid //Stable                11par
-Lumbricost //mature          8par
-Appajax-2000 //Unmature
-SOStoms                      4par
-SOShats                      3par
-SOSkick                      6par
-SOSsnare                     5par
-Etna                         25par
*/                                                                             */
/*
*/ OUTDATED /*
USB1 (SOSkick#6) (SOSsnare#5) (SOStom#4) (SOShats#3)
USB2 (Acid#11) (Etna#25)
USB3 (Massaka#13)
USB4 (Sumanguru#7) (p5pwm#7)
USB5
USB6 (DRUMSAMPLE#14) (Lumbricost#8)
*/





//////////////MOTHEROFALLNODES START HERE ////////////////////////////////////////////////////////
//////////////MOTHEROFALLNODES START HERE ////////////////////////////////////////////////////////
//////////////MOTHEROFALLNODES START HERE ////////////////////////////////////////////////////////

w = Window.new.front;//cirklonu laptopun ustune koymak icin kullan

/* burada yazan seyi yap!!! kanal kanal kayit ederek
One thing to be aware of is that the soft-synths will have some audio latency relative to the hardware synths.
The "latency matching delay" settings in the MIDI options page let you add a fixed, short delay to the hardware MIDI and CV output, to compensate for that.
If, for example, you have a VST running with 5ms latency, you would dial in 5ms delay on the hardware MIDI outs, so that the audio from the VST lines up with the hardware synths.
*/

//EFFECTS FOR BASS
//play{a=15;b=15;c=100;x=SoundIn.ar([0,1]);y=x;a.do{|i|y=y+(CombL.ar(x,3,(i+1)/b,3)/(a-i))};y*SinOsc.ar(c)} //FX For BassGuitar #Supercollider

//ANOTHET EFX x2
/*(
{
    var snd, envTime, knee, out;
    snd = PlayBuf.ar(1, b, BufRateScale.kr(b), loop: 1);
    envTime = MouseX.kr(1.0e-3, 0.1e-3);
    knee = MouseY.kr(0, -90).dbamp;
    out = DelayC.ar(snd, 0.01, envTime * 0.5) * EnvFollow.ar(snd, 1 - (envTime * SampleRate.ir).reciprocal).max(knee).reciprocal;
    out * 0.1!2
}.play;
)

SynthDef(\dissonator, {
	|out = 0, mix = 1.0|
	var filterfreqs = Array.geom(23, 60, 2**(1/3));
	var rq = ((2**(1/3)) - 1) / (2**(1/6));
	var width = 2**(1/6);
	var fmin = filterfreqs / width;
	var fmax = filterfreqs * width;
	var g = { |f| 2.27 * (f**0.477) };
	var snd, mod;
	snd = In.ar(out);
	snd = BPF.ar(snd, filterfreqs, rq);
	mod = SinOsc.ar(0.5 * g.value((0.2*fmin) + (0.8*fmax)));
	mod = (1 - mix) + (mix * mod);
	snd = snd * mod;
	snd = Mix(snd);
	ReplaceOut.ar(out, snd);
}).add;
*/

({
	SinOsc.ar( // type "j" to activate this envelope 440,
		mul: EnvGen.kr(Env.perc(0.001, 0.2), KeyState.kr(38, 0, 1,0.0001)) )
}.play
)
SoundIn.ar// objesini kullan
(
// useful
var pitch, duration, amplitude, voice; "pch\t\tdur\t\tamp\t\tvce".postln;
20.do({
	pitch = [60, 62, 64, 65, 67, 69, 71].choose;
	duration = 4.0.rand.round(0.1);
	amplitude = 1.0.rand.round(0.1);
	voice = 10.rand;
	"%\t\t%\t\t%\t\t%\n".postf(pitch, duration, amplitude, voice) })
)//GUZEL POST ETMEK ICIN

(
w = Window.new("I catch keystrokes");
w.front;
)
(
MIDIIn.connectAll;

MIDIFunc.cc({arg ...args; args.postln}, (0..90)); // match cc 0-90
)





(
v = s.volume;

v.min;
v.max;
v.volume = 0.5;
v.setVolumeRange(-90, 20);
v.mute;
v.unmute;

// separate window
v.gui;
)

s.plotTree;

x = { SinOsc.ar(440, 0, 0.3) }.asSynthDef; // this must complete first
y = Synth(x);
do
Routine

63.linlin(0,127,-12,12)

MIDIdef.noteOn(\noteOnTest, {"key down".postln}.permanent_(true);

	1.dbamp;
	3.log10;
	0.7*0.7;

	(
		~midiport = MIDIOut.newByName("Cirklon", "Port 1");
		~midiport.control(0, 0, 0);
		~midiport.control(0, 1, 0);
		~midiport.control(0, 2, 0);
		~midiport.control(0, 3, 0);
		~midiport.control(0, 4, 0);
		~midiport.control(0, 5, 0);
		~midiport.control(0, 6, 0);
		~midiport.control(0, 7, 0);
		~midiport.control(0, 8, 0);
		~midiport.control(0, 9, 0);
		~midiport.control(0,10, 0);
		~midiport.control(0,11, 0);
		~midiport.control(0,12, 0);
		~midiport.control(0,13, 0);
		~midiport.control(0,14, 0);
		~midiport.control(0,15, 0);
		~midiport.control(0,16, 0);
		~midiport.control(0,17, 0);

	);
	(-6).dbamp;
	0.5.ampdb;



	 /*____________KeyActions____________*/


	win.view.keyDownAction = {|a, b, c, d, e|

		var wat;

		case {e==12} {AppClock.sched(0, {controlbuttons[0].valueAction_(1); nil;})}
			{e==13} {AppClock.sched(0, {controlbuttons[0].valueAction_(0); nil;})}
			{e==6} {AppClock.sched(0, {panicbut.valueAction_(0); nil;})}
			{e==7} {AppClock.sched(0, {panicbut.valueAction_(1); nil;})}
			{e==27}
			{
				wat = (h.string.asInteger-1).clip(0, 128);
				AppClock.sched(0, {h.string_((wat).asString);
					nil;} );
			}
			{e==24}
			{
				wat = (h.string.asInteger+1).clip(0, 128);
				AppClock.sched(0, {h.string_((wat).asString);
					nil;} );
			}
			{e==17}
			{
				wat = (~noteres-1).clip(0.25, 16);
				~noteres = wat;
				AppClock.sched(0, {j.string_((wat).asString);
					~tmpclck.tempo_(((g.string.asFloat)/60)*~noteres);
					nil;});
			}
			{e==16}
			{
				wat = (~noteres+1).clip(0.25, 16);
				~noteres = wat;
				AppClock.sched(0, {j.string_((wat).asString);
					~tmpclck.tempo_(((g.string.asFloat)/60)*~noteres);
					nil;});
			}
			{e==5}
			{
				wat = (~noteres-0.25).clip(0.25, 16);
				~noteres = wat;
				AppClock.sched(0, {j.string_((wat).asString);
					~tmpclck.tempo_(((g.string.asFloat)/60)*~noteres);
					nil;});
			}
			{e==4}
			{
				wat = (~noteres+0.25).clip(0.25, 16);
				~noteres = wat;
				AppClock.sched(0, {j.string_((wat).asString);
					~tmpclck.tempo_(((g.string.asFloat)/60)*~noteres);
					nil;});
			}
			{e==11}
			{
				wat = (~noteres-3).clip(0.25, 16);
				~noteres = wat;
				AppClock.sched(0, {j.string_((wat).asString);
					~tmpclck.tempo_(((g.string.asFloat)/60)*~noteres);
					nil;});
			}
			{e==45}
			{
				wat = (~noteres+3).clip(0.25, 16);
				~noteres = wat;
				AppClock.sched(0, {j.string_((wat).asString);
					~tmpclck.tempo_(((g.string.asFloat)/60)*~noteres);
					nil;});
			}
			{e==43}
			{
				wat = (g.string.asFloat-1).clip(0.25, 400);
				AppClock.sched(0, {g.string_((wat).asString);
					~tmpclck.tempo_(((g.string.asFloat)/60)*~noteres);
					nil;});
			}
			{e==47}
			{
				wat = (g.string.asFloat+1).clip(0.25, 400);
				AppClock.sched(0, {g.string_((wat).asString);
					~tmpclck.tempo_(((g.string.asFloat)/60)*~noteres);
					nil;});
			}
			{e==31}
			{
				wat = (g.string.asFloat-10).clip(0.25, 400);
				AppClock.sched(0, {g.string_((wat).asString);
					~tmpclck.tempo_(((g.string.asFloat)/60)*~noteres);
					nil;});
			}
			{e==35}
			{
				wat = (g.string.asFloat+10).clip(0.25, 400);
				AppClock.sched(0, {g.string_((wat).asString);
					~tmpclck.tempo_(((g.string.asFloat)/60)*~noteres);
					nil;});

			}
			{e==37}
			{
				wat = (g.string.asFloat-20).clip(0.25, 400);
				AppClock.sched(0, {g.string_((wat).asString);
					~tmpclck.tempo_(((g.string.asFloat)/60)*~noteres);
					nil;});
			}
			{e==41}
			{
				wat = (g.string.asFloat+20).clip(0.25, 400);
				AppClock.sched(0, {g.string_((wat).asString);
					~tmpclck.tempo_(((g.string.asFloat)/60)*~noteres);
					nil;});
			}
			{e==33}
			{
				wat = (g.string.asFloat-50).clip(0.25, 400);
				AppClock.sched(0, {g.string_((wat).asString);
					~tmpclck.tempo_(((g.string.asFloat)/60)*~noteres);
					nil;});
			}
			{e==30}
			{
				wat = (g.string.asFloat+50).clip(0.25, 400);
				AppClock.sched(0, {g.string_((wat).asString);
					~tmpclck.tempo_(((g.string.asFloat)/60)*~noteres);
					nil;});
			}
			{e==18}
			{
				AppClock.sched(0, {i.string_("1");
					~barlength = 1; nil;});
			}
			{e==19}
			{
				AppClock.sched(0, {i.string_("2");
					~barlength = 2; nil;});
			}
			{e==20}
			{
				AppClock.sched(0, {i.string_("3");
					~barlength = 3; nil;});
			}
			{e==21}
			{
				AppClock.sched(0, {i.string_("4");
					~barlength = 4; nil;});
			}
			{e==23}
			{
				AppClock.sched(0, {i.string_("5");
					~barlength = 5; nil;});
			}
			{e==22}
			{
				AppClock.sched(0, {i.string_("6");
					~barlength = 6; nil;});
			}
			{e==26}
			{
				AppClock.sched(0, {i.string_("7");
					~barlength = 7; nil;});
			}
			{e==28}
			{
				AppClock.sched(0, {i.string_("8");
					~barlength = 8; nil;});
			}
			{e==25}
			{
				AppClock.sched(0, {i.string_("9");
					~barlength = 9; nil;});
			}
			{e==29}
			{
				AppClock.sched(0, {i.string_("0");
					~barlength = 0; nil;});
			};
	};

	// Here is a list of key state numbers:
// 1-18; 2-19; 3-20; 4-21; 5-23; 6-22; 7-26; 8-28; 0-29; --27; =-24 q-12; w-13; e-14; r-15; t-17; y-16; u-32; i-34; o-31; p-35
// a-0; s-1; d-2; f-3; g-5; h-4; j-38; k-40; l-37; ;-41; '-39 z-6; x-7; c-8; v-9; b-11; n-45; m-46; ,- 43; .-47; /-44;




    Flame Hurricane
    The V1 - a replica of a WWII V1 engine
    Hand-O'-God - a giant spring-loaded hand, cocked by an air cylinder
    The Pitching Machine - a device which fires 2x4 pieces of lumber
    Shockwave Cannon - a device which fires a shockwave of air, shattering glass remotely with the force, constructed similarly to the shockwave-based Wunderwaffen anti-bomber device or the so-called hail cannon.
    Wheelocopter - a spinning machine which applies the principles of rotorcraft to a two-dimensional plane
    Six-Legged Running Machine
    High Pressure Air Launcher - originally developed by NASA for use in avalanche control; fires beer cans filled with plaster using a CO2 charge


	//BPM CALCULATOR start
	//BPM CALCULATOR start
	//BPM CALCULATOR start

b.increment; // increment or decrement by step
b.decrement;
k.values
b.values = k;
k = {SinOsc.kr(5, 0, 1, 0)}.play;
k

(
SynthDef("DrumSmpl_Recorder", { arg out = 0, starter = 0;
	var formant,abc, testcase;
	formant = SoundIn.ar(2,1,0);
	abc = InRange.ar(formant,0.5);
	testcase = (16 * (1 /  Timer.ar(abc))).poll;
	/*RecordBuf.ar(formant, bufnum, doneAction: 2,
		loop: SetResetFF.ar(DC.ar(1),abc),
		run:((SetResetFF.ar(DC.ar(1),abc) * -1) + 1),
		trigger:((SetResetFF.ar(DC.ar(1),abc) * -1) + 1)//abc-0.001
	);*/
}).play;)

// world's most expensive patchcord (use headphones to avoid feedback)
{ SoundIn.ar(2).poll }.play;
~dfk.value;
(
{ var trig;
	    trig = Impulse.kr(MouseX.kr(0.5, 20, 1));
	~dfk = Timer.kr(trig).poll;
	    SinOsc.ar(Timer.kr(trig) * 500 + 500, 0, 0.2)
}.play;
)
//BPM CALCULATOR end
	//BPM CALCULATOR end
	//BPM CALCULATOR end


	//OPENING THEME STARTTTTTT
	//OPENING THEME STARTTTTTT
	//OPENING THEME STARTTTTTT


	//Making Habits
(
play {
    var env = Line.kr(1,0,0.2,mul:1,doneAction:2);
    var sig = PinkNoise.ar(env);
    FreeSelf.kr(TDelay.kr(Done.kr(env),3));
    GVerb.ar(sig,7,1,mul: 0.2);
}
)
/*

(
var abc = rrand(1,13).asInteger;
fork{
	// notes sequence
	var seq = Pxrand([0,3,5,7,8],abc).asStream;
	loop{
		var dur = 4/abc;
		var num = rrand(4,17).asInteger;
		var root = rrand(1,116).asInteger;
		var freq = (seq.next + root).midicps;
		var spread = rrand(0.4,0.8);
		var attack = rrand(0.05, 0.3);

		// play the cluster
		play{
			var harm = Array.geom(num, 1, 1.5);
			var harma = Array.geom(num, 0.5, 0.8);
			var detune = Array.fill(num, { LFNoise2.kr(1,0.01,1) });
			var source = PinkNoise.ar;
			var bandwidth = Rand(0.001,0.01);
			var dfdf = Line.kr(1, 0, dur:15, doneAction:2);
			var generator = [
				SinOsc.ar(freq*harm*detune, mul:harma*0.3).scramble,
				Resonz.ar(source, freq*harm*detune, bandwidth, mul:harma).scramble * 50
			].wchoose([0.2,0.8]);
			var snd = Splay.ar(generator,spread);
			var abcd = DetectSilence.ar(snd, doneAction:2);
			snd * dfdf * LFGauss.ar(dur, attack, loop:0, doneAction:2);
		};
		dur.wait;
	};

};

// global triple super gverb
{
	var abcd;
	var in = In.ar(0,2);
	var dfdf = Line.kr(1, 0, dur:15, doneAction:2);
	in = (in*0.2) + GVerb.ar(in, 220, 12, mul:0.6);
	in = (in*0.2) + GVerb.ar(in, 220, 12, mul:0.6);
	in = (in*0.2) + GVerb.ar(in, 220, 12, mul:0.6);
	abcd = DetectSilence.ar(in,amp:0.001, doneAction:2);
	ReplaceOut.ar(0,  dfdf * Limiter.ar(LeakDC.ar(in)))
}.play(addAction:\addToTail);



{
	var bufo = Buffer.read(s, "/Users/EmanTnuocca/Documents/SC CODES/defs/ege.wav"); // remember to free the buffer later.
	var rand1 = Rand(0.1, 0.5);
	var rand2 = Rand(0.5, 1);
	var rand3 = Rand(1, 1.6);
	var rand4 = Rand(1.6, 3.6);
	var gbc2 = PlayBuf.ar(1, bufo);
	var del1 = CombL.ar((gbc2), rand1, rand1,  Rand(0.6,12));
	var del2 = CombL.ar((del1), rand2, rand2,  Rand(0.6,12));
	var del3 = CombL.ar((del2), rand3, rand3, Rand(0.6,12));
	var del4 = CombL.ar((del3), rand4, rand4,  Rand(0.6,12));
			var dfdf = Line.kr(1, 0, dur:15, doneAction:2);
	del4 = (del4*0.2) + GVerb.ar(del4, 220, 12, mul:0.6);
	Out.ar([0,1], dfdf * 0.33 *del4)}.play(addAction:\addToTail);
)*/

		//OPENING THEME end
		//OPENING THEME end
		//OPENING THEME end



	+TOTVOL,
+BPM of Track
+Preset load-1
+Preset load-2

CC# 0) Algorithm   -- "Algorithm"= 0-31 -------> DONE!
CC# 1) Feedback    -- "Feedback" = 0-7 -------> DONE!
CC# 2) Osc Key Sync -- "Oscillator_Sync" = 0-1 -------> DONE!
CC# 3) Transpose -- "Transpose" = 0-48 -------> DONE!
CC# 4) LFO speed -- "LFO_Speed" = 0-99 -------> DONE!
CC# 5) LFO wave  -- "LFO_Waveform" = 0-5 // triangle, saw down, saw up, square, sine, S&H -------> DONE!
CC# 6) LFO delay -- "LFO_Delay" = 0-99 -------> DONE!
CC# 7) LFO PMD   -- "LFO_PMD" = 0-99 -------> DONE!
CC# 8) LFO AMD   -- "LFO_AMD" = 0-99 -------> DONE!
CC# 9)LFO Key Sync -- "LFO_Sync" = 0-1 -------> DONE!
CC# 10)LFO PMS -- "LFO_PitchModSens" = 0-7 -------> DONE!
CC# 11)Pitch EG Rate-1 -- "Pitch_EG_R1_reversed" = 0-99 -------> DONE!
CC# 12)Pitch EG Rate-2 -- "Pitch_EG_R2_reversed" = 0-99 -------> DONE!
CC# 13)Pitch EG Rate-3 -- "Pitch_EG_R3_reversed" = 0-99 -------> DONE!
CC# 14)Pitch EG Rate-4 -- "Pitch_EG_R4_reversed" = 0-99 -------> DONE!
CC# 15)Pitch EG Level-1-- "Pitch_EG_L1" = 0-99 -------> DONE!
CC# 16)Pitch EG Level-2-- "Pitch_EG_L2" = 0-99 -------> DONE!
CC# 17)Pitch EG Level-3-- "Pitch_EG_L3" = 0-99 -------> DONE!
CC# 18)Pitch EG Level-4-- "Pitch_EG_L4" = 0-99 -------> DONE!

//////////////MOTHEROFALLNODES END HERE ////////////////////////////////////////////////////////
//////////////MOTHEROFALLNODES END HERE ////////////////////////////////////////////////////////
//////////////MOTHEROFALLNODES END HERE ////////////////////////////////////////////////////////


//SELECTED UGENS!////SELECTED UGENS!////SELECTED UGENS!////SELECTED UGENS!// start ! start ! start ! start ! start ! start ! start ! start ! start ! start !
//SELECTED UGENS!////SELECTED UGENS!////SELECTED UGENS!////SELECTED UGENS!// start ! start ! start ! start ! start ! start ! start ! start ! start !
//SELECTED UGENS!////SELECTED UGENS!////SELECTED UGENS!////SELECTED UGENS!// start ! start ! start ! start ! start ! start ! start ! start !

deterministic generators
ugens physical models
menuye dahil olmayan generator = KmeansToBPSet1

//PV area
PV_MagFreeze * //drummlara yap total
PV_BinScramble
PV_BinShift
PV_BinWipe //open close hihat
PV_BrickWall
PV_ConformalMap *
PV_Compander
PV_Diffuser
PV_MagClip *
PV_MagDiv //icice gecen drumlarda
PV_MagNoise *
PV_MagShift *
PV_MagSmear *
PV_Morph
PV_MagSmooth *
PV_RandComb
PV_RandWipe
PV_RectComb//hihat

(// random gaps and phase offsets
   var buffer = Buffer.read(Server.default, Platform.resourceDir +/+
     "sounds/a11wlk01.wav"); // read a soundfile into the buffer
   {var signal = PlayBuf.ar(1,buffer,BufRateScale.kr(buffer),loop:1);
       signal = FFT(LocalBuf(1024),signal);
       signal = PV_RandComb(signal, LFNoise0.kr(1).range(0.3,1));
   // add random gaps, modulately randomly
       signal = PV_Diffuser(signal,Impulse.kr(1)); // randomly bias
   phases, new distributions every second
       signal = IFFT(signal); // synthesize time-domain equivalent
   }.scopeResponse;
)



// AY
Squiz
BMoog // engengenl
CrossoverDistortion
DFM1 //0, 31 degerler res icin bir bak kesinlikle = degerleri hesapla dry/wet BRF ile temizle
Decimator
Disintegrator // mul ile carp ses az cikiyo, snare icin uygun
RLPFD //acide gom diste dikkat
SVF // digital fuck
MoogFF//general
SineShaper
SmoothDecimator
Streson
shaper
twotubes
ntube
mdapiano
MantissaMask
membranehexagon
waveloss
vosim
fof
formlet
JPverb
Greyhole
ComplexRes
DiodeRingMod // all masibo effect
DNoiseRing
DWGBowed
DWGBowedSimple
DWGBowedTor
DWGPlucked
DWGPlucked2
DWGPluckedStiff
STK
STK
STK

blip ve cosc ile synth yap ayri ayri
b = Buffer.read(s, Platform.resourceDir +/+ "sounds/a11wlk01.wav"); // remember to free the buffer later.
b = Buffer.read(s, Platform.resourceDir +/+ "sounds/etna3.aiff"); // remember to free the buffer later.


b = Buffer.read(s, Platform.resourceDir +/+ "sounds/blankingdown.wav"); // remember to free the buffer later.
(
SynthDef(\help_PlayBuf, {| out = 0, bufnum = 0 |
	var playbuf, filt;
	playbuf = PlayBuf.ar(1, bufnum, BufRateScale.kr(bufnum), loop: 0, startPos: 44100 * 40);
	filt = SmoothDecimator.ar(playbuf,MouseX.kr(0.003, 0.003), MouseY.kr(0.9, 0.9)); // MouseY.kr(0.1,1));
	Out.ar(out, filt)//(filt + playbuf)/2)
}).play(s, [\out, 0, \bufnum, b]);
)



(
SynthDef(\ay1, { | freqa=440, freqb=550, freqc=660, vola=15, volb=0, volc=0, chink=1, wobbly=1,mul = 1, pan=0, amp=0.1, gate=1|
	    var ay, chinkenv, wobblyenv, noise, cont, envfq, envst, chiptyp;

	    //chinkenv = if(chink>0, EnvGen.kr(Env.new([0.06125, 0.06125, 1, 1], [0.05, 0, 0.1], 0, 4, 4)), 1);
	    chinkenv = if(chink>0, EnvGen.kr(Env.new([2, 2, 1, 1], [0.05, 0, 0.1], 0, 4, 4)), 1);
	    wobblyenv = LFPulse.kr(10, 0.5, mul:wobbly).range(0.5, 1);

	    # freqa, freqb, freqc = [freqa, freqb, freqc] * [1, wobblyenv, wobblyenv] * chinkenv;
	    ay = AY.ar(AY.freqtotone(freqa), AY.freqtotone(freqb), AY.freqtotone(freqc),
		        noise, cont, vola, volb, volc,envfq,envst,chiptyp mul: amp);
	    ay = ay * EnvGen.kr(Env.asr(0.01, 1, 0.05), gate, doneAction:2);
	    Out.ar(0, Pan2.ar(ay, pan));
}).load(s);
)

x = Synth(\ay1, [\wobbly, 0, \chink, 1, \tonea, 1000.rand]);
x.free;

SynthDescLib.read;

// Use the synth in a jerky lo-fi pattern of some sort...
(
Pbind(
	    \instrument, \ay1,
	    \freqa,    Pseq((#[55, 55, 57, 58, 57, 55, 58, 50]-12).midicps, inf),
	    \freqb,    Pseq([
		                    Pseq( (#[55, 55, 54, 55, 54, 55, 58, 57]+12).midicps, 2),
		                    Prand((#[55, 55, 54, 55, 54, 55, 58, 57]+12).midicps, 2)
	                ], inf),
	    \dur,    Pseq(#[3, 0.5, 0.5, 1.5, 0.5, 1, 1, 4] * 0.4, inf),
	    \wobbly,    Pstutter(8 * 4, Prand(#[0, 1], inf)),
	    \vola,    15,
	    \volb,    14,
	    \chink,    1,
	\noise, 10,
	\cont, 32,
	\envfq, 1404,
	\envst, 13,
	\chiptyp, 1,
	    \amp,    0.4
).play
)





(
{GlitchHPF.ar(
	Pulse.ar(200),
	Saw.kr(1, 5000, 2200),
	1
)}.play;
)//////////////////////////////////////////////////////

{DFM1.ar(Pulse.ar(100, mul:0.4) + Pulse.ar(100.1, mul:0.4), SinOsc.kr(SinOsc.kr(0.3).range(0.2, 5)).range(80, 2000), 1.1, inputgain: 2.0, mul:0.7, type: 0.5)!2}.play;




(
{
    var in, chain;
    in = WhiteNoise.ar(0.8);
    chain = FFT(LocalBuf(2048), in);
    chain = PV_RandComb(chain, 0.3, Impulse.kr(15.4));
    IFFT(chain)
}.play;
)

(
{
    var in, chain;
    in = WhiteNoise.ar(0.2);
    chain = FFT(LocalBuf(2048), in);
    chain = PV_RectComb(chain, 8, LFTri.kr(0.097,0,0.4,0.5),
        LFTri.kr(0.24,0,-0.5,0.5));
    IFFT(chain)
}.play;
)

(
{
    var in, chain;
    in = SinOsc.ar(LFNoise1.kr(5.2,250,400));
    chain = FFT(LocalBuf(2048), in);
    // moves in and out of freeze
    chain = PV_MagFreeze(chain, SinOsc.kr(2.2) );
(	    0.5 * IFFT(chain))!2;
}.play;
)


b = Buffer.alloc(s,2048,1);

(
SynthDef("help-brick", { arg out=0, bufnum=0;
    var in, chain;
    in = {WhiteNoise.ar(0.2)}.dup;
    chain = FFT(bufnum, in);
	    chain = PV_BrickWall(chain, MouseX.kr(-1,1));
    Out.ar(out, IFFT(chain).dup);
}).play(s,[\out, 0, \bufnum, b.bufnum]);
)


{ IFFT(PV_BrickWall(FFT(b,Mix(LFSaw.ar([120, 180], 0, 0.33)), LinExp.kr(LFCub.kr(0.1, 0.5*pi), -1, 1, 280, 1500)).dup, MouseX.kr(-1,1))) }.play

// ! end ! end ! end ! end ! end ! end ! end ! end ! end ! end ! end ! end ! end ! end ! end ! end ! end ! end !
//SELECTED UGENS!////SELECTED UGENS!////SELECTED UGENS!////SELECTED UGENS!// end ! end ! end ! end ! end ! end ! end ! end !
//SELECTED UGENS!////SELECTED UGENS!////SELECTED UGENS!////SELECTED UGENS!// end ! end ! end ! end ! end ! end ! end ! end ! end ! end !
//SELECTED UGENS!////SELECTED UGENS!////SELECTED UGENS!////SELECTED UGENS!// end ! end ! end ! end ! end ! end ! end ! end ! end ! end ! end ! end !


// HERSEYI BURADA DENE| TAMAMEN MUKEMMEL ISE WITCH PLANE E AL


(
{
	var scale = 300, offset = 500, synch = 1;
	SinOsc.ar(SinOsc.ar(1/synch, mul: scale, add: offset), mul: 0.1) +
	SinOsc.ar(SinOsc.ar(1/synch, mul: scale, add: offset), mul: 0.1) +
	SinOsc.ar(SinOsc.ar(1/synch, mul: scale, add: offset), mul: 0.1) +
	SinOsc.ar(SinOsc.ar(1/synch, mul: scale, add: offset), mul: 0.1) +
	SinOsc.ar(SinOsc.ar(1/synch, mul: scale, add: offset), mul: 0.1) +
	SinOsc.ar(SinOsc.ar(1/synch, mul: scale, add: offset), mul: 0.1) }.play
)
( // synchronized triggers
{
	var synch = 10;
	SinOsc.ar(400, mul: EnvGen.kr(Env.perc(0, 1), Impulse.kr(3/synch))) +
	SinOsc.ar(330, mul: EnvGen.kr(Env.perc(0, 1), Impulse.kr(7/synch))) +
	SinOsc.ar(430, mul: EnvGen.kr(Env.perc(0, 1), Impulse.kr(5/synch))) +	￼
	SinOsc.ar(700, mul: EnvGen.kr(Env.perc(0, 1), Impulse.kr(2/synch))) +
	SinOsc.ar(430, mul: EnvGen.kr(Env.perc(0, 1), Impulse.kr(9/synch))) +
	SinOsc.ar(1000, mul: EnvGen.kr(Env.perc(0, 1), Impulse.kr(6/synch))) +
	SinOsc.ar(540, mul: EnvGen.kr(Env.perc(0, 1), Impulse.kr(1/synch))) * 0.1 }.play
)

// Expressing frequencies and durations as fractions facilitates synchronization of LFO frequencies; something that is very difficult on vintage synths. Imagine, for example, six pitches of a chord, each with a trigger, attack, decay, and duration. If the first has a trigger rate of 2/1 (2 in one second), the next has 3/1, then 4/1, 5/1, etc., then they will all be synched up every second. Likewise, triggers of 3/15, 4/15, 7/15, 11/15, etc., will all be in synch every 15 seconds.The same is true for frequency. If 10 SinOsc ugens have related frequencies, expressed as ratios, they will be in synch periodically at the interval expressed by the denominator. That sentence is a mouthful, so here is an example. Five SinOsc's with frequencies of 4/10, 3/10, 6/10, 7/10, will fall back into synch every ten seconds24.




//4 Artifact 44

{RLPF.ar(PinkNoise.ar(0.3), LFNoise0.kr([3, 3], 300, 900), 0.001)}.play




//6 Env Env

( SynthDef.new("KSpluck3",
	{ //Beginning of Ugen function
		arg midiPitch, art;
		var burstEnv, att = 0, dec = 0.01, legalPitches; //Variable declarations
		var out, delayTime;
		delayTime = [midiPitch, midiPitch + 12].midicps.reciprocal;
		burstEnv = EnvGen.kr(Env.perc(att, dec));
		out = PinkNoise.ar([burstEnv, burstEnv]); //Noise burst
		out = CombL.ar(out, delayTime, delayTime,
			art, add: out); //Echo chamber
		out = RLPF.ar(out, LFNoise1.kr(1, 13000, 14010), 0.1); //Filter ADSR GELSIN BURAYA
		DetectSilence.ar(out, doneAction:2);
		Out.ar(0, out*0.8)
	}
).play; )


(
r = Task({
{Synth("KSpluck3",
[
\midiPitch, [5, 10].choose + [30].choose, \art, [0.125, 0.25, 0.5, 1.0, 2.0].choose
]);
		//Choose a wait time before next event
[0.125, 0.125, 0.125, 0.125, 0.125, 1].choose.wait; }.loop;
}).play(SystemClock) )

////SAWWWWWWW/////////////////////////////////////////////////////////////////

(
SynthDef("SyncSaw-Ex", {
	arg freq;
	var sig, env,filtL,filtH;
	env = EnvGen.kr(Env.linen(rrand(1.0, 3.0), rrand(4.0, 7.0), rrand(2.0, 3.0)), doneAction: 2);
	sig = SyncSaw.ar(
		[freq, freq*1.002], //Saw frequency
		SinOsc.ar(1/5, [0, 3.0.rand], mul: freq*2, add: freq*3), mul: 0.1);
	sig = CombC.ar(sig, 0.3, 0.3, 4, 1); //Add echo
	sig = sig*env;
	Out.ar(0, sig*0.8)
}).play(s)
)
(
//run a task to play the synth
r = Task({
{Synth("SyncSaw-Ex", [\freq, rrand(30, 60).midicps]); //Choose a wait time before next event
rrand(2.0, 5.0).wait;
}.loop;
}).play )

//////////////////////////////////////////////////////////////////////




(
b.write(sampleFormat: 'int16');
///-/.ENS 491.\-\\\






thisProcess.platform.recordingsDir +/+ "SC_" ++ Date.localtime.stamp ++ ".aiff"; // generated path
)

b.close; b.free; // cleanup


b = Buffer.alloc(s, 44100 * 2.0, 1);
c = Buffer.alloc(s, 44100 * 2.0, 1);


(
SynthDef(\help_RecordBuf, { arg out = 0, bufnum = 0;
	var formant,abc;
	formant = SoundIn.ar(1,1,0);
	abc = Changed.ar(formant,0.001);
	RecordBuf.ar(formant, bufnum, doneAction: 2,
		loop: SetResetFF.ar(DC.ar(1),abc),
		run:((SetResetFF.ar(DC.ar(1),abc) * -1) + 1),
		trigger:((SetResetFF.ar(DC.ar(1),abc) * -1) + 1)//abc-0.001
	);
}).play(s,[\out, 0, \bufnum, c]);
)

(
SynthDef(\help_RecordBuf_overdub, { arg out = 0, bufnum = 0;
	var playbuf,comp;
	//playbuf = BufRd.ar(1, b, Phasor.ar(0, BufRateScale.kr(b) * 1.3, 0, BufFrames.kr(b)), loop:0, interpolation:1);

	playbuf = PlayBuf.ar(1,bufnum,1);
	FreeSelfWhenDone.kr(playbuf); // frees the synth when the PlayBuf is finished
	comp =  Compander.ar(playbuf, playbuf,
		        thresh: 0.01,
		        slopeBelow: 10,
		        slopeAbove: 1,
		        clampTime: 0.01,
		        relaxTime: 0.01
	    );
	Out.ar(out, comp);
}).play(s, [\out, 1, \bufnum, b]);
)

(
SynthDef(\help_RecordBuf_overdub, { arg out = 0, bufnum = 0;
	var playbuf,comp;
	//playbuf = BufRd.ar(1, b, Phasor.ar(0, BufRateScale.kr(b) * 1.3, 0, BufFrames.kr(b)), loop:0, interpolation:1);

	playbuf = PlayBuf.ar(1,bufnum,0.9);
	FreeSelfWhenDone.kr(playbuf); // frees the synth when the PlayBuf is finished
	comp =  Compander.ar(playbuf, playbuf,
		thresh: SinOsc.ar(1,0,0.2,0.2),
		        slopeBelow: 10,
		        slopeAbove: 1,
		        clampTime: 0.01,
		        relaxTime: 0.01
	    );
	Out.ar(out, comp);
}).play(s, [\out, 1, \bufnum, c]);
)

0.5.ampdb

BufWr

3.linexp(0,127,0.01,1);

decibel
0.01.ampdb
-12asd.dbamp


-0.56.dbamp


///////////

b = Buffer.read(s, Platform.resourceDir +/+ "sounds/a11wlk01.wav");

// now play it
(
x = SynthDef("tutorial-PlayBuf",{ arg out = 0, bufnum;
    Out.ar( out,
        PlayBuf.ar(1, bufnum, BufRateScale.kr(bufnum))
    )
}).play(s,[\bufnum, b]);
)
x.free; b.free;
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
{ Amplitude.kr(SoundIn.ar(0)); }.scope;

{ Pulse.ar(90, 0.3, Amplitude.kr(SoundIn.ar(0))) }.play;

(
{
var input,inputAmp,threshhold,gate;
var basefreq;

input = SoundIn.ar(0);
inputAmp = Amplitude.ar(input);
threshhold = 0.01;	// noise gating threshold
gate = Lag.ar(inputAmp > threshhold, 0.1);
(input * gate)
}.play;
)
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////



(
{
var bufNum = b, srate = 44100, start = 0, end = 1,
rate = 1, totalDur = 20, pan = 0; var out, duration, total;
start = 0; end = 1; total = BufFrames.kr(bufNum)/44100; end = end*total; start = start*total; duration = abs(end - start); BufRd.ar(1, bufNum, // Buffer 0
LinLin.ar(
LFSaw.ar(rate/duration, 1), -1, 1, start, end)*srate
)*EnvGen.kr(Env.linen(0.01, 0.98, 0.01), timeScale: duration, gate: Impulse.kr(1/duration));
}.play )


b = Buffer.read(s,  "/Users/EmanTnuocca/Desktop/∞/g_smpl/kickky.wav");

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


(
// something to record
SynthDef("bubbles", {
    var f, zout;
    f = LFSaw.kr(99.4, 0, 24, LFSaw.kr([8,7.23], 0, 3, 80)).midicps; // glissando function
    zout = CombN.ar(SinOsc.ar(f, 0, 0.04), 0.2, 0.2, 4); // echoing sine wave
    Out.ar(0, zout);
}).send(s);

// this will record to the disk
SynthDef("help-Diskout", {arg bufnum;
    DiskOut.ar(bufnum, In.ar(0,2));
}).send(s);

// this will play it back
SynthDef("help-Diskin-2chan", { arg bufnum = 0;
    Out.ar(0, DiskIn.ar(2, bufnum));
}).send(s);
)

(

// start something to record
x = Synth.new("bubbles");

// allocate a disk i/o buffer
b= Buffer.alloc(s, 65536, 2);

// create an output file for this buffer, leave it open
b.write("~/diskouttest.aiff".standardizePath, "aiff", "int16", 0, 0, true);
// create the diskout node; making sure it comes after the source
d = Synth.tail(nil, "help-Diskout", ["bufnum", b]);
)
(
// stop recording
d.free;
// stop the bubbles
x.free;
// close the buffer and the soundfile
b.close;
// free the buffer
b.free;
)

// play it back
(
x = Synth.basicNew("help-Diskin-2chan");
m = { arg buf; x.addToHeadMsg(nil, [\bufnum,buf])};

b = Buffer.cueSoundFile(s,"~/diskouttest.aiff".standardizePath, 0, 2, completionMessage: m);
)
x.free; b.close; b.free; // cleanup

(
w = Window.new("I catch keystrokes");
w.view.keyDownAction = { arg view, char, modifiers, unicode, keycode;

	if(a==1,{a=a+1; "complete true".postln;"Channel 1, recording.".speak;
},{"complete false".postln;a=1})

};
w.front;
)
	a=1;
"Channel 1, recording.".speak;

(
w = Window.new("I catch keystrokes");
w.view.keyDownAction = { arg view, char, modifiers, unicode, keycode;  [char, keycode, unicode, modifiers].postln; };
w.front;
)

1%2;



(// DPG UNIVERSA,L
SynthDef("help-AudioIn",{ arg out=0;
	Out.ar(out,
		AudioIn.ar([0,1])
	)
}).play;
)//notes: may add delay or stuff like that


///////////////
///////////////

(
{ Mix.ar(
	Array.fill(10, // number of oscillators
		{arg c;
			Pan2.ar(SinOsc.ar( // be sure the add is greater than the mul
				LFSaw.ar((c*0.2 + 1)/3, mul: 80, add: 400)
			), LFNoise0.kr(1)) // pan speed

	} )
	)*0.1
}.play
)


/////////////////////
/////////////////////

( // <- double click the parenthesis
{

	Mix.ar(
		Array.fill(5, // not too many values, could crash
			{Pan2.ar(
				SinOsc.ar(SinOsc.ar(1/10, rrand(0, 6.0), 200, 500)),
				1.0.rand)} )
	)*0.02
}.play
)

/////////////////////
/////////////////////

(
// Double click the parenthesis above to quickly select
// the entire patch
// Or use com-shift-b
{
	var out, delay;
	out = SinOsc.ar( //Sine wave osc
		abs( //This protects against negative values
			LFNoise1.kr(
				0.5, //frequency overall wandering
				600, //range of overall wandering
				LFSaw.kr(
					1.5, //speed of the individual sweeps
					mul: 50, //depth of sweep
					add: 500 //range of sweep
				)
			)
		),
		0,
		0.1 //volume, stay below 0.2
	); //delay
	delay = CombN.ar(out,
		3.0, //max delay
		[1.35, 0.7], //actual delay, stay below max delay
		6 //delay decay
	);
	Pan2.ar(out, 0) + delay }.play
)




/////////////////////////////////////////////////////////////////////////////////////////////
( {
	var harmonics = 63, fund = 40, speeds;
	speeds = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11]/10;
	Mix.fill(harmonics,
		{ arg count; Pan2.ar(
			FSinOsc.ar(
				fund * (count + 1),
				mul: max(0, FSinOsc.kr(speeds.wrapAt(count)))),
			1.0.rand2)
		}
	) / (2*harmonics)
}.play; )



//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////




(
{var freq, ratio;
freq = LFNoise0.kr(4, 20, 60).round(1).midicps; ratio = 2/1;
PMOsc.ar(
freq, //carrier
freq*ratio, //modulator
		MouseY.kr(0.1, 10), //index
		Mul: [0.4, 0.4]
)}.play )

(//fmmmmmmmmmmmm
{var freq, ratio, env, rate = 5, trig;
trig = Impulse.kr(10);
freq = TRand.kr([60, 60], [60, 60], trig).midicps; ratio = 2;
env = EnvGen.kr(Env.perc(0, 1/rate), gate: trig); PMOsc.ar(
freq, freq*ratio, 4 + env*4, mul: env
)}.play )



/////////////////////////////////////

(
//run this first
SynthDef("Flash",
{
arg fund = 400, decay = 4, filter = 1; var out, harm;
out = Mix.ar( Array.fill(7,
   {
       arg counter;
var partial;
partial = counter + 1; SinOsc.ar(fund*partial) *
EnvGen.kr(Env.linen(0, 0, decay + 2), levelScale: 1/(partial*filter)
) * max(0, LFNoise1.kr(rrand(5.0, 12.0)))
})
)*0.3; //overall volume
out = Pan2.ar(out, Rand(-1.0, 1.0)); DetectSilence.ar(out, doneAction:2); Out.ar(0, out)
}
).play(s);
)
(
//then this
r = Task({
var freqFunc, pitch = 440, nextEvent;
freqFunc = {arg previousPitch;
var nextPitch, nextInterval;
nextInterval = [3/2, 2/3, 4/3, 3/4, 5/4, 4/5, 6/5, 5/6].choose; nextPitch = (previousPitch*nextInterval).wrap(100, 1000); nextPitch.round(0.01).post; " != ".post; nextPitch.cpsmidi.round(1).midicps.round(0.01).postln; nextPitch
};
{
nextEvent = [0.5, 0.25, 5, 4, 1].choose; pitch = freqFunc.value(pitch); Synth("Flash",
[\fund, pitch, \decay, nextEvent, \filter, rrand(1.0, 4.0)]); //Choose a wait time before next event
nextEvent.wait;
}.loop;
}).play
)


////////////////////////////////////////////////////////////


(
SynthDef("Tumbling", {arg freq = 50;
	var signal, partials; signal = 0;
	partials = 8; partials.do({arg harm; harm = harm + 1; signal = signal +
		FSinOsc.ar(freq * [harm, harm*3/2],
			mul: max(0, LFNoise1.kr(Rand([6.0, 6.0], 6.0), mul: 1/(harm + 1) * 0.6) ))
	});
	signal = signal*EnvGen.kr(Env.perc(0.2,20.0), doneAction: 2); Out.ar(0, signal*0.8)
	}
).send(s)
)
(
//run a task to play the synth
r = Task({
{Synth("Tumbling", [\freq, rrand(70, 70)]); //Choose a wait time before next event
		rrand(1.2, 2.0).wait;
}.loop;
}).play )



//////////////////////////////////////////////////////////////

(
{
var signal, env1; env1 = Env.perc(
0.001, //attack of envelope
2.0 //decay of envelope
	);
signal = Blip.ar( //Audio Ugen
			Latch.kr( //Freq control Ugen
LFSaw.kr( 6.18, 0,//Freq of input wave
3, 500), //Mul. and Add for input wave
Impulse.kr(10)), //Sample trigger rate
		LFNoise1.kr(0.3, 13, 14), //Number of harmonics in Blip
		mul: 0.3 //Volume of Blip
		);
signal = Pan2.ar(
signal, //input for the pan
LFNoise1.kr(1) //Pan position.
	);
//reverb
4.do({ signal = AllpassN.ar(signal, 0.05, [0.05.rand, 0.05.rand], 4,
mul: 0.3, add: signal) }); signal*EnvGen.kr(env1) //return the variable signal
}.play(s) )

///////////////////////////////////////////////////////////////////


(
{
	var out, env;
	env = Env.linen([0.0001, 1.0].choose, 2.0.rand, [0.0001, 1.0].choose); out = Pulse.ar(LFNoise1.kr([0.1, 0.12], 20, 60),
		SinOsc.kr( 0.2, mul: 0.05, add: 0.051),0.5);
	4.do({out = AllpassN.ar(out, 0.05, [0.05.rand, 0.05.rand], 4, mul: 0.4, add: out)});
	out*EnvGen.kr(env) }.play(s)
)


///////////////////////////////////////////////////////////////////////////////////////////
(
{
var out, mulControl, env, effectEnv; // effectEnv = Env.perc(0.001, 3);
env = Env.linen(0.01.rand, 0.3.rand, rrand(0.1, 3.0)); mulControl = LFNoise1.kr([0.2, 0.5], 300, 600);
out = SinOsc.ar(
SinOsc.ar( //control Osc
LFNoise1.kr(0.4, 120, 130), //freq of control
mul: mulControl, //amp of contrul
add: mulControl + LFNoise1.kr(0.1, 500, 600)), //add of control
mul: 0.3 //amp of audio SinOsc
	);
out*EnvGen.kr(env, doneAction:2); }.play
)


///////////////////////////////////////////////////////////////////////////////////////////

(
{ PMOsc.ar(
LFNoise1.kr(
MouseX.kr([1, 1], 12), mul: MouseY.kr(10, 1000), add: 1000),
LFNoise0.kr(
MouseX.kr([1, 1], 12), mul: MouseY.kr(30, 1000), add: 1000),
MouseY.kr(0.1, 5.0),
   mul: 0.3)
}.play
)



///////////////////////////////////////////////////////////////////////////////////////////

(
{
var harmonics = 63, fund = 30, dividor = /* 3200 ile 0/3200 arasi bir deger*/  1/3200;
Mix.fill(harmonics, {arg count;
Pan2.ar(
SinOsc.ar(fund * (count+1),
mul: max(0, FSinOsc.ar(count/dividor))
), 1.0.rand2
) }
)*1/harmonics}.play
)

//////////////////////////

(
// harmonic swimming
play({
var fundamental, partials, out, offset;
fundamental = 50; // fundamental frequency
partials = 20; // number of partials per channel
out = 0.0; // start of oscil daisy chain
offset = Line.kr(0, -0.02, 60); // causes sound to separate and fade
	partials.do({ arg i;
out = FSinOsc.ar(
fundamental * (i+1), // freq of partial
0,
max(0, // clip negative amplitudes to zero
LFNoise1.kr(
6 + [4.0.rand2, 4.0.rand2], // amplitude rate
					0.02, // amplitude scale
offset // amplitude offset
)
		),
out )
});
out })
)


Peak.ar(SinOsc.ar(0.1),0.3);

s.plotTree;


(
SynthDef(\env_help, { |out, gate = 1, amp = 0.1, release = 0.1|
    var env = Env.adsr(0.02, release, amp);
    var gen = EnvGen.kr(env, InRange.ar(SinOsc.ar(0.1),0.9);
, doneAction: 2);
    Out.ar(out, PinkNoise.ar(1 ! 2) * gen);
	I
}).add
);
if
a = Synth(\env_help);
b = Synth(\env_help, [\release, 2]);
a.set(\gate, 0); // alternatively, you can write a.release;
b.set(\gate, 0);


//THIS AREA IS FOR STUDY HOW TO'SSSSSS
//THIS AREA IS FOR STUDY HOW TO'SSSSSS
//THIS AREA IS FOR STUDY HOW TO'SSSSSS

play{Limiter.ar(GVerb.ar(sin(Ringz.ar(Impulse.ar(2**LFNoise0.ar(1!2).range(1,4).round),[40,200,234,889],0.7).sum*2),5,2,0.7))}

play{Limiter.ar(GVerb.ar(sin(Ringz.ar(Impulse.ar(2**LFNoise0.ar(1!3).range(1,5).round/2),[40,200,234,889,1320,150],0.7).sum),5,2,0.7)/2)}



//Some people have asked me to explain my sctweet "basso gettato" published in the web-album "SC140" by The Wire by an initiative of Dan Stowell. (http://supercollider.github.io/community/sc140.html)

//Here is my attempt to explain the code:

//original sctweet
play{x=165;b=SinOsc;p=Trig.ar(Saw.ar(x),1);y=b.ar(p*x);z=b.ar(p);(GVerb.ar(GrainIn.ar(2,y,y/2,z,p*z,-1),9))/9}//basso gettato #SuperCollider


//p
//creates a "nice series" of numbers above 0 and below 1 with the duration of 1 second
{Saw.ar(165)}.plot(0.1) //simple sawtooth wave
{Trig.ar(Saw.ar(165),1).poll}.play //get values just after the "above 0" jump
{Trig.ar(Saw.ar(165),1)}.plot(30) //wait 30 seconds, go get a cofee, and come back to see the skyscraper profile of the "nice numbers" generated

//z
//is a variable LFO as it is a SinOsc with frequency argument equal to the current "nice number" generated by p
{SinOsc.ar((Trig.ar(Saw.ar(165),1)).poll)}.play

//y
//is a faster version of z, as the sinusoids have the frequency values generated by the multiplication of p "nice values" and 165
{SinOsc.ar((Trig.ar(Saw.ar(165),1)*165).poll)}.play

//grainin
// creates grains of z at y rate, duration is y/2 and pan of each grain is given by p*z
// althought z itself is not in the audible range, the rate makes the little pulses audible either as a slow rhythm (when y is very low) or as a low note (when y is near 165)
// trigger argument:
GrainIn.ar(2,y,y/2,z,p*z,-1)

//GVerb: well... everything is cooler with GVerb!
{Saw.ar(0.1)}.plot(1)

//A final note: 165 works well because it does not fit to the samplerate / block size values. For example, try to use the value (44100/64) – or any simple ratio of it – instead and you will have something a bit more monotonous


//END OF HOW TO'SSSSSSS
//END OF HOW TO'SSSSSSS
//END OF HOW TO'SSSSSSS


// START OF nick collins patch.scd
// START OF nick collins patch.scd
// START OF nick collins patch.scd

(
p = Prout({
         var z,a,b,c, discriminant;

         loop({

                 z=Complex(rrand(0.1,1.0)*([1,-1].choose),rrand(0.1,1.0)*([1,-1].choose));


         [rrand(5,15),rrand(10,50),exprand(1,50).round(1.0).asInteger].wchoose([0.8,0.1,0.1]).do({

                 //z goes to w where z^2+zw+w^2=3, know z, solve quadratic
                 a=1; b=z; c=z*z-3;

                 discriminant= b*b - 4*c;

                 //used as temp variable, complex root taking lowest angle
                 a = Polar(discriminant.magnitude.sqrt,(discriminant.theta)/2);

                 //two roots, + or - here, choose + arbitrarily
                 z = 0.5*(z.neg + (a.asComplex));

                 if(z.magnitude<10,{
                 [(z.real.abs*2).asInteger,0.25*((z.imag.abs).min(1.0))].yield;
                 });

                 });
         });
});

b = Pbind(\instrument, \synth2, \scale,
[0,2,3,5,7,9,11,13,14,16,17,19,20,23,24], \dur,0.125,[\degree, \amp], p);

Ptpar([ 0.0, Pbindf(b, \octave, 4,\stretch, 3.0), 4.0, b, 8.0, Pbindf(b,
\octave, 3,\stretch, 5.0), 12.0, Pbindf(b, \octave, 5,\stretch,
7.0)]).play(TempoClock(1));
)

(
SynthDef(\synth2,{
arg freq,mod=0.5,amp=0.1;
var sound1;

sound1=Pulse.ar(freq,0.5-(0.1*amp),amp)*Line.kr(1,0,ExpRand(0.25,1.5),doneAction:2);
Out.ar(0,Pan2.ar(LPF.ar(sound1,Rand(100,500)+(5800*amp))))
}).store;
)

// END OF nick collins patch.scd
// END OF nick collins patch.scd
// END OF nick collins patch.scd


// START OF tball stuff.scd
// START OF tball stuff.scd
// START OF tball stuff.scd

//tball stuff
// parameter1 is good for values between 1 to 40
// parameter2 is just basically startposition seconds in sample,
// envRel is release time in seconds,
// It is also possible to get low pitched or highpitched sounds by changing baseFreq between 0.1 to 5
(
SynthDef(\tballsynth, { arg out = 0, amp = 1, buf = b, rate = 1, gate = 1, parameter1 = 2, parameter2 = 9,envRel = 3, baseFreq = 1;
	var env = EnvGen.ar(Env.perc(0.001, envRel, 1, -8), gate, doneAction:2);
	var trigger = TBall.ar(1, g:parameter1, damp:0 , friction:0.001);
	var cal = Decay2.ar(trigger, 0, Timer.ar(trigger), Rand(0.9,10), baseFreq);
	var player = PlayBuf.ar(1, buf, cal, trigger, startPos: (44100 * parameter2))!2;
	player = player * env;
	Out.ar(out, player);

}).play;
)

b = Buffer.read(s,"/Users/EmanTnuocca/Documents/SC CODES/weekly diary/untitled folder/div1.wav" ); // remember to free the buffer later."/Users/EmanTnuocca/Documents/SC CODES/weekly diary/untitled folder/div1.wav"

// END OF tball stuff.scd
// END OF tball stuff.scd
// END OF tball stuff.scd


	SynthDef(\bd, {
		arg bufnum, rate = 1, attack = 0.01, release = 0.6, amp = 1; //Settings for chainging the buffer and the envelope
		var env, sig;
		env = EnvGen.ar(Env.perc(attack, release), doneAction: 2);
		sig = PlayBuf.ar(1, bufnum, rate) * env;
		sig = (sig * amp).tanh;
		Out.ar(0, sig);
	}).add;



                                //Synth Pink Noise
	SynthDef (\noisythingy,{
		arg gate = 1, attack = 0.01, release = 0.3; //Settings for chainging the buffer and the envelope
		var env, sig;
		env = EnvGen.ar(Env.asr(attack, 1, release), gate, doneAction: 2);
		sig = PinkNoise.ar(0.25) * env;
		Out.ar(0, sig)

	}).add;


SynthDef(\IVANKICK, { arg out = 0, amp = 1, spread = 1, pan = 0,
	rate = 1, ratectl = 1,
	startPos = 0,
	atk = 0, decay = 0, suslevel = 1, releasetime = 0,
	loop = 0,
	gate = 1,
	t_trig = 1,
	buf;
	var ampenv = EnvGen.ar(Env.adsr(atk, decay, suslevel, releasetime), gate, doneAction: 2);
	var player = PlayBuf.ar(1, buf, rate * ratectl, t_trig, startPos * BufFrames.kr(buf), loop);

	Out.ar(out, Splay.ar(player * ampenv * amp, spread, center: pan));

	}).add;


SynthDef(\distortion, { arg out = 0, gain = 41.97, envtime = 4, mix = 1, outputlevel = 1, shaperbuf;
	var input = In.ar(out, 2) * gain;
	ReplaceOut.ar(out,  XFade2.ar(input, Shaper.ar(shaperbuf, input), mix.linlin(0,1.0,-1,1.0)));

	}).add;



SynthDef(\route, { arg out = 0, in = 16, vol = 1;
	Out.ar(out, vol * In.ar(in, 2))
	}).store;
//////////////////////////////////////////////////////

{
	var	sig, sig1, sig2, lpf, popHz, lagtime, noise, popHzMul,
		pan1, pan2, panmod1, panmod2;
	popHzMul = Decay.kr(Dust.kr(0.15), 3, 10, 0.8);
	popHz = 	LFNoise1.kr(20).exprange(0.1,10) * popHzMul;
	sig = Dust2.ar(popHz);
	lpf = LFNoise1.kr(10).exprange(1000,20000);
	lagtime = LFNoise1.kr(20).range(0.008,0.0001);
	sig = LPF.ar(sig, lpf);
	sig = Lag.ar(sig, lagtime);
	sig = sig + FreeVerb.ar(sig, 0.8, 1, mul:0.11);
	panmod1 = LFNoise1.kr(5).range(0.2,0.7);
	panmod2 = LFNoise1.kr(5).range(0.2,0.7);
	pan1 = SinOsc.kr(panmod1).range(-0.2,0.2);
	pan2 = SinOsc.kr(panmod2).range(-0.2,0.2);
	sig1 = Pan2.ar(sig, pan1, 0.5);
	sig2 = Pan2.ar(sig, pan2, 0.5);
	sig = sig1 + sig2;
	sig = sig + BPF.ar(BrownNoise.ar([0.0025,0.0025]), 7200, 0.4);
	sig = sig + HPF.ar(Crackle.ar([1.999,1.999], 0.0025),2000);
	Out.ar(0, sig*6);
}.play

////////////////////////////////////////////////////

//START OF THE piececece.scd
//START OF THE piececece.scd
//START OF THE piececece.scd

(
s = Server.local.waitForBoot({
	~bus = Bus.audio(s,2);
	SynthDef(\reverb_ef, {
		arg		amp=1, lPos=0, mix=0.085, revTime=1.8, preDel=0.1, in, out;
		var		sig, verbSig, totalSig, outSig;

		//no wacky values please
		mix = mix.clip(0,1);

		sig = In.ar(in, 2);

		//pre-delay
		verbSig = DelayN.ar(sig, preDel, preDel);

		totalSig = 0;
		12.do{
			verbSig = AllpassN.ar(verbSig, 0.06, {Rand(0.001,0.06)}!2, revTime);
			verbSig = LPF.ar(verbSig, 4500);
			totalSig = totalSig + verbSig;
		};

		//dry/wet mix
		totalSig = XFade2.ar(sig, totalSig, mix.linlin(0,1,-1,1));

		outSig = totalSig * amp;
		Out.ar(out, outSig);
	}).add;

	SynthDef(\filtSaw, {
		arg		freq=440, detune=3.0, atk=6, sus=4, rel=6, curve1=1, curve2=(-1),
				minCf=30, maxCf=6000, minRq=0.005, maxRq=0.04,
				minBpfHz=0.02, maxBpfHz=0.25,
				lowShelf=220, rs=0.85, db=6,
				gate=1, amp=1, spread=1.0, out=0;
		var sig, env;
		env = EnvGen.kr(Env([0,1,1,0],[atk,sus,rel],[curve1,0,curve2]), gate, levelScale:amp, doneAction:2);
		sig = Saw.ar(
			freq +
			LFNoise1.kr({LFNoise1.kr(0.5).range(0.15,0.4)}!8).range(detune.neg,detune));
		sig = BPF.ar(
			sig,
			LFNoise1.kr({LFNoise1.kr(0.13).exprange(minBpfHz,maxBpfHz)}!8).exprange(minCf, maxCf),
			LFNoise1.kr({LFNoise1.kr(0.08).exprange(0.08,0.35)}!8).range(minRq, maxRq)
		);
		sig = BLowShelf.ar(sig, lowShelf, rs, db);
		sig = SplayAz.ar(4, sig, spread);
		sig = sig * env * 2;
		Out.ar(out, sig);
	}).add;

	~cluster = {
		var trnsp, bund;
		bund = s.makeBundle(false, {});
		trnsp = rrand(-7,7);
		Array.fill(exprand(4,14).round.postln, {[1,2,3,4,6,8,12,16].wchoose([7,6,5,4,3,3,1].normalizeSum)}).do{
			|i|
			var cfLo;
			cfLo = (([23,35,47,50,52,59,61,63,64,76,78].choose) + trnsp).midicps * ((1..8).choose);

				bund = s.makeBundle(false, {
					Synth(
						\filtSaw,
						[
							\freq, i,
							\detune, 0,
							\minBpfHz, 0.01,
							\maxBpfHz,i.expexp(1.0,16.0,0.1,16.0),
							\minRq, 0.003,
							\maxRq, exprand(0.008,0.08),
							\minCf, cfLo,
							\maxCf, cfLo * [1,1.1,1.5].wchoose([0.87,0.1,0.03]),
							\amp, exprand(0.15,0.25),
							\atk, exprand(0.7,8),
							\rel, 5,
							\sus, rrand(6,10.0),
							\spread, exprand(1.5,8.0),
							\out, ~bus,
						],
					)
				},
				bund
			)
		};

		//schedule on an integer time value
		SystemClock.schedAbs(
			(thisThread.seconds+1.0).round(1.0),
			{
				bund = s.makeBundle(nil, {}, bund);
				nil;
			}
		);
	};
});
)

//start clusters
(
t = Task {
	//instantiate reverb synth
	Synth(\reverb_ef, [\in, ~bus, \out, 0]);

	{
		~cluster.value;
		rrand(5.5,12.0).wait;
	}.loop;
}.start;
)

//stop clusters
t.stop;

//END OF THE piececece.scd
//END OF THE piececece.scd
//END OF THE piececece.scd


//START OF THE piececece.scd
//START OF THE piececece.scd
//START OF THE piececece.scd
//ALTTA GELEN ESER, MULTIVOICE DENEME ALANI, RANDOMNESS VE FUNCTION
(
var
var0=63,var1=63,var2=63,var3  =63,var4 =63, var5=63, var6  =63,
var7=63,var8=63,var9=63,var10=63,var11=63,var12=63,var13=63,abc1 = 63,
abc = Bus.audio(s,1),
index1,index2;
SynthDef(\Lumbricost, {arg attTim= 1,relTim=2.5,amp = 1 ,scale= 6, offset = 40,synch = 10, timescale = 10, widthmod = 0.4, width = 0.2, totVol, abc = 0;
	var generation =
	Pulse.ar(SinOsc.kr(5/synch, mul: scale, add: Rand(offset - abc,offset + abc)),EnvGen.kr(Env.perc(0.01, relTim), Impulse.ar(30/synch),widthmod,width,timescale), mul: 0.1) +
	Pulse.ar(SinOsc.kr(7/synch, mul: scale, add: Rand(offset - abc,offset + abc)),EnvGen.kr(Env.perc(0.01, relTim), Impulse.ar(7/synch),widthmod,width,timescale), mul: 0.1) +
	Pulse.ar(SinOsc.kr(9/synch, mul: scale, add: Rand(offset - abc,offset + abc)),EnvGen.kr(Env.perc(0.01, relTim), Impulse.ar(2/synch),widthmod,width,timescale), mul: 0.1) +
	Pulse.ar(SinOsc.kr(10/synch, mul: scale, add: Rand(offset - abc,offset + abc)),EnvGen.kr(Env.perc(0.01, relTim), Impulse.ar(5/synch),widthmod,width,timescale), mul: 0.1) +
	Pulse.ar(SinOsc.kr(3/synch, mul: scale, add: Rand(offset - abc,offset + abc)),EnvGen.kr(Env.perc(0.01, relTim), Impulse.ar(9/synch),widthmod,width,timescale), mul: 0.1) +
	Pulse.ar(SinOsc.kr(2/synch, mul: scale, add: Rand(offset - abc,offset + abc)),EnvGen.kr(Env.perc(0.01, relTim), Impulse.ar(40/synch),widthmod,width,timescale), mul: 0.1);
	var env = generation * Env.perc(attackTime:attTim,releaseTime: relTim).ar(2);
	var env1 = LeakDC.ar(env);
	var out =  env1* ((totVol + amp -15).dbamp);
	out = BPF.ar(out, Rand(MouseX.kr(100, 20000, 1)-100,MouseX.kr(100, 20000, 1)+100), MouseY.kr(0.01, 1, 1));
	Out.ar([0,1],out);
	Out.ar(abc, out);
}).add;
MIDIdef.noteOn(\LumbricostController, {arg vel, note;
	r = Routine({

		var8.do({
			Synth(\Lumbricost,[\offset, note.midicps, \amp, vel.linlin(0,127,-12,12), \gate, 1,
				\scale,   var0.linexp(0,127,0.005,500),
				\synch,  var1.linexp(0,127,0.001,1000),
				\timescale,   var2.linexp(0,127,0.001,10),
				\widthmod,   var3.linlin(0,127,0,1),
				\width,  var4.linexp(0,127,0.01,1),
				\relTim,    var5.linexp(0,127,0.01,2.5),
				//
				\attTim,  var6.linexp(0,127,0.001,1),
				\abc, var9.midicps,
				\abc1, var10.midicps,
				\totVol, var7.linlin(0,127,-24,24);]);
		})
	});
	r.reset.play;
	~test_Lumbricost = 1;
},srcID:~midiInINST6,chan: 6).permanent_(true);
MIDIdef.cc(\LumbricostCC, {arg ...args;
	index1 = args[1];
	index2 = args[0];
	x = case
	{ index1 == 0 }    { var0=index2;}
	{ index1 == 1 }    { var1=index2;}
	{ index1 == 2 }    { var2=index2;}
	{ index1 == 3 }    { var3=index2;}
	{ index1 == 4 }    { var4=index2;}
	{ index1 == 5 }    { var5=index2;}
	{ index1 == 6 }    { var6=index2;}
	{ index1 == 7 }    { var7=index2;}
	{ index1 == 8 }    { var8=index2;}
	{ index1 == 9 }    { var9=index2;}
	{ index1 == 10}   { var10=index2;}
	{ index1 == 11}   { var11=index2;}
	{ index1 == 12}   { var12=index2;};
},(0..10),srcID:~midiInINST6,chan:6).permanent_(true);
SynthDef(\LumbricostDiskout, {arg bufnum;
	DiskOut.ar(bufnum, In.ar(abc,1));
}).add;
)


(
// DEFINE A SYNTHDEF
SynthDef("fm2", {
    arg bus = 0, freq = 440, carPartial = 1, modPartial = 1, index = 3, mul = 0.2, ts = 1;

    // index values usually are between 0 and 24
    // carPartial :: modPartial => car/mod ratio

    var mod;
    var car;

    mod = SinOsc.ar(
        freq * modPartial,
        0,
        freq * index * LFNoise1.kr(5.reciprocal).abs
    );

    car = SinOsc.ar(
        (freq * carPartial) + mod,
        0,
        mul
    );

    Out.ar(
        bus,
        car * EnvGen.kr(Env.sine(1), doneAction: 2, timeScale: ts)
    )
}).add;
)

(
// DEFINE A ROUTINE
r = Routine({

    12.do({
        Synth(
            "fm2",
            [
                \bus, 2.rand, \freq, 400.0.rrand(1200),
                \carPartial, 0.5.rrand(2), \ts, 0.5.rrand(11)
            ]
        );
        s.queryAllNodes;
        "".postln.postln.postln.postln.postln;
    })
});
)

// PLAY THE ROUTINE
r.reset.play;
//////////////////////////////////////////////
(
// DEFINE A SYNTHDEF
SynthDef("echoplex", {
    ReplaceOut.ar(
        0,
        CombN.ar(
            In.ar(0, 1),
            0.35,
            [Rand(0.05, 0.3), Rand(0.05, 0.3)],
            // generate random values every time a synth is created
            7,
            0.5
        )
    )
}).add;

// DEFINE GROUPS TO CONTROL ORDER-OF-EXECUTION
// attach a ~source group to the head of the rootnode and
// an ~effects group to the tail of the rootenode
~source = Group.head(s);
~effect = Group.tail(s);

// DEFINE A ROUTINE
r = Routine({

    // loop is the same as inf.do, eg, create an infinite loop that runs forever
    loop({
        Synth.head(    // attach the synth to the head of the ~source group
            ~source,
            "fm2",
            [
                \outbus, 0, \freq, 400.0.rrand(1200), \modPartial, 0.3.rrand(2.0),
                \carPartial, 0.5.rrand(11), \ts, 0.1.rrand(0.2)]
        );
        s.queryAllNodes;
        2.wait;
    })
});

// TURN ON EFFECTS
Synth.head(~effect, "echoplex");
Synth.tail(~effect, "echoplex");
)
// PLAY THE ROUTINE
r.reset.play;

//END OF THE piececece.scd
//END OF THE piececece.scd
//END OF THE piececece.scd


//START OF THE MIDIsmpte.scd
//START OF THE MIDIsmpte.scd
//START OF THE MIDIsmpte.scd

MIDIIn.connect;    // init for one port midi interface
// register functions:

(~smpte = { arg src, chan, val;  a.set(\gate, 1000.rand);
//	[chan,val].postln;
};//[ 8, nil ] genel, ++[ 10, nil ]<-start /\ end->[ 12, nil ]
//~smpte = { arg src, chan, val;        [chan,val].postln; };
)
MIDIIn.addFuncTo(\sysrt, ~sysrt);
MIDIIn.addFuncTo(\smpte, ~smpte);

(
SynthDef("moto-rev", { arg ffreq=100;
    var x;
    x = RLPF.ar(LFPulse.ar(SinOsc.kr(0.2, 0, 10, 21), [0,0.1], 0.1),
        ffreq, 0.1)
        .clip2(0.4);
    Out.ar(0, x);
}).add;
)

b = Bus.control(s);

x = Synth("moto-rev");

// map the synth's first input (ffreq) to read
// from the bus' output index
a.map(gate, b);


MIDIIn.connect;
//set the action:
(
~noteOn = {arg src, chan, num, vel;
    b.value = num.midicps.postln;
};


(
SynthDef(\SMPTEdo, { arg out = 0, starter = 0, gate = 0;
	var formant,abc, testcase;
	//Poll.ar(Impulse.ar(10), Timer.ar(T2A.ar(InTrig.kr(gate),0.1)), \test);
	//Poll.kr(Impulse.kr(10), Timer.kr(Changed.kr(TRand.kr(0,127,gate),0.1)), \test);
	Poll.ar(Impulse.ar(10), Timer.ar(Changed.ar(K2A.ar(gate),0.1)), \test);
	//testcase = (16 * (1 /  Timer.kr(TRand.kr(0,127,gate)))).poll;
}).add;
)
(
MIDIdef.sysrt (\deneme, {arg src, chan, val;
	a.set(\gate, 1000.rand);
},srcID: ~midiInINST1).add;
)


(~sysrt = { arg src, chan, val; // a.set(\gate, 1000.rand);
	[chan,val].postln;
};//[ 8, nil ] genel, ++[ 10, nil ]<-start /\ end->[ 12, nil ]
//~smpte = { arg src, chan, val;        [chan,val].postln; };
)
(
{ var trig;
	trig = Impulse.kr(MouseX.kr(0.5, 20, 1));
	Timer.kr(trig).plot
}.play;
)

{ Poll.kr(Impulse.kr(100), Timer.kr(Impulse.kr(MouseX.kr(0.5, 20, 1))), \test) }.play(s);


a = Synth(\SMPTEdo, [gate: 1]);
a.set(\gate, 1000.rand);
a.set(\gate, 0);
Synth(\SMPTEdo, [gate: 0]);

~diken = 0.3;
~sysrt = { arg src, chan, val;  a.set(\gate, 1000.rand);/*[chan,val].postln;*/};

//END OF THE MIDIsmpte.scd
//END OF THE MIDIsmpte.scd
//END OF THE MIDIsmpte.scd

//START OF !LNX_StudSynthdefs
//START OF !LNX_StudSynthdefs
//START OF !LNX_StudSynthdefs

// A Piano (VST by Paul Kellett, SC port Dan Stowell)

SynthDef("Piano", {|out, amp, velocity, freq, midi, pan, gate=1, sendOut, sendAmp, poll,
				transpose, decay, release,hard, velHard,velCurve, velMin, velMax, stereo,
				lfoFreq, lfoAmp, lfoPhase |
	var signal;
	velocity = velocity.linlin(0,1,velMin,velMax) *127;
	signal = MdaPiano.ar((midi+transpose).midicps, gate, velocity, decay, release, hard,
						velHard, velcurve:velCurve, stereo:stereo, sustain:0);
	DetectSilence.ar(signal, 0.01, doneAction:2);

	signal = signal * SinOsc.ar(lfoFreq,(lfoPhase/2+0.5)* pi,lfoAmp*0.5,1-(lfoAmp*0.5));
	signal = signal * EnvGen.ar(Env.new([1,1,0],[decay,release*4],[-4,-4],1), gate, 1, 0, 1, 2);

	amp = amp * 0.66 * (2 - (velCurve**1.25));
	LNX_Out(signal, out, amp, pan, sendOut, sendAmp);

}, metadata: ( specs: ( filtFreq: \freq, q: \unipolar, transpose:\transpose,
						decay:[0,2], release:[0.1,2], hard:[-2,2], velHard:[0,2],
						lfoFreq:\lowFreq, velMax:[0,1,\lin,0,1]
)))



// Filter Rain by LNX (The Hasher syncs random values for the filter, to tempo clock)

SynthDef("FilterRain", {|out, amp, vel, freq, midi, pan, gate=1, filtFreq=1800, q=0.5, dur=1, clock, speed=1, frange, bpm, sendOut, sendAmp|

	var signal, filtF;

	filtF  = Hasher.ar((clock/speed).floor).linlin(0,1,1,1+frange);
	signal = Saw.ar([1,0]+bpm/60*4, 0.05);
	signal = DFM1.ar(signal, filtFreq* filtF * vel, q);
	signal = GVerb.ar(signal,Rand(1,2),filtF/2+1,Rand(0.1,1),Rand(0.1,1),1);
	signal = signal * EnvGen.ar(Env.new([1,0,0], [1,1], [-4,-4], 0), gate, vel, 0, 1, 2);
	signal = HPF.ar(signal,490);

	LNX_Out(signal,out,amp,pan,sendOut,sendAmp, protect:true);

}, metadata: ( specs: ( filtFreq: \freq, q: \unipolar, \speed:[1,16,\linear,1] )))

///////////////////////////////////////////////////////////////

// FM7 ======== by neiL
// controls:
// a1,d1,s1,r1 = attack, decay, sustain & release of envelope 1
// m1  = mod amp of envelope 1
// e12 = envelope used to modulate osc 1 with osc 2
// v1  = volume of osc 1
// p1  = pan of osc 1
// f1  = fixed freq of osc1 as MIDI note, if -- then ratio of MIDI In
// u1  = detune osc1
// t1  = transpose osc1 (only if f1 is not fixed)
// ============

Spec.add(\t4,ControlSpec(-48, 48, step:1, default: 0) ); MVC_NumberFunc.add(\t4, {|n| n.asInt });
Spec.add(\env,ControlSpec(0, 6, step:1, default: 0) ); MVC_NumberFunc.add(\env, {|n| n.asInt });
Spec.add(\mn,ControlSpec(-1, 127, step:1, default:-1));

SynthDef("LNX_Saw1", {|out, amp, vel, freq, midi, pan, gate=1, sendOut, sendAmp,
					bpm, clock, i_clock, poll, dur=1, lfoAmp,lfoFreq,
					a,d,s,r, trans,
					a1,d1,s1,r1, a2,d2,s2,r2, a3,d3,s3,r3,
					a4,d4,s4,r4, a5,d5,s5,r5, a6,d6,s6,r6,
					m1,m2,m3,m4,m5,m6,mod,velMod,
					e11,e12,e13,e14,e15,e16, e21,e22,e23,e24,e25,e26,
					e31,e32,e33,e34,e35,e36, e41,e42,e43,e44,e45,e46,
					e51,e52,e53,e54,e55,e56, e61,e62,e63,e64,e65,e66,
					t1,t2,t3,t4,t5,t6, u1,u2,u3,u4,u5,u6,
					v1,v2,v3,v4,v5,v6, f1,f2,f3,f4,f5,f6,
					p1,p2,p3,p4,p5,p6
					|

	var signal, ctls, mods, chans;

	var m=mod+(vel*velMod**4*10);

	var e1 = EnvGen.kr(Env.adsr(a1,d1*2,s1,r1*4).releaseNode_(2) , gate, 1, 0, dur) * (m1*m);
	var e2 = EnvGen.kr(Env.adsr(a2,d2*2,s2,r2*4).releaseNode_(2) , gate, 1, 0, dur) * (m2*m);
	var e3 = EnvGen.kr(Env.adsr(a3,d3*2,s3,r3*4).releaseNode_(2) , gate, 1, 0, dur) * (m3*m);
	var e4 = EnvGen.kr(Env.adsr(a4,d4*2,s4,r4*4).releaseNode_(2) , gate, 1, 0, dur) * (m4*m);
	var e5 = EnvGen.kr(Env.adsr(a5,d5*2,s5,r5*4).releaseNode_(2) , gate, 1, 0, dur) * (m5*m);
	var e6 = EnvGen.kr(Env.adsr(a6,d6*2,s6,r6*4).releaseNode_(2) , gate, 1, 0, dur) * (m6*m);

	var e = [0,e1,e2,e3,e4,e5,e6]; // 0 is 0 & 1-6 is e1-6

	var ampComp = AmpComp.kr((midi + trans).midicps, 300,0.33);

	//ampComp=1;

	midi = midi + trans + SinOsc.kr(lfoFreq,0,lfoAmp); // + trans & lfo

	ctls = [ // freq,phase,amp
		[(((midi+t1)*(f1<0)) + (f1*(f1>=0)) + u1).midicps, 0, 1], // select fixed or transpose
		[(((midi+t2)*(f2<0)) + (f2*(f2>=0)) + u2).midicps, 0, 1],
		[(((midi+t3)*(f3<0)) + (f3*(f3>=0)) + u3).midicps, 0, 1],
		[(((midi+t4)*(f4<0)) + (f4*(f4>=0)) + u4).midicps, 0, 1],
		[(((midi+t5)*(f5<0)) + (f5*(f5>=0)) + u5).midicps, 0, 1],
		[(((midi+t6)*(f6<0)) + (f6*(f6>=0)) + u6).midicps, 0, 1],
	];

	mods = [ // select with env for each part of the maxtix
		[Select.kr(e11,e), Select.kr(e12,e), Select.kr(e13,e),
		 Select.kr(e14,e), Select.kr(e15,e), Select.kr(e16,e)],
		[Select.kr(e21,e), Select.kr(e22,e), Select.kr(e23,e),
		 Select.kr(e24,e), Select.kr(e25,e), Select.kr(e26,e)],
		[Select.kr(e31,e), Select.kr(e32,e), Select.kr(e33,e),
		 Select.kr(e34,e), Select.kr(e35,e), Select.kr(e36,e)],
		[Select.kr(e41,e), Select.kr(e42,e), Select.kr(e43,e),
		 Select.kr(e44,e), Select.kr(e45,e), Select.kr(e46,e)],
		[Select.kr(e51,e), Select.kr(e52,e), Select.kr(e53,e),
		 Select.kr(e54,e), Select.kr(e55,e), Select.kr(e56,e)],
		[Select.kr(e61,e), Select.kr(e62,e), Select.kr(e63,e),
		 Select.kr(e64,e), Select.kr(e65,e), Select.kr(e66,e)]
	];

	signal = FM7.ar(ctls, mods) * [v1,v2,v3,v4,v5,v6]; // the FM7 ugen

	// pan the oscilators
	signal = Pan2.ar(signal[0], p1) + Pan2.ar(signal[1], p2) + Pan2.ar(signal[2], p3)
	       + Pan2.ar(signal[3], p4) + Pan2.ar(signal[4], p5) + Pan2.ar(signal[5], p6);

	// apply the master envelope
	signal = signal * EnvGen.ar(Env.adsr(a,d*2,s,r*4).releaseNode_(2) , gate,
		vel * ampComp

	, 0, dur, 2);

	// send out
	LNX_Out(signal, out, amp * -10.dbamp, pan, sendOut, sendAmp);

	// signal.poll(poll); // use for debugging

}, metadata: ( specs: (

// all the metadata

filtFreq: \freq, q: \unipolar,

trans:\t4, t1:\t4 , t2:\t4, t3:\t4, t4:\t4, t5:\t4, t6:\t4,

lfoFreq:\lowFreq, lfoAmp:\unipolar, mod:[0,10],

mod:[0,10,4],

e11:\env,e12:\env,e13:\env,e14:\env,e15:\env,e16:\env,
e21:\env,e22:\env,e23:\env,e24:\env,e25:\env,e26:\env,
e31:\env,e32:\env,e33:\env,e34:\env,e35:\env,e36:\env,
e41:\env,e42:\env,e43:\env,e44:\env,e45:\env,e46:\env,
e51:\env,e52:\env,e53:\env,e54:\env,e55:\env,e56:\env,
e61:\env,e62:\env,e63:\env,e64:\env,e65:\env,e66:\env,

u1:\bipolar,u2:\bipolar,u3:\bipolar,u4:\bipolar,u5:\bipolar,u6:\bipolar,

f1:\mn,f2:\mn,f3:\mn,f4:\mn,f5:\mn,f6:\mn,

p1:\pan,p2:\pan,p3:\pan,p4:\pan,p5:\pan,p6:\pan

)))


// A simple SynthDef template

SynthDef("LNX_Saw1", {|out, amp, vel, freq, midi, pan, gate=1, sendOut, sendAmp,
		bpm, clock, i_clock, poll, filtFreq=1800, q=0.5, dur=1, lfoAmp=0.1, lfoFreq=10, attack,
		form1, bw1, pitch1, adj1, amp1,
		form2, bw2, pitch2, adj2, amp2,
		form3, bw3, pitch3, adj3, amp3,
		form4, bw4, pitch4, adj4, amp4|

	var signal;

	var lfo = SinOsc.kr(lfoFreq,0,lfoAmp);

	var midi1 = (midi+pitch1+adj1+lfo).midicps;
	var midi2 = (midi+pitch2+adj2+lfo).midicps;
	var midi3 = (midi+pitch3+adj3+lfo).midicps;
	var midi4 = (midi+pitch4+adj4+lfo).midicps;

	signal = (([
		Formant.ar(midi1, midi1*form1, midi1*bw1, amp1.dbamp),
		Formant.ar(midi2, midi2*form2, midi2*bw2, amp2.dbamp),
		Formant.ar(midi3, midi3*form3, midi3*bw3, amp3.dbamp),
		Formant.ar(midi4, midi4*form4, midi4*bw4, amp4.dbamp)
	]));

	signal = MoogLadder.ar(signal, filtFreq+((midi.midicps) ), q); // change

	signal = signal * EnvGen.ar(Env.new([0,1,1,0], [attack,1,2], [1,1], 1), gate, vel/2, 0, dur, 2);

	LNX_Out(signal, out, amp, pan, sendOut, sendAmp);

	// signal.poll(poll); // use for debugging

}, metadata: ( specs: ( filtFreq: \freq, q: \unipolar,

	form1:[0.1,20,\exp], bw1:[0.1,20,\exp], pitch1:\pitchAdj, adj1:\bipolar, amp1:\db,
	form2:[0.1,20,\exp], bw2:[0.1,20,\exp], pitch2:\pitchAdj, adj2:\bipolar, amp2:\db,
	form3:[0.1,20,\exp], bw3:[0.1,20,\exp], pitch3:\pitchAdj, adj3:\bipolar, amp3:\db,
	form4:[0.1,20,\exp], bw4:[0.1,20,\exp], pitch4:\pitchAdj, adj4:\bipolar, amp4:\db,

 	lfoFreq:\lowFreq, lfoAmp:\unipolar

 )))


// PowerBass by Juan

SynthDef("PowerBass", {|out, amp, vel, detune=0, freq, midi, pan, gate=1, filtFreq=8800, q=0.5, dur=2, bpm, woob_rate=2, megabass=1, distort=0, saturate=2, sendOut, sendAmp|
	var signal, fEnv;
	signal = Gendy1.ar(minfreq:freq-detune, maxfreq:freq+detune);
	signal = signal + SinOsc.ar(freq,0.5pi,megabass);
	signal = MoogLadder.ar(signal, LFCub.kr((bpm/60)*(woob_rate)).range(freq, filtFreq), q);
	signal = Limiter.ar(signal.clip2(1-distort)*(1+(distort*10))*saturate).softclip;
	signal = signal * EnvGen.ar(Env.adsr(0.001, 0.1, 0.5, 0.5), gate, vel, 0, dur, 2);
	LNX_Out(signal,out,amp,pan,sendOut,sendAmp);

}, metadata: ( specs: ( saturate:[1,4], distort:[0, 0.95], megabass:\amp, woob_rate:[0, 12, \lin, 1], detune: [0,20], filtFreq: \freq, q: \unipolar, trans:\pitchAdj, lfoFreq:\lowFreq,
	lfoAmp:\unipolar )))


// A simple SynthDef template

SynthDef("LNX_Saw1", {|out, amp, vel, freq, midi, pan, gate=1, sendOut, sendAmp,
					bpm, clock, i_clock, poll, dur=1, attack, lfoA, lfoF,
					bufL, bufR, bufRate, bufAmp, bufStartFrame, bufStartPos, bufLoop, bufDur,
					ringFreq, ringAmp
					|
	var signal;

	signal = PlayBuf.ar(1,[bufL, bufR], BufRateScale.kr([bufL, bufR]) * (bufRate+

					SinOsc.ar(lfoF,0,lfoA**2,0)
	),
								loop:bufLoop, startPos:bufStartFrame) * bufAmp;

	signal = signal * SinOsc.ar(ringFreq,pi/2,ringAmp/2,1 - (ringAmp/2));

	signal = signal * EnvGen.ar(Env.new([0,1,0], [attack ,2], [-4,-4], 1), gate, vel, 0, dur*bufDur, 2);

	LNX_Out(signal, out, amp, pan, sendOut, sendAmp);

	//sampleL.poll(poll); // use for debugging

}, metadata: ( specs: (lfoF:\lofreq, ringFreq:\lofreq)))

// A simple SynthDef template

SynthDef("LNX_Saw1", {|out, amp, vel, freq, midi, pan, gate=1, sendOut, sendAmp, bpm, clock,
	i_clock, poll, bufL, bufR, bufRate, bufAmp, bufStartFrame, bufStartPos, bufLoop, bufDur,
	q=0.5, dur=1,clip=0.5|

	var signal;

	signal = LorenzL.ar(22050);
	signal = Mix([RLPF.ar(signal, freq*0.33, q), RLPF.ar(signal, freq, q), RLPF.ar(signal, freq+3, q)]);
	signal = signal *0.12* EnvGen.kr(Env.adsr, gate, doneAction: 2).clip(clip.neg,clip)*(1/clip);


	LNX_Out(signal, out, amp, pan, sendOut, sendAmp);

}, metadata: ( specs: (q: [0.001,1,\exp],clip:[0.001,1] )))

//signal.poll(poll); // use for debugging
//PlayBuf.ar(1,[bufL,bufR], BufRateScale.kr([bufL,bufR])*bufRate, 0, bufStartFrame, bufLoop)*bufAmp;
// MembraneCircle

SynthDef("LNX_MembraneC", {|out, amp, vel, freq, midi, pan, gate=1, sendOut, sendAmp, in, inAmp,
					bpm, clock, i_clock, poll, filtFreq=1800, q=0.5, dur=1, tension, loss |
	var signal;
	var excitation = EnvGen.kr(Env.perc, gate, timeScale: 0.1, doneAction: 0)
					* PinkNoise.ar(0.4);
	signal = MembraneCircle.ar(excitation, tension*(freq/60.midicps), loss);

	signal = DFM1.ar(signal, filtFreq * vel, q);
	signal = signal * EnvGen.ar(Env.new([1,1,0], [0,2], [-4,-4], 1), gate, vel*0.5, 0, dur, 2);

	LNX_Out(signal, out, amp*2, pan, sendOut, sendAmp);

	// signal.poll(poll); // use for debugging

}, metadata: ( specs: ( filtFreq: \freq, q: \unipolar, tension:[0.01,0.1], loss:[0.999999,0.999, \exp] )))


// A simple SynthDef template

SynthDef("LNX_Saw1", {|out, amp, vel, freq, midi, pan, gate=1, sendOut, sendAmp,
					bpm, clock, i_clock, poll, dur=1, attack, lfoA, lfoF,
					bufL, bufR, bufRate, bufAmp, bufStartFrame, bufStartPos, bufLoop, bufDur,
					ringFreq, ringAmp
					|
	var signal;

	signal = PlayBuf.ar(1,[bufL, bufR], BufRateScale.kr([bufL, bufR]) * (bufRate+

					SinOsc.ar(lfoF,0,lfoA**2,0)
	),
								loop:bufLoop, startPos:bufStartFrame) * bufAmp;

	signal = signal * SinOsc.ar(ringFreq,pi/2,ringAmp/2,1 - (ringAmp/2));

	signal = signal * EnvGen.ar(Env.new([0,1,0], [attack ,2], [-4,-4], 1), gate, vel, 0, dur*bufDur, 2);

	LNX_Out(signal, out, amp, pan, sendOut, sendAmp);

	//sampleL.poll(poll); // use for debugging

}, metadata: ( specs: (lfoF:\lofreq, ringFreq:\lofreq)))

// A simple SynthDef template

SynthDef("LNX_Saw1", {|out, amp, vel, freq, midi, pan, gate=1, sendOut, sendAmp,
					bpm, clock, i_clock, poll, dur=1, attack, lfoA, lfoF,
					bufL, bufR, bufRate, bufAmp, bufStartFrame, bufStartPos, bufLoop, bufDur,
					ringFreq, ringAmp
					|
	var signal;

	signal = PlayBuf.ar(1,[bufL, bufR], BufRateScale.kr([bufL, bufR]) * (bufRate+

					SinOsc.ar(lfoF,0,lfoA**2,0)
	),
								loop:bufLoop, startPos:bufStartFrame) * bufAmp;

	signal = signal * SinOsc.ar(ringFreq,pi/2,ringAmp/2,1 - (ringAmp/2));

	signal = signal * EnvGen.ar(Env.new([0,1,0], [attack ,2], [-4,-4], 1), gate, vel, 0, dur*bufDur, 2);

	LNX_Out(signal, out, amp, pan, sendOut, sendAmp);

	//sampleL.poll(poll); // use for debugging

}, metadata: ( specs: (lfoF:\lofreq, ringFreq:\lofreq)))

// A simple SynthDef template

SynthDef("LNX_Saw1", {|out, amp, vel, freq, midi, pan, gate=1, sendOut, sendAmp,
					bpm, clock, i_clock, poll, dur=1, attack, lfoA, lfoF,
					bufL, bufR, bufRate, bufAmp, bufStartFrame, bufStartPos, bufLoop, bufDur,
					ringFreq, ringAmp
					|
	var signal;

	signal = PlayBuf.ar(1,[bufL, bufR], BufRateScale.kr([bufL, bufR]) * (bufRate+

					SinOsc.ar(lfoF,0,lfoA**2,0)
	),
								loop:bufLoop, startPos:bufStartFrame) * bufAmp;

	signal = signal * SinOsc.ar(ringFreq,pi/2,ringAmp/2,1 - (ringAmp/2));

	signal = signal * EnvGen.ar(Env.new([0,1,0], [attack ,2], [-4,-4], 1), gate, vel, 0, dur*bufDur, 2);

	LNX_Out(signal, out, amp, pan, sendOut, sendAmp);

	//sampleL.poll(poll); // use for debugging

}, metadata: ( specs: (lfoF:\lofreq, ringFreq:\lofreq)))

// the Chorus & Feedback effect

SynthDef("LNX_DelayChorus", {|on, out, amp, in, inAmp, sendOut, sendAmp, speed, depth,fb,time|

	var sig, mods, noDelays=4, sig2;
	var signal, signalIn = In.ar(in, 2) * inAmp;

	signal = FbL({|feedback|
		mods = { |i|
			SinOsc.kr(speed * linlin(0,noDelays,0.9,1.111), i, depth, 0.01);
		} ! noDelays;
		DelayC.ar(signalIn+(feedback*fb), 0.0045, mods);
	},1,time);

	LNX_FXOut(signal,signalIn,on,out,amp,0,sendOut,sendAmp);

},
rates:[nil,nil,0.1,nil,0.1,nil,0.1,0.1,0.4,nil,0.3],
metadata: ( specs: ( speed: [0.125,10,\exp,0,0," Hz"], depth:[0,0.02,2], fb:[0,0.9])))

// A simple FX template

SynthDef("LNX_Compander", {|on, out, amp, in, inAmp, sendOut, sendAmp, poll, thresh,slopeAbove, slopeBelow, clamp, relax|

	var signal, signalIn = In.ar(in, 2) * inAmp;

	signal = Compander.ar(signalIn,signalIn,
		thresh:thresh.dbamp,
		slopeBelow: slopeBelow,
		slopeAbove: slopeAbove,
		clampTime: clamp,
		relaxTime: relax
	);

	// signal.poll(poll);               // use for debugging

	LNX_FXOut(signal,signalIn,on,out,amp,0,sendOut,sendAmp);

}, metadata: ( specs: (thresh:\db, clamp:[0.002,0.1,\exp], relax:[0.002,0.1,\exp])))


// A simple FX template

SynthDef("LNX_Compander", {|on, out, amp, in, inAmp, sendOut, sendAmp, poll, thresh, ratio,knee,

	attack,release|

	var signal, signalIn = In.ar(in, 2) * inAmp;

	signal = SoftKneeCompressor.ar(signalIn,signalIn, thresh, ratio,knee,attack,release,0);

	// signal.poll(poll);               // use for debugging

	LNX_FXOut(signal,signalIn,on,out,amp,0,sendOut,sendAmp);

}, metadata: ( specs: (thresh:\db, ratio:[1,4,\exp], knee:[1,60,\exp], attack:\delay, release:\delay )))


// A simple FX template

SynthDef("LNX_CrossOver", {|on, out, amp, in, inAmp, sendOut, sendAmp, poll, linAmp, smooth, gate, attack, release|

	var gateAmp, signal, signalIn = In.ar(in, 2) * inAmp;

	gateAmp = (Amplitude.kr(Mix.ar(signalIn)) > (gate.dbamp)).asAudio;
	gateAmp = LagUD.ar(gateAmp,attack, release);
	signal  = CrossoverDistortion.ar(signalIn,linAmp,smooth)* (smooth.linlin(0.1,1,1,3)) * gateAmp;

	LNX_FXOut(signal,signalIn,on,out,amp,0,sendOut,sendAmp);

}, metadata: ( specs: ( linAmp:[0,1] , smooth:[0.1,1], gate:\db, attack:[0,1,2], release:[0,1,2])))

// signal.poll(poll);               // use for debugging

// the Decimator (Sample Rate & Bit reduction)
//
// 1st define a spec & a number func with same name. (copies func from freq)
Spec.add(\sr,[40, 44100, \exp, 0, 44100, " Hz"]);
MVC_NumberFunc.add(\sr,MVC_NumberFunc.at(\freq));

SynthDef("LNX_Decimator", {|on, out, amp, in, inAmp, sendOut, sendAmp, sampleRate, bits|

	var signal, signalIn = In.ar(in, 2) * inAmp;

	signal = Decimator.ar(signalIn, sampleRate, bits );

	LNX_FXOut(signal,signalIn,on,out,amp,0,sendOut,sendAmp);

},
rates: [nil,nil,0.1,nil,0.1,nil,0.1,nil,nil],
metadata: ( specs: ( sampleRate: \sr, bits:[1,32,\exp] )))

// A simple FX template

SynthDef("LNX_CodeFX", {|on, out, amp, in, inAmp, sendOut, sendAmp, poll, filtFreq=1800, q=0.5,
		ratio, lfoFreq, lfoAmp, bits|

	var signal, signalIn = In.ar(in, 2) * inAmp;

	var lfo = SinOsc.ar(lfoFreq,0,lfoAmp,1);

	filtFreq = filtFreq * lfo;

	signal = Decimator.ar(signalIn, filtFreq, bits);

	signal = DFM1.ar(signal, filtFreq*ratio, q)*0.66;

	LNX_FXOut(signal,signalIn,on,out,amp,0,sendOut,sendAmp);

}, metadata: ( specs: ( filtFreq: \freq, q: \unipolar , lfoFreq:\lowFreq, bits:[2,16,\exp])))

// signal.poll(poll);               // use for debugging


// Short stereo delay for decoloration

SynthDef("LNX_ShortDecolDelay", {|on, out, amp, in, inAmp, sendOut, sendAmp, poll, left=0, right=0|

	var signal, signalIn = In.ar(in, 2) * inAmp;

	signal = DelayN.ar(signalIn, 0.04, [left,right]);

	LNX_FXOut(signal,signalIn,on,out,amp,0,sendOut,sendAmp);

}, metadata: ( specs: ( left: [0,0.04], right: [0,0.04])))

// signal.poll(poll);               // use for debugging


// A simple FX template

SynthDef("LNX_CodeFX", {|out, amp, in, inAmp, sendOut, sendAmp, poll, mix,on|

	var signal, signalIn = In.ar(in, 2) * inAmp;

	signal = (signalIn * ({WhiteNoise.ar}!2)*mix) + (signalIn*(1-mix));

	LNX_FXOut(signal,signalIn,on,out,amp,0,sendOut,sendAmp);

}, metadata: ( specs: ()))

// signal.poll(poll);               // use for debugging


// A simple FX template

SynthDef("LNX_CodeFX", {|on, out, amp, in, inAmp, sendOut, sendAmp, poll, freq=1800, mix=0.5,unison|

	var ring, signal, signalIn = In.ar(in, 2) * inAmp;

	ring = [signalIn[0] * SinOsc.ar(freq),signalIn[1] * SinOsc.ar(freq*unison)];

	signal = XFade2.ar(signalIn,ring,mix);

	LNX_FXOut(signal,signalIn,on,out,amp,0,sendOut,sendAmp);

}, metadata: ( specs: ( freq: \lowFreq, mix: \bipolar, unison:[0.5,2,\exp] )))

// signal.poll(poll);               // use for debugging


SynthDef(\LNX_Delay_FX, {|on, out, amp, in, inAmp, sendOut, sendAmp, delayTime=0.5, decay=0.5|

	var maxdelay=5;
	var signal, local;
	var signalIn = In.ar(in, 2) * inAmp;
	var outAmp = Amplitude.kr(Mix.ar(signalIn));

	signalIn = signalIn * (outAmp > 0.02); // noise gate
	local = LocalIn.ar(2) * decay;
	local = OnePole.ar(local, 0.4);
	local = OnePole.ar(local, -0.08);
	local = Rotate2.ar(local[0], local[1], 0.2);
	local = CombC.ar(local, maxdelay, Lag.kr(delayTime, 1));
	local = LeakDC.ar(local);
	signal = ((local + signalIn) * 1.25).softclip;

	LocalOut.ar(signal);
	LNX_FXOut(signal*amp,signalIn,on,out,amp,0,sendOut,sendAmp);

}, metadata: ( specs: ( delayTime: [0.01,5] )))

// its my ping pong dub deLAY and i love it. Hands off! :)

SynthDef("LNX_DubPong", {|on, out, amp, in, inAmp, sendOut, sendAmp, poll, time, freq=1800, q=0.5, freq_hp=20, q_hp=0.5, feed, postAmp, prePan, stereo|

	var signal, signalIn = In.ar(in, 2) * inAmp;

	signal = (Pan2.ar(Mix(signalIn), prePan)*(1-stereo)) + (signalIn*stereo);

	signal = Fb.newPingPong({|feedback|
		feedback = DFM1.ar(feedback , freq_hp, q_hp, 1, 1,0, 0.45);
		feedback = DFM1.ar(feedback , freq, q, 1, 0, 0, postAmp).tanh;
		signal = signal + (feedback * feed);
	},2,Lag.ar(time.asAudio)); // 1 is max delayTime

	signal = signal.tanh;

	LNX_FXOut(signal,signalIn,on,out,amp,0,sendOut,sendAmp);

}, metadata: ( specs: ( prePan:\pan, time:\duration2,
	freq_hp: \freq, q_hp: \unipolar, freq: \freq, q: \unipolar,  postAmp:[0,2] )))

// signal.poll(poll);               // use for debugging


// its my ping pong dub deLAY and i love it. Hands off! :)

SynthDef("LNX_DubPong", {|on, out, amp, in, inAmp, sendOut, sendAmp, poll, time, freq=1800, q=0.5, freq_hp=20, q_hp=0.5, feed, postAmp, prePan, stereo,bpm, timeFine, noise|

	var signal, signalIn = In.ar(in, 2) * inAmp;

	signal = (Pan2.ar(Mix(signalIn), prePan)*(1-stereo)) + (signalIn*stereo);

	signal = Fb.newPingPong({|feedback|
		feedback = DFM1.ar(feedback , freq_hp, q_hp, 1, 1,noise*0.1, 0.45);
		feedback = DFM1.ar(feedback , freq, q, 1, 0, 0, postAmp).tanh;
		signal = signal + (feedback * feed);
	},4,Lag.ar((15/bpm*(time+timeFine)).asAudio)); // 1 is max delayTime

	signal = signal.tanh;

	LNX_FXOut(signal,signalIn,on,out,amp,0,sendOut,sendAmp);

}, metadata: ( specs: ( prePan:\pan, time:[1,16,\lin,1], timeFine:\bipolar,
	freq_hp: \freq, q_hp: \unipolar, freq: \freq, q: \unipolar,  postAmp:[0,2], noise:[0,1,2] )))

// signal.poll(poll);               // use for debugging


// A simple FX template

SynthDef("LNX_FlangFX", {|on, out, amp, in, inAmp, sendOut, sendAmp, poll, speed=1800, feedback=0.5, range=0.5,delay=0.5, lowPass|

	var signal, signalIn = In.ar(in, 2) * inAmp;

	range = range/100; delay=delay/100;

	signal= signalIn + LPF.ar( LocalIn.ar(2),lowPass); //add some feedback

	signal = DelayL.ar(signal ,0.04,SinOsc.ar(speed,0,range,range+delay)); //max delay of 20msec

	LocalOut.ar(feedback**0.7 * signal );

	LNX_FXOut(signal,signalIn,on,out,amp,0,sendOut,sendAmp);

}, metadata: ( specs: ( speed:[0.1,20,\exp,0,1," Hz"], feedback: \unipolar,  lowPass:\freq)))


// A GardnerReverb

SynthDef("LNX_GardnerReverb", {|on, out, amp, in, inAmp, sendOut, sendAmp, poll, time |

	var lp, ap1, ap2, ap3, ap4, revout;
	var signal, signalIn = In.ar(in, 2) * inAmp;
	var fb     = LocalIn.ar(2);

	time = Lag.ar(time.asAudio);

	lp=LPF.ar(signalIn, 4000);
	fb=LocalIn.ar(2);
	ap1=AllpassL.ar(lp + (0.5 * fb), 0.008*2, 0.008*time, 0.0459);
	ap2=AllpassL.ar(ap1, 0.012*2, 0.012*time, 0.06885);
	ap2=DelayL.ar(ap2, 0.004*2, 0.004*time);
	ap3=NestedAllpassL.ar(DelayL.ar(ap2, 0.017*2, 0.017*time), 0.025*2, 0.025*time, 0.5, 0.062*2, 0.062*time, 0.25);
	ap3=DelayL.ar(ap3, 0.031*2, 0.031*time);
	ap4=DoubleNestedAllpassL.ar(DelayL.ar(ap3, 0.003*2, 0.003*time), 0.120*2, 0.120*time, 0.5, 0.076*2, 0.076*time, 0.25, 0.030*2, 0.030*time, 0.25);
	revout=Mix([ap4 * 0.8, ap3 * 0.8, ap2 * 1.5]);
	LocalOut.ar(BPF.ar(revout * 0.5, 1000, 0.5));

    LNX_FXOut(revout,signalIn,on,out,amp,0,sendOut,sendAmp);

}, metadata: ( specs: ( time:[0.25,2] )))

// the GVerb reverb

SynthDef("LNX_GVerb_FX", {|on, out, amp, in, inAmp, sendOut, sendAmp, i_room=30, time=0.5, damp=0.4, dampIn=0.2, i_spread=15, dry=0,early=0.5, taillevel=0.5,filtFreq=1800, q=0.5,poll, thresh=1, attack, decay |

	var gateIn, signal, signalIn = In.ar(in, 2) * inAmp;

	i_room=i_room+1; // stop crash on server
	time=Lag.kr((time*4)**2,0.5);
	damp=1-damp;
	gateIn = (PeakFollower.ar(Mix(signalIn))>thresh);
	gateIn = Slew.ar(gateIn,(10**(3-attack))-1,(10**(3-decay))-1);
	signal = DFM1.ar(signalIn, filtFreq, q,type:1);
	signal = GVerb.ar(Mix(signal), i_room, time*2, damp, dampIn, i_spread,
								dry, early, taillevel, i_room+1);
	signal = signal * gateIn;

	LNX_FXOut(signal,signalIn,on,out,amp,0,sendOut,sendAmp);

}, metadata: ( specs: ( filtFreq: \freq, q: \unipolar, thresh:[0.001,1.5,\exp],
	attack:[0,3], decay:[0,3]
 )))

// A simple FX template

SynthDef("LNX_EQFX", {|on,out, amp, in, inAmp, sendOut, sendAmp, poll
		lowFreq, lowRS, lowAmp,
		freq1, freq1RS, freq1Amp,
		freq2, freq2RS, freq2Amp,
		freq3, freq3RS, freq3Amp,
		hiFreq, hiRS, hiAmp|

	var signal = In.ar(0, 2) * inAmp;
	var signal2 = signal;

	signal = BLowShelf.ar( signal, lowFreq, lowRS, lowAmp);
	signal = BPeakEQ.ar( signal, freq1, freq1RS, freq1Amp);
	signal = BPeakEQ.ar( signal,  freq2, freq2RS, freq2Amp );
	signal = BPeakEQ.ar( signal,   freq3, freq3RS, freq3Amp);
	signal = BHiShelf.ar( signal, hiFreq, hiRS, hiAmp );

	// signal.poll(poll);               // use for debugging

	ReplaceOut.ar(0,Select.ar(1-on,[signal,signal2]));

	//LNX_Out(signal,out,amp,0,sendOut,sendAmp);

}, metadata: ( specs: (
	lowFreq: \freq, lowRS: [0.6,10,1], lowAmp:\dbEQ,
	freq1: \freq, freq1RS: [0.1,10,1], freq1Amp:\dbEQ,
	freq2: \freq, freq2RS: [0.1,10,1], freq2Amp:\dbEQ,
	freq3: \freq, freq3RS: [0.1,10,1], freq3Amp:\dbEQ,
	hiFreq: \freq, hiRS: [0.6,10,1], hiAmp:\dbEQ

)))


// A simple FX template

SynthDef("LNX_AddNoise", {|out, amp, in, inAmp, sendOut, sendAmp, poll, filtFreq=1800, q=0.5
			hpFreq, hpQ, mix, ampFreq, ampMix, on|

	var clean = In.ar(in, 2) * inAmp;
	var dirty = clean * (
		DFM1.ar(
			DFM1.ar(
				WhiteNoise.ar, filtFreq, q
			), hpFreq, hpQ, type:1
		)
	);
	var signal = (clean*(1- mix)) + (dirty*mix);
	var dirty2 = signal * LFNoise1.ar(ampFreq) ;

	signal = (signal*(1- ampMix)) + (dirty2*ampMix);

	LNX_FXOut(signal,clean,on,out,amp,0,sendOut,sendAmp);

}, metadata: ( specs: ( filtFreq: \freq, q: \unipolar, hpFreq: \freq, hpQ: \unipolar,
	\ampFreq:[1,30,\exp]

 )))


// A simple FX template

SynthDef("LNX_EQFX", {|on, out, amp, in, inAmp, sendOut, sendAmp, poll
		lowFreq, lowRS, lowAmp,
		freq1, freq1RS, freq1Amp,
		freq2, freq2RS, freq2Amp,
		freq3, freq3RS, freq3Amp,
		hiFreq, hiRS, hiAmp|

	var signal, signalIn = In.ar(in, 2) * inAmp;

	signal = BLowShelf.ar( signalIn, lowFreq, lowRS, lowAmp);
	signal = BPeakEQ.ar( signal, freq1, freq1RS, freq1Amp);
	signal = BPeakEQ.ar( signal,  freq2, freq2RS, freq2Amp );
	signal = BPeakEQ.ar( signal,   freq3, freq3RS, freq3Amp);
	signal = BHiShelf.ar( signal, hiFreq, hiRS, hiAmp );

	// signal.poll(poll);               // use for debugging

	LNX_FXOut(signal,signalIn,on,out,amp,0,sendOut,sendAmp);

}, metadata: ( specs: (
	lowFreq: \freq, lowRS: [0.6,10,1], lowAmp:\dbEQ,
	freq1: \freq, freq1RS: [0.1,10,1], freq1Amp:\dbEQ,
	freq2: \freq, freq2RS: [0.1,10,1], freq2Amp:\dbEQ,
	freq3: \freq, freq3RS: [0.1,10,1], freq3Amp:\dbEQ,
	hiFreq: \freq, hiRS: [0.6,10,1], hiAmp:\dbEQ, bypass:\switch

)))


// PV Conformal Map

SynthDef("LNX_ConformalMap", {|out, amp, in, inAmp, sendOut, sendAmp, poll,fft, real, imag, on|

	var signal, signalIn = In.ar(in, 2) * inAmp;		// input signal

	var chain = FFT( {LocalBuf(2**fft)}!2 , signalIn);	// signal to FFT (stereo)

	chain      = PV_ConformalMap(chain, real, imag);

	signal = IFFT(chain);							// FFT to signal

	LNX_FXOut(signal,signalIn,on,out,amp,0,sendOut,sendAmp);

},

rates:[nil,nil,nil,nil,nil,nil,nil,\ir], // fft must be initial rate

metadata: ( specs: ( filtFreq: \freq, q: \unipolar, smear:[1,200,\exp], fft:\fft,
	real:\bipolar, imag:\bipolar
)))

// PV_MagFreeze //

SynthDef("LNX_RandComb", {|out, amp, in, inAmp, sendOut, sendAmp, poll, fft,time,feed, thresh, on|

	var chain, signal, signalIn = In.ar(in, 2) * inAmp;
	signal = Fb({|feedback|
		chain = FFT({ LocalBuf(2**fft) }!2, signalIn+(feedback*feed));

		chain =	PV_MagBelow(chain,thresh);

		(IFFT(chain)*2 ).rotate;
	},1,time);

	LNX_FXOut(signal * (1 / (thresh.clip(0.01,inf)))  ,signalIn,on,out,amp,0,sendOut,sendAmp);

},

rates: nil!7 ++ [\ir, 0.1], // fft must be initial rate

metadata: ( specs: ( filtFreq:\freq, q:\unipolar, thresh:[0,1], fft:\fft )))


// PV Magintude Smear

SynthDef("LNX_MagShift", {|out, amp, in, inAmp, sendOut, sendAmp, poll, fft, stretch=1,shift=0, time, feed, on|

	var signal, signalIn = In.ar(in, 2) * inAmp;
	var chain;

	signal = Fb({|feedback|

 		chain = FFT( {LocalBuf(2**fft)}!2 , signalIn+(feedback*feed));
		chain = PV_MagShift(chain, stretch,shift);
		IFFT(chain);

	},1,time);

	LNX_FXOut(signal,signalIn,on,out,amp,0,sendOut,sendAmp);


},

rates:[nil,nil,nil,nil,nil,nil,nil,\ir], // fft must be initial rate

metadata: ( specs: ( filtFreq: \freq, q: \unipolar, stretch:[0.25,4,\exp], bypass:\switch, shift:[-10,10], fft:\fft )))

// PV_MagFreeze //

SynthDef("LNX_PV_MagSmoothDelay", {|out, amp, in, inAmp, sendOut, sendAmp, poll, fft,wipe,time,feed,on|

	var chain, signal, signalIn = In.ar(in, 2) * inAmp;
	signal = Fb({|feedback|
		chain = FFT({ LocalBuf(2**fft) }!2, signalIn+(feedback*feed));
		chain = PV_MagSmooth(chain,wipe);
		IFFT(chain).rotate;
	},1,time);
	LNX_FXOut(signal,signalIn,on,out,amp,0,sendOut,sendAmp);

},

rates: nil!7 ++ [\ir, 0.1], // fft must be initial rate

metadata: ( specs: ( filtFreq:\freq, q:\unipolar, thresh:[0,1], fft:\fft )))

// PV_MagFreeze //

SynthDef("LNX_MagFreeze", {|out, amp, in, inAmp, sendOut, sendAmp, poll, fft, thresh,time,feed,on|

	var chain, signal, signalIn = In.ar(in, 2) * inAmp;               // input signal

	signal = Fb({|feedback|
 		chain = FFT( {LocalBuf(2**fft)}!2 , signalIn+(feedback*feed));
		chain = PV_MagFreeze(chain, signalIn.abs * thresh -0.01);
	 	IFFT(chain);                            // FFT to signal
	},1,time);

	LNX_FXOut(signal,signalIn,on,out,amp,0,sendOut,sendAmp);      // output signal
},

rates: nil!7 ++ [\ir], // fft must be initial rate

metadata: ( specs: ( filtFreq:\freq, q:\unipolar, thresh:[0,1], fft:\fft )))

// PV_MagFreeze //

SynthDef("LNX_RandComb", {|out, amp, in, inAmp, sendOut, sendAmp, poll, fft,wipe,time,feed,smear,stretch=1,shift=0, hipass, on |

	var chain, signal, signalIn = In.ar(in, 2) * inAmp;
	signal = HPF.ar(signalIn,hipass);
	signal = Fb({|feedback|
		chain = FFT({ LocalBuf(2**fft) }!2, signal+(feedback*feed));
		chain = PV_MagSmooth(chain,wipe);
		chain = PV_MagSmear(chain, smear-1);
		chain = PV_MagShift(chain, stretch,shift);
		IFFT(chain);
	},1,time);
	signal=HPF.ar(signal,hipass);
	LNX_FXOut(signal,signalIn,on,out,amp,0,sendOut,sendAmp);

},

rates: nil!7 ++ [\ir, 0.1], // fft must be initial rate

metadata: ( specs: ( filtFreq:\freq, q:\unipolar, thresh:[0,1], fft:\fft, 	smear:[1,200,\exp],stretch:[0.25,4,\exp], shift:[-10,10] , hipass:\freq )))

// PV_MagFreeze //

SynthDef("LNX_SpectralEnhance", {|out, amp, in, inAmp, sendOut, sendAmp, poll, fft, numPartials, ratio, strength, on|

	var signal, signalIn = In.ar(in, 2) * inAmp;       // in signal
	var chain = FFT({ LocalBuf(2**fft) }!2, signalIn); // signal to FFT (stereo)

	chain = PV_SpectralEnhance(chain, numPartials,ratio, strength ); // harmonic enhancer

	signal = IFFT(chain);                                    // FFT to signal
	LNX_FXOut(signal,signalIn,on,out,amp,0,sendOut,sendAmp); // output signal

},

rates: nil!7 ++ [\ir, \ir], // fft must be initial rate

metadata: ( specs: ( filtFreq:\freq, q:\unipolar, numPartials:[1,100,\exp,1], fft:\fft, ratio:[1,100,\exp] )))

// PV_MagFreeze //

SynthDef("LNX_MagFreeze", {|out, amp, in, inAmp, sendOut, sendAmp, poll, fft, thresh, on|

	var signal, signalIn = In.ar(in, 2) * inAmp;       // input signal
	var chain = FFT({ LocalBuf(2**fft) }!2, signalIn); // signal to FFT (stereo)

	chain = PV_MagFreeze(chain, signalIn.abs * thresh -0.01);

	signal = IFFT(chain);                            // FFT to signal
     LNX_FXOut(signal,signalIn,on,out,amp,0,sendOut,sendAmp); // output signal

},

rates: nil!7 ++ [\ir], // fft must be initial rate

metadata: ( specs: ( filtFreq:\freq, q:\unipolar, thresh:[0,1], fft:\fft )))


// PV Magintude Smear

SynthDef("LNX_MagShift", {|out, amp, in, inAmp, sendOut, sendAmp, poll, fft, stretch=1,shift=0,on|

	var signal, signalIn = In.ar(in, 2) * inAmp;		// input signal
	var chain = FFT( {LocalBuf(2**fft)}!2 , signalIn); // signal to FFT (stereo)

	chain = PV_MagShift(chain, stretch,shift);

	signal = IFFT(chain);							// FFT to signal
	LNX_FXOut(signal,signalIn,on,out,amp,0,sendOut,sendAmp); // output signal


},

rates:[nil,nil,nil,nil,nil,nil,nil,\ir], // fft must be initial rate

metadata: ( specs: ( filtFreq: \freq, q: \unipolar, stretch:[0.25,4,\exp], shift:[-10,10], fft:\fft )))


// PV PV_Morph **** USES SEND AS ANOTHER IN ! *****

SynthDef("LNX_Morph", {|out, amp, in, inAmp, sendOut, sendAmp, poll, fft, morph, on|

	var signal = In.ar(in, 2) * inAmp;				// input signal 1
	var signal2 = In.ar(sendOut, 2) * sendAmp;	     // input signal 2

	var chain = FFT( {LocalBuf(2**fft)}!2 , signal);	// signal to FFT (stereo)
	var chain2 = FFT( {LocalBuf(2**fft)}!2 , signal2);	// signal to FFT (stereo)

	chain = PV_Morph (chain,chain2,morph);              // morph

	LNX_FXOut(IFFT(chain),signal+signal2,on,out,amp,0,sendOut,sendAmp); // out

},

rates:[nil,nil,nil,nil,nil,nil,nil,\ir], // fft must be initial rate

metadata: (specs: (

	filtFreq: \freq, q: \unipolar, smear:[1,200,\exp], fft:\fft, morph:\unipolar

)))

// PV_MagFreeze //

SynthDef("LNX_RectComb", {|out, amp, in, inAmp, sendOut, sendAmp, poll, fft, numTeeth, phase, width, on|

	var signal, signalIn = In.ar(in, 2) * inAmp;       // input signal
	var chain = FFT({ LocalBuf(2**fft) }!2, signalIn); // signal to FFT (stereo)

	chain = chain = PV_RectComb(chain, ¬¨‚Ä†numTeeth , phase, width);

	signal = IFFT(chain);                                   // FFT to signal
	LNX_FXOut(signal,signalIn,on,out,amp,0,sendOut,sendAmp);// output signal

},

rates: nil!7 ++ [\ir], // fft must be initial rate

metadata: ( specs: ( filtFreq:\freq, q:\unipolar, numTeeth:[1,100,\exp,1], fft:\fft, ratio:[1,100,\exp] )))

//
// WalshHadamard transform plug-in  in the context of a filter;
//

SynthDef("LNX_WalshHadamard", {| out, amp, in, inAmp, sendOut, sendAmp, which, on|

	var signal, signalIn = In.ar(in, 2) * inAmp;

	signal = WalshHadamard.ar(signalIn,which);

	LNX_FXOut(signal,signalIn,on,out,amp,0,sendOut,sendAmp);

},
rates:[nil,0.1,nil,0.1,nil,0.1,nil,nil],
metadata: ( specs: (which: [0,64,\lin,1] )))


//END OF !LNX_StudSynthdefs
//END OF !LNX_StudSynthdefs
//END OF !LNX_StudSynthdefs

//START OF apad_mh.scd
//START OF apad_mh.scd
//START OF apad_mh.scd

(
SynthDef(\apad_mh, {arg freq=880, amp=0.5, attack=0.4, decay=0.5, sustain=0.8, release=1.0, gate=1.0, out=0;
	var env,sig,mod1,mod2,mod3;
	env=EnvGen.kr(Env.adsr(attack,decay,sustain,release),gate,levelScale:amp,doneAction:2);
	mod1=SinOsc.kr(6).range(freq*0.99,freq*1.01);
	mod2=LFNoise2.kr(1).range(0.2,1);
	mod3=SinOsc.kr(rrand(4.0,6.0)).range(0.5,1);
	sig=SinOsc.ar([freq,mod1],0,env).distort;
	sig=sig*mod2*mod3;
	Out.ar(out,sig);
},
metadata:(
	credit: "A simple sustained sound with vibrato --Mike Hairston",
	tags: [\pad,\vibrato,\sustained]
	)
).add;
)


Synth(\apad_mh);

//END OF apad_mh.scd
//END OF apad_mh.scd
//END OF apad_mh.scd

//START OF \babblingbrook_jmc
//START OF \babblingbrook_jmc
//START OF \babblingbrook_jmc

SynthDef(\babblingbrook_jmc, { |out=0, amp=0.1|
	var son;

	son = ({RHPF.ar(OnePole.ar(BrownNoise.ar, 0.99), LPF.ar(BrownNoise.ar, 14)
		* 400 + 500, 0.03, 0.003)}!2)
		+ ({RHPF.ar(OnePole.ar(BrownNoise.ar, 0.99), LPF.ar(BrownNoise.ar, 20)
		* 800 + 1000, 0.03, 0.005)}!2)  * 4;
	Out.ar(out, son * (amp * 20))
},
metadata: (
	credit: "based on code posted to sc-users 2007-04-07 by james mccartney",
	tags: [\babbling, \brook]
	)
)

//END OF \babblingbrook_jmc
//END OF \babblingbrook_jmc
//END OF \babblingbrook_jmc

//START OF bass.scd
//START OF bass.scd
//START OF bass.scd



//pp. 30-31 Synth bass layers

(
SynthDef(\bassfoundation,{|out= 0 freq = 440 amp = 0.1 gate=1 cutoff= 1000 rq=0.5 pan=0.0|

	var osc, filter, env, filterenv;

	osc = Saw.ar(freq);

	filterenv = EnvGen.ar(Env.adsr(0.0,0.5,0.2,0.2),gate,doneAction:2);
	filter =  RLPF.ar(osc,cutoff*filterenv+100,rq);

	env = EnvGen.ar(Env.adsr(0.01,0.0,0.9,0.05),gate,doneAction:2);

	Out.ar(out,Pan2.ar(filter*env*amp*2,pan));

}).add;


SynthDef(\basshighend,{|out= 0 freq = 440 amp = 0.1 gate=1 cutoff= 3000 rq=0.1 drive = 10.0 pan=0.0|

	var osc, filter, env, filterenv;
	var ab;

	//osc = Mix(VarSaw.ar(freq*[0.25,1,1.5],Rand(0.0,1.0)!3,0.9,[0.5,0.4,0.1]));
	osc = Mix(Saw.ar(freq*[0.25,1,1.5],[0.5,0.4,0.1]));
	//osc = Mix(DPW4Saw.ar(freq*[0.25,1,1.5],[0.5,0.4,0.1]));
	filterenv = EnvGen.ar(Env.adsr(0.0,0.5,0.2,0.2),gate,doneAction:2);
	filter =  RLPF.ar(osc,cutoff*filterenv+100,rq);

 	//distortion
 	//filter = filter.distort.softclip;

	ab = abs(filter);
 	filter = (filter*(ab + drive)/(filter ** 2 + (drive - 1) * ab + 1));

	//remove low end
	filter = BLowShelf.ar(filter,300,1.0,-12);
	//dip at 1600Hz
	filter = BPeakEQ.ar(filter,1600,1.0,-6);

	env = EnvGen.ar(Env.adsr(0.01,0.0,0.9,0.05),gate,doneAction:2);

	Out.ar(out,Pan2.ar(filter*env*amp*2,pan));

}).add;

)




(
Pbind(
	\instrument,\bassfoundation,
	\midinote,36,
	\dur,0.5,
	\rq,1.0
).play
)


(
Pbind(
	\instrument,\basshighend,
	\midinote,36,
	\dur,0.5,
	\rq,1.0
).play
)


//combination
(
p = Pbind(
	\midinote,Pstutter(4,Pseq([36,43,39,31],inf)),
	\dur,0.5,
	\rq,Pstutter(4,Pn(Pseries(1.0,-0.1,8),inf)),
	\cutoff,Pstutter(4,Pn(Pseries(8000,-1000,7),inf))
);

Ppar([
	Pset(\instrument,Pseq([\bassfoundation],inf),p),
	Padd(\instrument,\basshighend,p)
]).play;
)
//END OF bass.scd
//END OF bass.scd
//END OF bass.scd

//START OF bassSimple.scd
//START OF bassSimple.scd
//START OF bassSimple.scd
(
SynthDef("bass", { |freq = 440, gate = 1, amp = 0.5, slideTime = 0.17, ffreq = 1100, width = 0.15, detune = 1.005, preamp = 4|
    var sig, env;
	env = Env.adsr(0.01, 0.3, 0.4, 0.1);
    freq = Lag.kr(freq, slideTime);
    sig = Mix(VarSaw.ar([freq, freq * detune], 0, width, preamp)).distort;
	sig = sig * amp * EnvGen.kr(env, gate, doneAction: 2);
    sig = LPF.ar(sig, ffreq);
    Out.ar(0, sig ! 2)
}).add;
)

Synth("bass");
//END OF bassSimple.scd
//END OF bassSimple.scd
//END OF bassSimple.scd

//START OF beating
//START OF beating
//START OF beating
(
SynthDef("beating", {arg freq = 440, amp = 0.1, art = 1;
	var env, snd1, snd2;
	env = EnvGen.ar(Env.perc(0.01, art), doneAction: 2);
	snd1 = SinOsc.ar(freq);
	snd2 = SinOsc.ar(Line.kr(freq+15, freq, art));
	Out.ar(0, Pan2.ar(Mix([snd1, snd2]), 0, amp*env))
}).add;
)

Synth("beating");
//END OF beating
//END OF beating
//END OF beating

//START OF blips1
//START OF blips1
//START OF blips1
(
SynthDef("blips1", {arg out = 0, freq = 25, numharm = 10, att = 0.01, rel = 1, amp = 0.1, pan = 0.5;
	var snd, env;
	env = Env.perc(att, rel, amp).kr(doneAction: 2);
	snd = LeakDC.ar(Mix(Blip.ar([freq, freq*1.01], numharm, env)));
	Out.ar(out, Pan2.ar(snd, pan));
}).add;
)


(
Pbind(
	\instrument, "blips1",
	\degree, Pwhite(0, 10),
	\dur, 0.2,
	\amp, Pwhite(0.01, 0.05),
	\numharm, Pwhite(10, 20),
	\att, 0.01,
	\rel, Pwhite(0.5, 0.8),
	\pan, Pwhite(-1, 1.0)
).play;
)



//END OF blips1
//END OF blips1
//END OF blips1

//START OF \blowbotl
//START OF \blowbotl
//START OF \blowbotl
(
SynthDef(\blowbotl, { arg out=0, amp=1.0, freq= 200, rq=0.1, gate=1, noise=0.1, vibFreq=5.2, vibGain=0.9;
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
//END OF \blowbotl
//END OF \blowbotl
//END OF \blowbotl

//START OF \bowed
//START OF \bowed
//START OF \bowed
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
//END OF \bowed
//END OF \bowed
//END OF \bowed

//START OF \cheappiano
//START OF \cheappiano
//START OF \cheappiano
(
SynthDef(\cheappiano, { arg out=0, freq=440, amp=0.1, dur=1, pan=0;�
	var sig, in, n = 6, max = 0.04, min = 0.01, delay, pitch, detune, hammer;
	freq = freq.cpsmidi;
	hammer = Decay2.ar(Impulse.ar(0.001), 0.008, 0.04, LFNoise2.ar([2000,4000].asSpec.map(amp), 0.25));
	sig = Mix.ar(Array.fill(3, { arg i;
			detune = #[-0.04, 0, 0.03].at(i);
			delay = (1/(freq + detune).midicps);
			CombL.ar(hammer, delay, delay, 50 * amp)
		}) );

	sig = HPF.ar(sig,50) * EnvGen.ar(Env.perc(0.0001,dur, amp * 4, -1), doneAction:2);
	Out.ar(out, Pan2.ar(sig, pan));
},
metadata: (
	credit: "based on something posted 2008-06-17 by jeff, based on an old example by james mcc",
	tags: [\casio, \piano, \pitched]
	)
).add;
)

Synth(\cheappiano);
//END OF \cheappiano
//END OF \cheappiano
//END OF \cheappiano

//START OF cs80lead_mh
//START OF cs80lead_mh
//START OF cs80lead_mh
(SynthDef("cs80lead_mh", {
	arg freq=480, amp=0.5, att=0.75, decay=0.5, sus=0.8, rel=1.0, fatt=0.75, fdecay=0.5, fsus=0.8, frel=1.0,
		cutoff=200, pan=0, dtune=0.002, vibrate=4, vibdepth=0.015, gate=1.0, ratio=1,out=0,cbus=1;
	var env,fenv,vib,ffreq,sig;
	cutoff=In.ar(cbus);
	env=EnvGen.ar(Env.adsr(att,decay,sus,rel),gate,levelScale:1,doneAction:2);
	fenv=EnvGen.ar(Env.adsr(fatt,fdecay,fsus,frel,curve:2),gate,levelScale:1,doneAction:2);
	vib=SinOsc.ar(vibrate).range(-1*vibdepth,vibdepth)+1;
	freq=Line.ar(freq,freq*ratio,5);
	freq=freq*vib;
	sig=Mix.ar(Saw.ar([freq,freq*(1+dtune)],mul:env*amp));
	// keep this below nyquist!!
	ffreq=max(fenv*freq*12,cutoff)+100;
	sig=LPF.ar(sig,ffreq);
	Out.ar(out, Pan2.ar(sig,pan) );
},
metadata: (
	credit: "Vangelis/Blade Runner lead sound, based on tutorial by meastempo @ http://www.youtube.com/watch?v=Fne0oIEv-WI",
	tags: [\lead, \modulation, \analog, \cs80, \vangelis, \bladerunner]
	)
).add;)


Synth("cs80lead_mh");
//END OF cs80lead_mh
//END OF cs80lead_mh
//END OF cs80lead_mh

//START OF defaultB
//START OF defaultB
//START OF defaultB
(
SynthDef("defaultB", { arg out=0, freq=440, amp=0.1, pan=0, gate=1;
    var z;
    z = LPF.ar(
            Mix.new(VarSaw.ar(freq + [0, Rand(-0.4,0.0), Rand(0.0,0.4)], 0, 0.3)),
            XLine.kr(Rand(4000,5000), Rand(2500,3200), 1)
        ) * Linen.kr(gate, 0.01, 0.7, 0.3, 2);
    OffsetOut.ar(out, Pan2.ar(z, pan, amp));
}, [\ir]).add;
)

Synth("defaultB");
//END OF defaultB
//END OF defaultB
//END OF defaultB

//START OF Epic_Pad_Example.scd
//START OF Epic_Pad_Example.scd
//START OF Epic_Pad_Example.scd
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


//END OF Epic_Pad_Example.scd
//END OF Epic_Pad_Example.scd
//END OF Epic_Pad_Example.scd

//START OF \everythingrhodes
//START OF \everythingrhodes
//START OF \everythingrhodes
(
SynthDef(\everythingrhodes,{|out= 0 freq = 440 amp = 0.1 gate=1 lforate = 4.85 lfowidth= 0.5 cutoff= 2000 rq=0.5 pan = 0.0|

	var pulse, filter, env;

	pulse = Pulse.ar(freq*[1,33.5.midiratio],[0.2,0.1],[0.7,0.3]);

	env = EnvGen.ar(Env.adsr(0.0,1.0,0.8,3.0),gate,doneAction:2);

	//keyboard tracking filter cutoff
	filter = BLowPass4.ar(pulse,(cutoff*(env.squared))+200+freq,rq);

	Out.ar(out,Pan2.ar(Mix(filter)*env*amp,pan));

}).add;


//chorus and compression
SynthDef(\choruscompresseffect, {|out =0 gate= 1|
	var source = In.ar(out,2);
	var chorus;
	var env = Linen.kr(gate, 0.1, 1, 0.1, 2);

	chorus= Splay.ar(Array.fill(4,{
		var maxdelaytime= rrand(0.005,0.02);

		DelayC.ar(source[0], maxdelaytime,LFNoise1.kr(Rand(0.1,0.6),0.25*maxdelaytime,0.75*maxdelaytime) )
	}));

	chorus = Compander.ar(4*(source + chorus),source,0.4,1,4);

	XOut.ar(out,env,chorus);

}).add;

)



(
Pfx(
	Pbind(
		\instrument,\everythingrhodes,
		\midinote,Pseq([12,8,7,0,[-12,4,12],[-12,4,12],[-12,4,12],[-11,5,12],[-11,5,12],[-9,7,12],7]+48,inf),
		\dur,Pseq([0.5,0.5,0.5,0.5,1.5,1.0,1.0,1.0,1.0,2.0,0.5],inf),
		\cutoff,Pstutter(11,Pn(Pseries(500,500,4),inf))
	),
	\choruscompresseffect
).play
)
//END OF \everythingrhodes
//END OF \everythingrhodes
//END OF \everythingrhodes

//START OF \fatvelocitybass
//START OF \fatvelocitybass
//START OF \fatvelocitybass
(
SynthDef(\fatvelocitybass,{|out= 0 freq = 440 amp = 0.1 gate=1 cutoff= 12000 rq=0.25 lagTime=0.01 pan = 0.0|

	var lfo, osc, filter, env;

	var basefreq =  ((freq.lag(lagTime).cpsmidi)+[0,11.95,31.03]).midicps;

	osc = Saw.ar(basefreq,[0.5,0.4,0.1]); //+PinkNoise.ar(Line.kr(1.0,0,0.03));

	env = EnvGen.ar(Env.adsr(0.01,1.0,1.0,0.25),gate,doneAction:2);

	filter = BLowPass4.ar(osc,100+((amp.squared)*(freq+cutoff)),rq);

	Out.ar(out,Pan2.ar(Mix(filter)*env*amp*0.8,pan));

}).add
)


(
PmonoArtic(
	\fatvelocitybass,
	\midinote,Pseq([13,18,3,1,3,1,3,1,4,1,3]+36,inf),
	\dur,Pseq([0.5,0.5,0.5,0.5,1.0,0.5,1.5,0.5,1.0,0.5,1.0],inf),
	\amp,Pseq([0.7,1.0,0.5,0.6,0.4,0.7,0.8,0.3,0.6,0.4,0.7],inf),
	\cutoff,3000,
	\rq,0.1
).play
)
//END OF \fatvelocitybass
//END OF \fatvelocitybass
//END OF \fatvelocitybass

//START OF waveguideFlute
//START OF waveguideFlute
//START OF waveguideFlute
// Originally found at http://ecmc.rochester.edu/ecmc/docs/supercollider/scbook/Ch21_Interface_Investigations/ixi%20SC%20tutorial/ixi_SC_tutorial_10.html

SynthDef("waveguideFlute", { arg scl = 0.2, freq = 440, ipress = 0.9, ibreath = 0.09, ifeedbk1 = 0.4, ifeedbk2 = 0.4, dur = 1, gate = 1, amp = 2;

	var kenv1, kenv2, kenvibr, kvibr, sr, cr, block;
	var poly, signalOut, ifqc;
	var aflow1, asum1, asum2, afqc, atemp1, ax, apoly, asum3, avalue, atemp2, aflute1;
	var fdbckArray;

	sr = SampleRate.ir;
	cr = ControlRate.ir;
	block = cr.reciprocal;

	ifqc = freq;

	// noise envelope
	kenv1 = EnvGen.kr(Env.new(
		[ 0.0, 1.1 * ipress, ipress, ipress, 0.0 ], [ 0.06, 0.2, dur - 0.46, 0.2 ], 'linear' )
	);
	// overall envelope
	kenv2 = EnvGen.kr(Env.new(
		[ 0.0, amp, amp, 0.0 ], [ 0.1, dur - 0.02, 0.1 ], 'linear' ), doneAction: 2
	);
	// vibrato envelope
	kenvibr = EnvGen.kr(Env.new( [ 0.0, 0.0, 1, 1, 0.0 ], [ 0.5, 0.5, dur - 1.5, 0.5 ], 'linear') );

	// create air flow and vibrato
	aflow1 = LFClipNoise.ar( sr, kenv1 );
	kvibr = SinOsc.ar( 5, 0, 0.1 * kenvibr );

	asum1 = ( ibreath * aflow1 ) + kenv1 + kvibr;
	afqc = ifqc.reciprocal - ( asum1/20000 ) - ( 9/sr ) + ( ifqc/12000000 ) - block;

	fdbckArray = LocalIn.ar( 1 );

	aflute1 = fdbckArray;
	asum2 = asum1 + ( aflute1 * ifeedbk1 );

	//ax = DelayL.ar( asum2, ifqc.reciprocal * 0.5, afqc * 0.5 );
	ax = DelayC.ar( asum2, ifqc.reciprocal - block * 0.5, afqc * 0.5 - ( asum1/ifqc/cr ) + 0.001 );

	apoly = ax - ( ax.cubed );
	asum3 = apoly + ( aflute1 * ifeedbk2 );
	avalue = LPF.ar( asum3, 2000 );

	aflute1 = DelayC.ar( avalue, ifqc.reciprocal - block, afqc );

	fdbckArray = [ aflute1 ];

	LocalOut.ar( fdbckArray );

	signalOut = avalue;

	OffsetOut.ar( 0, [ signalOut * kenv2, signalOut * kenv2 ] );

}).add;



// Example
(
Pbind(
	\instrument, "waveguideFlute",
	\degree, Pseq([0, 1, 2, 3, 4], 2),
	\dur, Pwhite(0.5, 1),
	\amp, Pwhite(0.1, 0.4)
).play
)
//END OF waveguideFlute
//END OF waveguideFlute
//END OF waveguideFlute

//START OF \forest_bird_pj
//START OF \forest_bird_pj
//START OF \forest_bird_pj
(SynthDef(\forest_bird_pj, { |out=0, amp=0.1, pan=0|
	Out.ar(out, Pan2.ar(
		BPF.ar(BrownNoise.ar,SinOsc.kr(LFNoise2.kr(50,50,50),0,100,2000),0.001,10)
		* amp, pan))},
metadata: (
	credit: "by Paul Jones, posted to sc-users mailing list 2007-04-07",
	tags: [\forest, \bird]
	)
).add;
)


Synth(\forest_bird_pj);

//END OF \forest_bird_pj
//END OF \forest_bird_pj
//END OF \forest_bird_pj

//START OF \goeysynth
//START OF \goeysynth
//START OF \goeysynth
///////IYICE DUZENLENMESI GEREKIO

(
SynthDef(\goeysynth, {
arg freq=440,amp=0.1, sustain=0.1, pan=0.0;
var source, env;

source= LPF.ar(Mix(LFPar.ar(freq*[0.999,1.001],0,amp)).distort,EnvGen.kr(Env([10000,2000,4000,1000],[0.005,Rand(0.009,0.05),0.005])));

env= EnvGen.kr(Env([0,1,0.4,0.7,0],[Rand(0.001,0.005),0.005,0.005,sustain]), doneAction:2);

Out.ar(0,Pan2.ar(source*env,pan))

}).send(s);

//preferred version if you have the FreeVerb UGen, commented out by default
//SynthDef(\goeyfx, {
//ReplaceOut.ar(0,FreeVerb.ar(In.ar(0,2),0.33,1.5))
//}).send(s);

//adapted from JmC reverb
SynthDef(\goeyfx, {
var a,c,z,y,in;
c = 2; // number of comb delays
a = 3; // number of allpass delays

in=In.ar(0,2);
// reverb predelay time :
z = DelayN.ar(in, 0.048,0.048);

//for delaytime if want modulation-	//LFNoise1.kr(0.1.rand, 0.04, 0.05)
y=Mix.arFill(c,{CombL.ar(z,0.1,rrand(0.01, 0.1),5)});

// chain of 4 allpass delays on each of two channels (8 total) :
a.do({ y = AllpassN.ar(y, 0.051, [rrand(0.01, 0.05),rrand(0.01, 0.05)], 1) });

// add original sound to reverb and play it :
Out.ar(0,(0.2*y));

}).send(s);

)
//END OF \goeysynth
//END OF \goeysynth
//END OF \goeysynth

//START OF harpsichord1
//START OF harpsichord1
//START OF harpsichord1
SynthDef("harpsichord1", { arg out = 0, freq = 440, amp = 0.1, pan = 0;
    var env, snd;
	env = Env.perc(level: amp).kr(doneAction: 2);
	snd = Pulse.ar(freq, 0.25, 0.75);
	snd = snd * env;
	Out.ar(out, Pan2.ar(snd, pan));
}).add;

// add more harpsichord SynthDefs here...
// "harpsichord2", "harpsichord3", etc.

Synth("harpsichord1")
(
Pbind(
	\instrument, "harpsichord1",
	\scale, Scale.harmonicMinor,
	\degree, Pseq([0, 1, 2, 3, 4, 5, 6, [-7, -3, 0, 2, 4, 6], 7], inf),
	\amp, Pseq([Pn(0.1, 8), 0.06],inf),
	\dur, Pseq([0.3, Pn(0.1, 6), 1.3, 1],inf),
	\strum, 0.09
).play
)
//END OF harpsichord1
//END OF harpsichord1
//END OF harpsichord1

//START OF \impulsetrain1
//START OF \impulsetrain1
//START OF \impulsetrain1
(
var numChannels=2;//4  //replace 2 by 4 if you want to try a quadrophonic setup

SynthDef(\impulsetrain1, {arg freq=440, amp=0.1,attack=0.01, sustain=0.1, decay=0.01,pan=0.0, bandwidth=100;
var source, filter, env;

env= EnvGen.ar(Env([0,1,1,0],[attack, sustain, decay]), doneAction:2);

source= Impulse.ar(freq);

filter= BPF.ar(source*env*amp*10,freq,bandwidth/freq);

Out.ar(0,PanAz.ar(numChannels,filter,pan))
}).send(s);

)
//END OF \impulsetrain1
//END OF \impulsetrain1
//END OF \impulsetrain1

//START OF \jilet
//START OF \jilet
//START OF \jilet
(

SynthDef(\jilet, { arg out=0, gate=1, freq=4, amp=0.5, endReflection=1.5, jetReflection=0.5, jetRatio=10.72, noiseGain=0.35, vibFreq=5.925, vibGain=0.02, outputGain=0.20;

	var adsr = (amp*0.2) + EnvGen.ar(Env.adsr(0.005, 0.01, 1.1, 0.01), gate, doneAction: 2);
	var noise = WhiteNoise.ar(noiseGain);
	var vibrato = SinOsc.ar(vibFreq, 0, vibGain);

	var delay = (freq*0.66666).reciprocal;
	var lastOut = LocalIn.ar(1);
	var breathPressure = adsr*Mix([1.0, noise, vibrato]);
	var filter = LeakDC.ar(OnePole.ar(lastOut.neg, 0.7));
	var pressureDiff = breathPressure - (jetReflection*filter);
	var jetDelay = DelayL.ar(pressureDiff, 0.025, delay*jetRatio);
	var jet = (jetDelay * (jetDelay.squared - 1.0)).clip2(1.0);
	var boreDelay = DelayL.ar(jet + (endReflection*filter), 0.05, delay);
	LocalOut.ar(boreDelay);
	Out.ar(out, 0.3*boreDelay*outputGain);
}).add;
)

Synth(\jilet);
//END OF \jilet
//END OF \jilet
//END OF \jilet

//START OF \justwannahavefun
//START OF \justwannahavefun
//START OF \justwannahavefun
(

//added some modulation to ring frequency to roughen sound a bit
SynthDef(\justwannahavefun,{|out= 0 freq = 440 amp = 0.1 ringTime=10.0 pan=(-0.1)|

	var impulse, filter, env;

  	impulse = Impulse.ar(0);

	filter = Ringz.ar(impulse,(freq.cpsmidi + (Rand(0.2,1.2)*SinOsc.kr(Rand(10,50)))).midicps,ringTime);

	env = EnvGen.ar(Env([0.0,1.0,1.0,0.0],[0.001,0.04,0.04]),doneAction:2);

	Out.ar(out,Pan2.ar((filter.softclip(0.9))*env*amp,pan));

}).add;


SynthDef(\gatedreverb,{|out =0 gate= 1 threshold= 0.1 amp=0.1|

	var a,c,z,y,in;
	var env = Linen.kr(gate, 0.1, 1, 0.1, 2);

	c = 5; // number of comb delays
	a = 4; // number of allpass delays

	in=In.ar(out,2);

	gate = if((in.mean)>threshold,in.mean,DC.ar(0)!2);

	// reverb predelay time :
	z = gate; //DelayN.ar(gate, 0.048,0.048);

	//for delaytime if want modulation-	//LFNoise1.kr(0.1.rand, 0.04, 0.05)
	y=Mix.arFill(c,{CombL.ar(z,0.1,rrand(0.01, 0.1),rrand(1.5,4))});

	// chain of 4 allpass delays on each of two channels (8 total) :
	a.do({ y = AllpassN.ar(y, 0.051, [rrand(0.01, 0.05),rrand(0.01, 0.05)], 1) });

	Out.ar(out,Pan2.ar(y,0)*env*amp);

}).add;


)

//reverb a bit excessive and resonant, but isn't that fun in itself, Cyndi?
(
Pfx(
	Pbind(
		\instrument,\justwannahavefun,
		\amp,0.5,
		\pan,Pfunc({1.0.rand}),
		\midinote,Pseq(((6!14)++(3!14))+72,inf),
		\dur,Pseq([0.5,0.25,0.5,0.5,0.25,0.5,1.5],inf),
		\ringTime,Pstutter(7,Pn(Pseries(0.1,0.3,8),inf))
	),
	\gatedreverb
).play
)
//END OF \justwannahavefun
//END OF \justwannahavefun
//END OF \justwannahavefun

//START OF laserbeam
//START OF laserbeam
//START OF laserbeam
/*
Mitchell Sigman (2011) Steal this Sound. Milwaukee, WI: Hal Leonard Books

Adapted for SuperCollider and elaborated by Nick Collins
http://www.sussex.ac.uk/Users/nc81/index.html
under GNU GPL 3 as per SuperCollider license

Minor modifications by Bruno Ruviaro, June 2015.
*/
(
SynthDef("laserbeam", {
	arg out = 0, pan = 0.0, freq = 440, amp = 0.1, att = 0.01;
	var snd, freqenv, ampenv;
	// frequency envelope
	freqenv = EnvGen.ar(Env([4, 0.5, 1, 1], [att, 0.01, 1.0]));
	// amplitude envelope
	// no gate: fixed-time envelope, self-terminating.
	ampenv = EnvGen.ar(
		envelope: Env([0, 1, 0.5, 0.0], [0.02, 0.2, 0.1]),
		levelScale: amp,
		doneAction: 2);
	snd = LFTri.ar(freq: freq * freqenv, mul: ampenv);
	Out.ar(out, Pan2.ar(snd, pan));
}).add;



	Pbind(
		\instrument, "laserbeam",
		\amp, 0.2,
		\midinote,Pseq([36, 48, 60, 72, 84], inf),
		\dur, 0.5,
		\att, Pstutter(8, Pseq([Pshuf((0.01, 0.02..0.1), 1)],inf))
	).play;
)



//their lasers on pp 16-17 seem just to be fast sweeps of frequency of one oscillator by a modulator oscillator, or an envelope.
(

//no use of gate, fixed length
SynthDef(\laserbeam,{|out= 0 freq = 440 amp = 0.1 attackTime= 0.04 gate=1 pan=0.0|

}).add;

)




//END OF laserbeam
//END OF laserbeam
//END OF laserbeam

//START OF linndrum
//START OF linndrum
//START OF linndrum
//LinnDrum:
// p. 23 get the samples from http://machines.hyperreal.org/manufacturers/Linn/LinnDrum/
//The website is a nice resource; there are other sample kits there like Roland TR-909 and TR-808
 //I've just demoed a patch with three samples (kick, snare, hat): I've used Patterns below, though my personal preference would be explicit Busses, Groups, Synths and {}.fork for full control of routings


 //load samples (assumed mono)
(
var basepath = "/Users/EmanTnuocca/Desktop/∞/g_smpl/!aa/";

b = ["kick","sd","chh"].collect{|val| Buffer.read(s,basepath++val++".wav") };

//b[0].numChannels.postln; should be 1 for mono

)



(

SynthDef(\sampleplay,{|out= 0 bufnum = 0 amp = 0.1 gate=1 pan = 0.0|

	var playbuf, env;

	playbuf = PlayBuf.ar(1,bufnum);

	env = EnvGen.ar(Env.adsr(0.0,0.0,1.0,0.1),gate,doneAction:2);

	Out.ar(out,Pan2.ar(playbuf*env*amp,pan));

}).add;

SynthDef(\samplecompress,{|out =0 gain=2 reduction=8 ratio=3 gate= 1 attackTime=0.016 relaxTime=0.05|

	var source = In.ar(out,2);
	var compression;
	var env = Linen.kr(gate, 0.0, 1, 0.1, 2);

	compression= Compander.ar(2*source,source,(-8).dbamp,1.0,ratio.reciprocal,attackTime,relaxTime);

	XOut.ar(out,env, compression);

}).add;

SynthDef(\sampleeq1,{|out =0 gate= 1|

	var source = In.ar(out,2);
	var env = Linen.kr(gate, 0.0, 1, 0.1, 2);
	var eq;

	eq= BLowShelf.ar(source,100,1.0,3);
	eq= BPeakEQ.ar(eq,600,1.0,-3);

	XOut.ar(out,env,eq);

}).add;

SynthDef(\sampleeq2,{|out =0 gate= 1|

	var source = In.ar(out,2);
	var env = Linen.kr(gate, 0.0, 1, 0.1, 2);
	var eq;

	eq= BHiPass(150,0.3);

	XOut.ar(out,env,eq);

}).add;


SynthDef(\samplereverb,{|out =0 gate= 1|

	var source = In.ar(out,2);
	var env = Linen.kr(gate, 0.0, 0.3, 0.1, 2);
	var reverb;

	reverb= FreeVerb.ar(source,1.0,0.6,0.6);

	XOut.ar(out,env,reverb);

}).add;


)



(
var kick, snare,hat;

s.latency= 0.1;

kick = Pbind(
	\instrument, \sampleplay,
	\bufnum,b[0],
	\dur,1.0,
	\pan,0.0,
	\amp, 0.5
);


snare = Pbind(
	\instrument, \sampleplay,
	\bufnum,b[1],
	\dur,Pseq([1.25,0.75,2.0],inf),
	\bus,16,
	\amp,0.45,
	\pan,0.0
);

hat = Pbind(
	\instrument, \sampleplay,
	\bufnum,b[2],
	\dur,Pseq(0.5!8++(0.25!16),inf),
	\amp, 0.15,
	\pan,Pseq(0.3!8++((-0.3)!16),inf)
);


//Pfxb organises private busses for each sound
Ptpar([
	0.0,
	Pfxb(Pfx(kick,\samplecompress),\sampleeq1),
	1.0,
	Pfxb(Pfx(snare,\samplecompress,\gain,1,\reduction,10,\ratio,2,\attackTime,0.02),\samplereverb),
	0.0,
	Pfxb(hat,\sampleeq2)
]).play


)
TempoClock.default.tempo = 2;



//END OF linndrum
//END OF linndrum
//END OF linndrum

//START OF marimba1
//START OF marimba1
//START OF marimba1
(
SynthDef("marimba1", {arg freq = 440, amp = 0.4;
	var snd, env;
	env = Env.linen(0.015, 1, 0.5, amp).kr(doneAction: 2);
	snd = BPF.ar(Saw.ar(0), freq, 0.02);
	snd = BLowShelf.ar(snd, 220, 0.81, 6);
	snd = snd * env;
	Out.ar(0, Splay.ar(snd));
}).add;
)

(
Pbind(
	\instrument, "marimba1",
	\degree, Pwhite(-10, 10),
	\dur, Pwhite(0.2, 0.3),
	\amp, Pwhite(0.1, 0.5)
).play;
)
//END OF marimba1
//END OF marimba1
//END OF marimba1

//START OF \moogbasstone2
//START OF \moogbasstone2
//START OF \moogbasstone2
//no use of gate, fixed length
SynthDef(\moogbasstone2,{|out= 0 freq = 440 amp = 0.1 gate=1 attackTime= 0.2 fenvamount=0.5 cutoff= 1000 gain=2.0 pan=0.0|

	var osc, filter, env, filterenv;

	//alternative: richer source
	osc = Mix(Pulse.ar(freq.lag(0.05)*[1.0,1.001,2.0],Rand(0.45,0.5)!3,0.33));

	filterenv = EnvGen.ar(Env.adsr(attackTime,0.0,1.0,0.2),gate,doneAction:2);
	filter =  MoogFF.ar(osc,cutoff*(1.0+(fenvamount*filterenv)),gain);

	env = EnvGen.ar(Env.adsr(0.001,0.3,0.9,0.2),gate,doneAction:2);

	Out.ar(out,Pan2.ar((0.7*filter+(0.3*filter.distort))*env*amp,pan));

}).add;




//via Comb filter for feedback
SynthDef(\delayeffect, {|out =0 gate= 1|
	var source = In.ar(out,2);
	var delay;
	var env = Linen.kr(gate, 0.1, 1, 0.1, 2);

	delay= CombC.ar(source,0.25,0.25,2.0);

	XOut.ar(out,env, delay);

}).add;


SynthDef(\choruseffect, {|out =0 gate= 1|
	var source = In.ar(out,2);
	var chorus;
	var env = Linen.kr(gate, 0.1, 1, 0.1, 2);

	chorus= Mix.fill(7, {

		var maxdelaytime= rrand(0.005,0.02);

		DelayC.ar(source, maxdelaytime,LFNoise1.kr(Rand(4.5,10.5),0.25*maxdelaytime,0.75*maxdelaytime) )

	});

	XOut.ar(out,env, chorus);

}).add;






(
Pfx(
	Pfx(
		Pmono(
			\moogbasstone2,
			\amp, 0.8,
			\midinote,Pseq([24,36,43,48, 43,48,36,36, 36,36,39,36, 31,31,31,31, 31,34,31,34],inf),
			\dur,0.25,
			\gain,Pn(Pseries(2,0.1,19),inf),
			\cutoff,Pstutter(3,Pn(Pseries(50,250,40),inf)),
			\attackTime,Pn(Pseries(0.0,0.01,30),inf),
			\fenvamount,Pstutter(4,Pn(Pseries(0.0,0.05,20),inf))
		),
		\delayeffect
	),
	\choruseffect
).play

)



// END OF \moogbasstone2
// END OF \moogbasstone2
// END OF \moogbasstone2

//START OF moogbass
//START OF moogbass
//START OF moogbass
/*
Mitchell Sigman (2011) Steal this Sound. Milwaukee, WI: Hal Leonard Books
pp. 18-19

Adapted for SuperCollider and elaborated by Nick Collins
http://www.sussex.ac.uk/Users/nc81/index.html
under GNU GPL 3 as per SuperCollider license

Minor SynthDef modifications by Bruno Ruviaro, June 2015.
*/

SynthDef("moogbass", {
	arg out = 0, pan = 0, freq = 440, amp = 0.1, gate = 1, cutoff = 1000, gain = 2.0, lagamount = 0.01, att = 0.001, dec = 0.3, sus = 0.9, rel = 0.2, chorus = 0.7;

	var osc, filter, env, filterenv, snd, chorusfx;

	osc = Mix(VarSaw.ar(
		freq: freq.lag(lagamount) * [1.0, 1.001, 2.0],
		iphase: Rand(0.0,1.0) ! 3,
		width: Rand(0.5,0.75) ! 3,
		mul: 0.5));

	filterenv = EnvGen.ar(
		envelope: Env.asr(0.2, 1, 0.2),
		gate: gate);

	filter =  MoogFF.ar(
		in: osc,
		freq: cutoff * (1.0 + (0.5 * filterenv)),
		gain: gain);

	env = EnvGen.ar(
		envelope: Env.adsr(0.001, 0.3, 0.9, 0.2, amp),
		gate: gate,
		doneAction: 2);

	snd = (0.7 * filter + (0.3 * filter.distort)) * env;

	chorusfx = Mix.fill(7, {

		var maxdelaytime = rrand(0.005, 0.02);
		DelayC.ar(
			in: snd,
			maxdelaytime: maxdelaytime,
			delaytime: LFNoise1.kr(
				freq: Rand(4.5, 10.5),
				mul: 0.25 * maxdelaytime,
				add: 0.75 * maxdelaytime)
		)
	});

	snd = snd + (chorusfx * chorus);

	Out.ar(out, Pan2.ar(snd, pan));

}).add;



	Pmono(
		"moogbass",
		\amp, 0.5,
		\midinote, Pseq([24, 36, 48, 36, 35, 36, 43, 48],inf),
		\dur, Pstutter(8, Pseq([0.5, 0.25], inf)),
		\gain, Pn(Pseries(2, 0.1, 19),inf),
		\cutoff, Pn(Pseries(4000, 400, 18), inf),
		\chorus, 0.7
	).play;

//END OF moogbass
//END OF moogbass
//END OF moogbass

//START OF \mrostinato
//START OF \mrostinato
//START OF \mrostinato
(
SynthDef(\mrostinato,{|out= 0 freq = 440 amp = 0.1 gate=1 lforate = 10 lfowidth= 0.5 pan = 0.0|

	var lfo, pulse, filter, env;

	lfo = LFTri.kr(lforate,Rand(0,2.0)!3);

	pulse = Pulse.ar(freq*[1,1.01,0.5],lfo*lfowidth+0.5);

	env = EnvGen.ar(Env.adsr(0.01,0.05,0.5,0.1),gate,doneAction:2);

	Out.ar(out,Pan2.ar(Mix(pulse)*env*amp,pan));

}).add
)


(
PmonoArtic(
	\mrostinato,
	\octave,Pseq([3,3,4,4],inf),
	\scale,[0,2,3,5,7,8,10],
	\degree,Pstutter(16,Pseq([0,2,5,3],inf)),
	\dur,0.25,
	\lfowidth,Pstutter(8,Pn(Pseries(0.0,0.05,7),inf)),
	\lforate,Pstutter(5,Pn(Pseries(0.5,0.2,11),inf)),
	\pan,Pstutter(2,Prand([-0.5,-0.3,0.3,0.5],inf))
).play
)


 //richer sequence with some heavier moments
(
Pbind(
	\instrument,\mrostinato,
	\sustain,Pstutter(64,Prand([0.1,0.5,0.7],inf)),
	\octave,Pseq([3,3,4,4,3,3,5,2],inf),
	\scale,[0,2,3,5,7,8,10],
	\degree,Pstutter(16,Prand([0,-1,1,2,-3,5,6,3,4,2],inf)),
	\dur,0.25,
	\lfowidth,Pstutter(8,Pn(Pseries(0.0,0.05,7),inf)),
	\lforate,Pstutter(5,Pn(Pseries(0.5,0.2,11),inf)),
	\pan,Pstutter(2,Prand([-0.5,-0.3,0.3,0.5],inf))
).play
)
//END OF \mrostinato
//END OF \mrostinato
//END OF \mrostinato

//START OF noisy
//START OF noisy
//START OF noisy
SynthDef("noisy", {arg out = 0, freq = 440, amp = 0.2, pan = 0.5;
	var snd, env;
	env = Env.perc(0.02, 0.1).kr(doneAction: 2);
	snd = Mix(LFPulse.ar(
		freq: freq * [1, 5/2],
		iphase: 0.0,
		width: 0.5,
		mul: amp));
	snd = snd * env ;
	Out.ar(out, Pan2.ar(snd, pan));
}).add;



(
Pbind(
	\instrument, "noisy",
	\degree, Pseq([0, 1, 2, 3, 4, -10, -5], inf),
	\dur, Pwhite(0.09, 0.15),
	\amp, Pwhite(0.05, 0.2)
).play;
)


//END OF noisy
//END OF noisy
//END OF noisy


//START OF organdonor
//START OF organdonor
//START OF organdonor
/*
Mitchell Sigman (2011) Steal this Sound. Milwaukee, WI: Hal Leonard Books
pp. 12-13

Adapted for SuperCollider and elaborated by Nick Collins
http://www.sussex.ac.uk/Users/nc81/index.html
under GNU GPL 3 as per SuperCollider license

Minor SynthDef Smodifications by Bruno Ruviaro, June 2015.
*/

// Essentially, Pulse waveforms in multiple octaves; I've refined the patch to add freq*[1,2,3] which gives octave and octave + fifth over fundamental [Nick Collins]


SynthDef("organdonor",{
	arg out = 0, pan = 0.0, freq = 440, amp = 0.1, gate = 1, att = 0.01, dec = 0.5, sus = 1, rel = 0.5, lforate = 10, lfowidth = 0.01, cutoff = 100, rq = 0.5;

	var vibrato, pulse, filter, env;
	vibrato = SinOsc.ar(lforate, Rand(0, 2.0));
	// up octave, detune by 4 cents
	// 11.96.midiratio = 1.9953843530485
	// up octave and a half, detune up by 10 cents
	// 19.10.midiratio = 3.0139733629359
	freq = freq * [1, 1.9953843530485, 3.0139733629359];
	freq = freq * (1.0 + (lfowidth * vibrato));
	pulse = VarSaw.ar(
		freq: freq,
		iphase: Rand(0.0, 1.0) ! 3,
		width: Rand(0.3, 0.5) ! 3,
		mul: [1.0,0.7,0.3]);
	pulse = Mix(pulse);
	filter = RLPF.ar(pulse, cutoff, rq);
	env = EnvGen.ar(
		envelope: Env.adsr(att, dec, sus, rel, amp),
		gate: gate,
		doneAction: 2);
	Out.ar(out, Pan2.ar(filter * env, pan));
}).add;



Pbind(
	\instrument, "organdonor",
	\amp, 0.2,
	\midinote, Pseq([
		63, 64, 67, 69,
		[67, 70, 72], 60,
		[65, 69], 63, [64, 67],
		\rest, 68, 69, 72, 74,
		[72, 75, 77], 65,
		[70, 74], 68, [69, 72],
		\rest, 63, 64, 67, 69,
		[67, 70, 72], 60,
		[65, 69], 63, [64, 67],
		\rest, 67, 69, [64, 67, 70, 72]
	], 1),
	\dur, Pseq([
		Pn(1/3, 4),
		2/3, 1/3,
		2/3, 1/9, 2/9,
		Rest(2/3), Pn(1/3, 4),
		2/3, 1/3,
		2/3, 1/9, 2/9,
		Rest(2/3), Pn(1/3, 4),
		2/3, 1/3,
		2/3, 1/9, 2/9,
		Rest(2/3), 1/3, 2/3, 2
	], 1),
	\legato, Pseq([Pn(1, 6), 0.5, 1, 1, 1], inf),
	\lfowidth, Pseq([
		Pn(0, 4), Pgeom(0.03, 0.4, 6),
		Pn(0, 4), Pgeom(0.02, 0.8, 6),
		Pn(0, 4), Pgeom(0.03, 0.5, 6),
		Pseries(0, 0.015, 3)
	], inf),
	\lforate, Pseq([
		Pn(0, 4), Pgeom(4, 0.5, 6),
		Pn(0, 4), Pgeom(6, 0.5, 6),
		Pn(0, 4), Pgeom(8, 0.5, 6),
		Pseries(0.0, 4, 3)
	], inf),
	\rq, Pseries(0.4, -0.01),
	\cutoff, Pn(Pseries(6000, -400, 10),inf)
).play;

//END OF organdonor
//END OF organdonor
//END OF organdonor

//START OF \pitchednoise
//START OF \pitchednoise
//START OF \pitchednoise
(
SynthDef(\pitchednoise, {arg freq=440, amp=0.1,attack=0.01, sustain=0.1, decay=0.01,pan=0.0, bandwidth=100;
var source, filter, env;

env= EnvGen.ar(Env([0,1,1,0],[attack, sustain, decay]), doneAction:2);

source= WhiteNoise.ar;

filter= BPF.ar(source*env*2*amp,freq,bandwidth/freq);

Out.ar(0,PanAz.ar(numChannels,filter,pan))
}).send(s);
)

Synth(\pitchednoise);
//END OF \pitchednoise
//END OF \pitchednoise
//END OF \pitchednoise

//START OF \plastickystrings
//START OF \plastickystrings
//START OF \plastickystrings
//book claims 5.9KHz LFO rate: possible typo...
(
SynthDef(\plastickystrings,{|out= 0 freq = 440 amp = 0.1 gate=1 lforate = 5900 lfowidth= 0.01 cutoff= 12000 rq=0.5 pan=0.0|

	var lfo, saw, filter, env;

	lfo = LFTri.ar(lforate,Rand(0,2.0));

	saw = Saw.ar(freq*(1.0+(lfowidth*lfo)),0.5);

	//filter = BBandPass.ar(saw,freq,4);
	filter = BHiPass.ar(saw,freq,rq); 	//or using cutoff

	env = EnvGen.ar(Env.adsr(0.4,0.0,1.0,1.0),gate,doneAction:2);

	Out.ar(out,Pan2.ar(filter*env*amp,pan));

}).add;


SynthDef(\choruseffect2, {|out =0 gate= 1|
	var source = In.ar(out,2);
	var chorus;
	var env = Linen.kr(gate, 0.1, 1, 0.1, 2);

	chorus= Mix.fill(17, {
		var maxdelaytime= rrand(0.005,0.02);
		DelayC.ar(source, maxdelaytime,LFNoise1.kr(Rand(4.5,10.5),0.25*maxdelaytime,0.75*maxdelaytime) )

	});

	XOut.ar(out,env,0.5*chorus);

}).add;

)


//goldfrapp number 1 riff
(
Pfx(
	Ppar([
		Pbind(
			\instrument, \plastickystrings,
			\amp, 0.2,
			[\midinote,\dur],Pseq([[72,1.5],[68,6.5],[72,1.5],[68,1.5],[61,5.0]],inf),
			\lfowidth,Pn(Pseries(0.0,0.001,16),inf),
			\lforate,5900, //5.9?
			\rq,Pn(Pseries(0.9,-0.05,8),inf)
		),
		Pbind(
			\instrument, \plastickystrings,
			\amp, 0.3,
			[\midinote,\dur],Pseq([[44,8.0],[37,8.0]],inf),
			\lfowidth,Pn(Pseries(0.0,0.001,16),inf),
			\lforate,5.9,
			\rq,0.9
		),
	]),
	\choruseffect2
).play
)




//END OF \plastickystrings
//END OF \plastickystrings
//END OF \plastickystrings

//START OF plucking
//START OF plucking
//START OF plucking
(
SynthDef("plucking", {arg amp = 0.1, freq = 440, decay = 5, coef = 0.1;
var env, snd;
env = EnvGen.kr(Env.linen(0, decay, 0), doneAction: 2);
snd = Pluck.ar(
        in: WhiteNoise.ar(amp),
        trig: Impulse.kr(0),

        maxdelaytime: 0.1,
        delaytime: freq.reciprocal,
        decaytime: decay,
        coef: coef);
    Out.ar(0, [snd, snd]);
}).add;
)

Synth("plucking");
//END OF plucking
//END OF plucking
//END OF plucking

//START OF PMCrotale
//START OF PMCrotale
//START OF PMCrotale
(
SynthDef("PMCrotale", {
	arg freq = 261, tone = 3, art = 1, amp = 0.8, pan = 0;
	var env, out, mod;

	env = Env.perc(0, art);
	mod = 5 + (1/IRand(2, 6));

	out = PMOsc.ar(freq, mod*freq,
		pmindex: EnvGen.kr(env, timeScale: art, levelScale: tone),
		mul: EnvGen.kr(env, timeScale: art, levelScale: 0.3));

	out = Pan2.ar(out, pan);

	out = out * EnvGen.kr(env, timeScale: 1.3*art,
		levelScale: Rand(0.1, 0.5), doneAction:2);
	Out.ar(0, out*amp); //Out.ar(bus, out);

}).add;

)

Synth("PMCrotale");
//END OF PMCrotale
//END OF PMCrotale
//END OF PMCrotale

//START OF \poly
//START OF \poly
//START OF \poly
(

	SynthDef(\poly, { | out=0 gate=1 freq=400 |
		var aEnv, fEnv, osc1, osc2, flt;
		aEnv = EnvGen.kr(Env.asr(0.2, 1, 0.1), gate, doneAction: 2);
		fEnv = EnvGen.kr(Env.asr(7, 1, 0.2), levelScale: 12000);
		osc1 = Pulse.ar(freq * [1, 1.007], LFCub.kr(2, 0, 0.3, 0.5));
		osc2 = Pulse.ar(freq / 2, 0.3);
		flt = RLPF.ar(osc1 + osc2, fEnv, 0.9, aEnv);
		Out.ar(out, flt);
	}).add;
)

Synth(\poly);
//END OF \poly
//END OF \poly
//END OF \poly

//START OF \scratch
//START OF \scratch
//START OF \scratch
// Josh Parmenter (2007)
// record scratcher

SynthDef(\scratch, {arg gate = 1, buffer;
	var buf, speed, env;
	env = EnvGen.kr(
		Env([0,1,0], [0.1, 0.1], \sin, 1),
		gate, doneAction: 20);
	speed = MouseX.kr(-10, 10);
	speed = speed - DelayN.kr(speed, 0.1, 0.1);
	speed = MouseButton.kr(1, 0, 0.3) + speed ;
	buf = PlayBuf.ar(1, buffer, speed * BufRateScale.kr(buffer), loop: 1);
	Out.ar(0, (buf * env).dup );
}).add;

s.boot;

// path to a mono soundfile here
a = Buffer.read(s, "/Users/EmanTnuocca/Desktop/∞/g_smpl/sense.wav");

b = Synth(\scratch, [\buffer, a]);

// move mouse to scrub the record.
// press mouse button to 'stop the record', you can scrub while it is stopped.

// stop the synth
b.set(\gate, 0);
// free the Buffer
a.free;


//END OF \scratch
//END OF \scratch
//END OF \scratch

//START OF \res
//START OF \res
//START OF \res
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
//END OF \res
//END OF \res
//END OF \res

//START OF \ressquares
//START OF \ressquares
//START OF \ressquares
(

SynthDef(\ressquares,{|out= 0 freq = 440 amp = 0.1 gate=1 cutoff=8000 rq=0.8 pan=(-0.1)|

	var pulse, filter, env;

	//2 cents detune for second oscillator
	pulse = Mix(Pulse.ar( ((freq.cpsmidi)+[0,0.02]).midicps, 0.5))*0.5;

	filter =  BLowPass.ar(pulse,100+cutoff,rq);

	env = EnvGen.ar(Env.adsr(0.002,0.1,1.0,0.2),gate,doneAction:2);

	Out.ar(out,Pan2.ar(filter*env*amp,pan));

}).add;


SynthDef(\synthdistortion, {|out =0 gate= 1|
	var source = In.ar(out,2);
	var env = Linen.kr(gate, 0.0, 1, 0.1, 2);
	var abs, excess,output;

	abs = source.abs;

	excess = (abs-0.1).max(0.0).min(0.9)/0.9;

	//original plus sinusoidal perturbation of amount based on absolute amplitude
	output = source+(excess*(sin(excess*2pi*5)*0.5-0.5));

	XOut.ar(out,env,output*env);

}).add;

)


//quite loud, be careful
(
Pfx(
	Pbind(
		\instrument,\ressquares,
		\midinote,Pseq([12,0,0,0,3,0,7,0]+36,inf),
		\dur,0.25,
		\amp,Pstutter(8,Pn(Pseries(0.2,0.08,8),inf)),
		\cutoff,Pstutter(8,Pn(Pseries(100,125,11),inf)),
		\rq,Pstutter(4,Pn(Pseries(0.2,-0.02,9),inf)),
		\pan,-0.1
	),
	\synthdistortion
).play
)
//END OF \ressquares
//END OF \ressquares
//END OF \ressquares

//START OF sctweets2.scd
//START OF sctweets2.scd
//START OF sctweets2.scd
{a=LocalIn.ar;LocalOut.ar(Mix.ar(x=SinOsc.ar((Decay.ar(Impulse.ar([4,4.005]),1e3*a.abs)*50), a).distort));x;}.play;//tryingharder_to_noavail
{f=LocalIn.ar(2).tanh;k=Latch.kr(f[0].abs,Impulse.kr(0.5));LocalOut.ar(f+AllpassN.ar(Pulse.ar([2,3],k*0.01+1e-6,0.9),1,k*0.3,100*k));f}.play
play{f=LocalIn.ar(2).tanh;k=Latch.kr(f[0].abs,Impulse.kr(1/4));LocalOut.ar(f+CombC.ar(Blip.ar([4,6],100*k+50,0.9),1,k*0.3,50*f));f}//44.1kHz
Pspawner({|r|f={|t|r.par(Pbindf(Pbind(\note,Pseq([-1,1,6,8,9,1,-1,8,6,1,9,8]+5,319)),\dur,t))};f.(1/6);r.wait(12);f.(0.1672)}).play//s.reich
play{t=Impulse.ar(75);Sweep.ar(t,150).fold(0,1)*PlayBuf.ar(1,Buffer.read(s,"s*/*".pathMatch[2]),1,t,Demand.ar(t,0,Dbrown(0,2e5,2e3,inf)))!2}
play{f={LocalBuf(512)};r={|k,m|RecordBuf.ar(Pulse.ar(8,m,6e3),k)};r.(a=f.(),0.99);r.(b=f.(),0.99001);Out.ar(0,IFFT([a,b]).tanh)};//44.1kHz:)
play{AllpassC.ar(SinOsc.ar(55).tanh,0.4,TExpRand.ar(2e-4, 0.4,Impulse.ar(8)).round([2e-3,4e-3]),2)};// #supercollider with bass please...
play{Mix({a=LFNoise1.ar(0.2.rand);DelayC.ar(BPF.ar(WhiteNoise.ar(Dust2.ar(a*a*4**2).lag(8e-3)),10e3.rand+300,0.09),3,a*1.5+1.5,45)}!80).dup}
play{a=BPF.ar(Saw.ar([40,40.001]),LFNoise0.kr(128)+1*4e3+146,LFNoise1.kr(1)+1*5e-2+0.01).tanh;CombC.ar(a,9,a.abs.lag(2)*9,a.abs.lag(1)*100)}
play{LocalOut.ar(x=DelayC.ar(LPF.ar(LFNoise0.ar(8)**2+LocalIn.ar(2).tanh.round(0.05),6e3),1,LFNoise0.ar(8!2).range(1e-4,0.02)));x.tanh}//#sc
play{t=Impulse.ar(8)*LFNoise1.ar(2);CombL.ar(Saw.ar([3,4],Decay.ar(t,0.1)).tanh,1,TRand.ar(0,0.01,t).round(15e-4),TRand.ar(-30,30,t))};//#sc
play{LocalOut.ar(x=LFNoise1.ar(0.5*LocalIn.ar(1)+0.1,0.5,0.5));PitchShift.ar(PitchShift.ar(Pulse.ar([90,90.01],x),10,x*4,x),10,4-(x*4),1-x)}
play{q=[0,3,5,7,10];t=Impulse.kr(4)*LFNoise0.kr>0;PitchShift.ar(Saw.ar(Demand.kr(t,0,Drand((q+12++q+33).midicps,inf)),Decay.kr(t,3)),7,2)!2}
play{(HPF.ar(LFNoise1.ar(2),[10,10.1])*100).tanh}// #supercollider yay! (be very careful with this one, very loud)
play{t=[0,3,5,7,10,12]+30;a=Demand.kr(Impulse.kr(8),0,Drand(t+24++t,inf));(BHiPass.ar(LFNoise1.ar(8)**3,[a,a+0.2].midicps,a/2e3,67-a)).tanh}
play{t=[0,0,0,1,5,7,10,12,12,12]+30;a=Duty.kr(1/8,0,Dxrand(t+24++t++t,inf));(BHiPass.ar(LFNoise1.ar(8)**6,[a,a+7].midicps,a/3e3,67-a)).tanh}
play{LeakDC.ar(BRF.ar(Saw.ar(8,Decay2.kr(x=Duty.kr(1/8,0,Drand([0,Drand((0.4,0.5..1))],inf)),0.01,0.3))**1.5,x*20+[45.1,45],0.1)).tanh}//#sc
play{t=Impulse.kr(1/4);k=Duty.kr(2,0,Dxrand((50,52..90),inf));r={|a|Saw.ar(TIRand.kr(1,6,t),a+1*3)}!3;BPF.ar(r.sum,[k,k+0.5],1/9,50).tanh}
play{Mix({|k|k=k+1/2;2/k*Mix({|i|i=i+1;Blip.ar(i*XLine.kr(rand(2e2,4e2),87+LFNoise2.kr(2)*k,15),2,1/(i/a=XLine.kr(0.3,1,9))/9)}!9)}!40)!2*a}
play{t=[0,3,5,7,10,12]+40;p=Duty.ar(1/4,0,Drand((t+12++t).midicps,inf));Blip.ar([b=TRand.ar(1500,2e3,Impulse.ar(16)).lag,b+p],1).mean!2**2}
play{n=LFNoise0.kr(_);v=Blip.ar([2e4,2e4-9],1,n.(16)*0.5+0.5**9);42.do{v=LeakDC.ar(AllpassC.ar(v,1,n.(5)*5e-2+(5e-2+1e-3),100))};tanh(v*99)}
play{Mix(HPF.ar(MidEQ.ar(Limiter.ar(GVerb.ar(HPF.ar(Pulse.ar([[0.1,0.11],[0.12,0.13]],0.6,5e-3),99),[[1,5/4],[1.5,2]],99)),9e3,0.9,9),200))}
{r=44100;BufRd.ar(1,Buffer.read(s,".s*/*".pathMatch[2]),[r,r+500]*LFNoise0.ar(8,9,9)+(Sweep.ar(t=Impulse.ar(8),r)%TRand.ar(100,r/2,t)))}.play
play{i=Impulse.ar(_);SinOsc.ar(i.(2).lagud(0,0.4)*360,Integrator.ar(Integrator.ar(i.(64).lag(LFNoise1.ar(2!2,2,2))*99,0.9),0.99).fold2(pi))}
play{Splay.ar(Integrator.ar(LFNoise0.ar(5!3,k=Duty.ar(6.4,0,Dseq([0.05,Drand([0.04,0.08],1)],inf))).round(k/10)).sin.sqrt.tanh,0.3)}//#sc...
play{LocalOut.ar(k=LeakDC.ar(Integrator.ar(Pulse.ar(pi./[1,2.57],[0.54,0.46]),(1-LocalIn.ar(2)).fold(0,[0.9,0.85])).wrap2(pi).sin));k.mean!2}
{n=LFNoise0.ar(_);f=[60,61];tanh(BBandPass.ar(max(max(n.(4),l=n.(6)),SinOsc.ar(f*ceil(l*9).lag(0.1))*0.7),f,n.(1).abs/2)*700*l.lag(1))}.play
play{LocalOut.ar(k=tanh(500*(PinkNoise.ar(1!2)**(8/(LagUD.ar(y=LocalIn.ar(2).range(0, 0.9)+0.1,0,0.2))))));Splay.ar(k,1-y)}
play{i=Impulse.ar(8).lag(0.3)!2;10.do{i=LeakDC.ar(AllpassC.ar(i,1,LFNoise0.ar(8).range(1e-5,0.2),-0.15,LFNoise0.ar(8).range(1,3))).tanh};i}
play{n=LFNoise0.kr(*_);v=Blip.ar([60,61],5,n.(4)**8);12.do{v=LeakDC.ar(CombC.ar(v,1,n.([1,0.05,0.06]).lag(5e3),9))};Limiter.ar(v,0.9,1)}
play{Blip.ar([16e3,16150],2,LFTri.ar(Duty.ar(LFNoise0.ar(0.2,4,6),0,Dseq([70,30,0],inf))).clip(0,1))}//#supercollider_summer



by 'block'

{SinOsc.ar(65.41,0,(SinOsc.kr(0.5, 0,0.5)))+SinOsc.ar(130.81,0,(SinOsc.kr(10,0,0.5)))+SinOsc.ar(523.25,0,(SinOsc.kr(0.05,0,0.05)))}.play;//b



by Juan A. Romero ('rukano')

play{a=LFNoise0;b=FBSineC.ar(a.kr(4,2e4,2e4),a.kr(10,16,17),1,1.005,0.7)!2;Latch.ar(b,Impulse.ar(a.kr(0.5,5e3,4e3)))*a.kr(5,0.4,0.5)}// #sc
play{RLPF.ar(Latch.ar(SinOsc.ar([100,100.5])!2,Impulse.ar(Duty.kr(Dseq([2,1]/4,inf),0,Drand((67,67.2..70),inf)))),800)} // #sc _dubsteppy_
play{CombN.ar(Splay.ar(Pulse.ar(Gendy3.kr([1,2,4,6])+LFNoise0.ar(4,6,Gendy3.kr(5,freq:[10,99])))*Gendy2.ar([0,1],maxfreq:[55,99])),3,0.4,2)}
play{x=LFDNoise3;Blip.ar(x.kr(1,[400,100],500),x.kr([1,2],6,5))*Gendy3.ar(1,1,1,1,x.kr(1,99,91),1,0.1)*x.ar(0.5,0.5,0.5)}// #sc
t=("come out to show them "!999).join;Speech.init(2);[98,99].do{|r,i|Speech.setSpeechVoice(i,3).setSpeechRate(i,r).channels[i].speak(t)};
t=("it's gonna rain "!999).join;Speech.init(2);[98,99].do{|r,i|Speech.setSpeechVoice(i,3).setSpeechRate(i,r).channels[i].speak(t)};// #sc sr
a=UGen.subclasses;fork{loop{u=a.choose;try{play{u.ar*EnvGen.ar(Env.perc(0.1,1),doneAction:2)!2}};1.wait}}//#sc #supercollider !!!NOT SAFE!!!
f=_.speak;fork{loop{f.("hi scott");2.wait;Speech.channels[0].voice_(20.rand)}} // #sc #supercollider // now with tag
f={|i,o,d|play{Saw.ar(XLine.kr(i,o,d,1,0,2))!2*EnvGen.kr(Env.sine(d))}};fork{loop{t=rrand(1e3,9e3);f.(t,t/4,rrand(0.1,1));9.rand.wait}}//#sc
play{a=[1,1.01,2,2.02,3.5,4.01,5.501];SinOsc.ar(Duty.kr(0.2,0,Dseq([10,11,0,12.2,0,0,10,0]+39,inf).midicps)*(a++(a*2))).sum!2/2}//DAF #sc
play{SinOsc.ar(Duty.kr(0.2,0,Dseq([0,5,0,15,0,12,0,0,12,0,12,0,12,10,0,12]+47,inf).midicps)*[1,1.01,2,2.02,3.5,4.01,5.501]).sum!2}// DAF #sc
b=Buffer.read(s,"*/*v".pathMatch@0);play{x=SinOsc;ring4(ar(TGrains,2,kr(Impulse,ar(x,[1,3],0,10,[9,20])),b,1,ar(x,1/9),0.01),ar(x,1e3))*9}
b=Buffer.read(s,"*/*v".pathMatch[0]);play{TGrains.ar(2,Impulse.kr([9,19]*LFNoise0.kr(2,1,1)),b,LFNoise0.kr(1,(1..4),2),0,1/10).sum*10}//#sc
play{var cpm=60;SinOsc.ar(700)!2*ToggleFF.ar(TDuty.ar(Dseq([1,1,1,1,1,2, 2,1,2,1,2,2, 1,1,1,1,1,3]/1e3*(6e3/cpm),inf)))} // S.O.S @ #sc
play{SinOsc.ar(Latch.ar(SinOsc.ar(1.75,0,1e2,2e2),Impulse.ar((1,1.1..2)*2)).lag(0.1)/2*(1,1.25..8)).sum**3!2}// #supercollider (last one)
play{ SinOsc.ar(Latch.ar(SinOsc.ar(1.75,0,1e2,2e2),Impulse.ar([1,1.0001])).lag(0.1)*(1,1.25..8)).sum**3!2 } // #supercollider
play{Splay.ar(SinOsc.ar(Latch.ar(SinOsc.ar(1.3,0,4e2,5e2),Impulse.ar([1,1.0001])*[1,2,3,4]).lag(0.05)))} // #supercollider (nicer)
play{SinOsc.ar(Latch.ar(SinOsc.ar(1.3,0,4e2,5e2),Impulse.ar([1,1.0001])).lag(0.05))} // #supercollider /* simple but hypnotizing */
play{x=LFNoise2.kr(22,5,9);CombC.ar(Splay.ar(Gendy3.ar([4,2],[0.5,1],[1/9,1/4]*x,[1/2,1/8]*x,(9,49..199))),5,[0.13,0.1],[x/2,x/2.1])} // #sc
{x=TRand.kr(30,XLine.kr(2e4,30,99,1,1,2),Impulse.kr((1..9))).cpsmidi.round.midicps;Splay.ar(SinOsc.ar(x))*AmpComp.kr(x,10)}.play // #sc
fork{loop{d=rrand(1,9);play{f=200.rand+60;Splay.ar(SinOsc.ar(XLine.kr(f,(f,f+1..f+f),d,1,0,2),0,0.1))};d.wait}}//cpu expense #supercollider
play{RLPF.ar(Demand.ar(Impulse.ar(20000),0,Dxrand([Dseq((1,0.005..0)),Dseq([1]++(0!555)),Dseq((0!999))],inf)),Line.kr(100,3000,80),0.1)!2}
play{SinOsc.ar(Latch.ar(LFSaw.ar(0.3,1,100,300).cpsmidi.round.midicps*[1,2],Impulse.ar(4)))} // tonal scales #supercollider
play{a=(1,0.97..0.005);GVerb.ar(Decay2.ar(TDuty.ar(Dseq(a++(a/2)++(a/4)++(a/8))),XLine.kr(0.05,0.001,15),0.1,0.05)*9,4,1)}//#supercollider
play{t=TDuty.kr(Dseq([1,1,4,2,2]/8,inf));Resonz.ar(Crackle.ar!2,Demand.kr(t,0,Dseq([250,8e3],inf)),Demand.kr(t,0,Dwhite(0.01,0.5,inf)))}
play{t=TDuty.kr(Dseq([1,1,4,2,2]/8,inf));Resonz.ar(WhiteNoise.ar!2,Demand.kr(t,0,Dseq([250,8e3],inf)),Demand.kr(t,0,Dwhite(0.01,0.5,inf)))}
play{t=Impulse.ar((1,1.3..4)/2).sum;Decay2.ar(t,0.05,0.2,Splay.ar(SinOsc.ar(Demand.ar(t,0,Drand((120,180..800),inf)))*ToggleFF.ar(t)))}
play{t=Impulse.ar((1,1.3..4)/2).sum;Decay2.ar(t,0.001,0.2,Splay.ar(SinOsc.ar(Demand.ar(t,0,Drand((120,145..400),inf)))*ToggleFF.ar(t)+t))}
play{BPF.ar(SoundIn.ar(0),Array.geom(16,120,1.5),0.005,2).sum.dup} // kind of EZ resonator / vocoder for the mic #supercollider
play{FreeVerb.ar(CombC.ar(SoundIn.ar(0).softclip,1,1/120,1),0.4,1,1).dup}//easy hall/resonator fx for my lap steel guitar #supercollider
play{SinOsc.ar(Latch.ar(SinOsc.kr(0.75).range(0,12).round.midiratio*[200,400*SinOsc.kr(0.01).range(1,4)],TDuty.kr(Dseq([1,2]/8,inf))))} //ye
play{t=TDuty.kr(Drand(([1,2,3]/8),inf));SinOsc.ar(Demand.kr(t,0,Drand((50,53..71).midicps,inf))*[1,1.5]*LFPulse.kr(0.5).range(1,2)).dup}



by Sylvain Le Beux
[warning: this one blows out filters and could blow out speakers, so be careful with volume.]

play{LFGauss.ar(105,0.3,0,0,2)*BPF.ar(LFSaw.ar([250,251]),XLine.ar(50,20000,100),XLine.ar(0.01,10,100))}



by 'mathk'

{k=LFNoise1.kr(8.0.rand+2,0.5,0.5);SinOsc.ar([[333,444],[222,555]]*(k+(rrand(1.0,5.0))),0,k).sum.cubed * 0.1}.play // #supercollider #babies
play{SinOsc.ar([0.501,1,1.001,6.01]*Lag.kr(LFNoise0.kr(1).range(110,550).round(110),0.5),0,0.25).sum.clip(-0.6,0.6).cubed.dup}
play{SinOsc.ar(450,0.25pi,0.5*LFPulse.kr(LFPulse.kr(0.75,0,0.5,0.5)))!2} // #supercollider #030 -> 040
a=Array.series(7,7,7);play{Limiter.ar(Klank.ar(`[a.midicps+777.rand,a/77,a/7],Decay.ar(Dust.ar([7,0.7]),7)).cubed,0.77,0.7)}//#supercollider
play{RLPF.ar(LFSaw.ar([15,15.03],0,0.2),LFSaw.ar(LFNoise0.kr(0.05,-13,-14)).range(200,9000),0.1).clip(-0.8,0.3)} // #supercollider
a=Array.series(33,333.rand+111,11.0.rand+1);play{Klank.ar(`[a,a/1111,a/111],Impulse.ar([1,1.1]/3)).clip(0,1)} // #supercollider
{SinOsc.ar+SinOsc.ar(phase:1pi)}.play // #supercollider #silence is golden



by 'michai'

Ptpar(({|i|[i*8,Pbind(\scale,[0,2,4,7,9],\degree,Pseq(32.fib.fold(0,10),4)+(2*i+i)-10,\dur,1+2**i%2/6)]}!4).flat).play // #supercollider



by Thor Magnusson

{x=SinOsc;y=LFNoise0;a=y.ar(8);(x.ar(Pulse.ar(1)*24)+x.ar(90+(a*90))+MoogFF.ar(Saw.ar(y.ar(4,333,666)),a*XLine.ar(1,39,99,99,0,2)))!2}.play



by 'micromoog'

play{LFCub.ar(LFSaw.kr(LFPulse.kr(1/4,1/4,1/4)*2+2,1,-20,50))+(WhiteNoise.ar(LFPulse.kr(4,0,LFPulse.kr(1,3/4)/4+0.05))/8)!2}// #supercollider



by 'mutantsounds'

{Splay.ar(SinOsc.ar(Array.fill(100,{\freq.asSpec.map(LFNoise2.kr(0.001))})))}.play // #supercollider
{x=Array.fill(3,{Array.fill(50,{[40,150].asSpec.map(LFNoise2.kr(0.01))})});Splay.ar(SinOsc.ar(x[0]+SinOsc.ar(x[1],0,x[2]-39)))}.play
x=PathName.new("sounds").files;Buffer.read(s,x[x.size.rand].fullPath,action:{|b|PlayBuf.ar(b.numChannels,b,LFNoise2.kr(50,2),loop:1)}.play)
s.cachedBuffersDo({|b|b.free})
{f=[50,55,5000,10000];Splay.ar(Array.fill(4,{|i|Ringz.ar(RLPF.ar(Dust.ar(0.1),f[i],0.5),f[i],3)}))}.play //#supercollider
{f=Array.rand(4,5000,10000);Splay.ar(Array.fill(4,{|i|Ringz.ar(RLPF.ar(Dust.ar(0.1),f[i],0.5),f[i],3)}))}.play//#supercollider & no sub!
{x=Array.fill(5,{[0.00001,0.03].asSpec.map(LFNoise2.kr(3))});Splay.ar(Friction.ar(LFTri.ar(50),friction:x,mass:x*30000))}.play



by Click Nilson

//blurble back into stereo: 135 chars
play{({|i|var n=rrand(3,99),e=EnvGen.ar(Env({1.0.rand2**3}!n,{exprand(1e-4,1)}!(n-1),i,n-2,0));e*Blip.ar(9e2.rand2,e*9%[9,7])}!9).mean}

//140 char: blurble
play{({|i|var n=rrand(3,99),e=EnvGen.ar(Env({1.0.rand2**3}!n,{exprand(1e-4,1)}!(n-1),i,n-2,0));e*Blip.ar(exprand(9,9e2),(e*99)%9) }!9).mean}

//bells of squelch: 141 char
play{({|i|var n=rrand(9,99),e=EnvGen.ar(Env({1.0.rand2**3}!n,{exprand(1e-4,1)}!(n-1),i,n-2,0));e*Blip.ar(exprand(9,9e2),(e*99)%9) }!99).mean}

//to fit the arbitrary constraint; 139 char bells of squelch
play{({|i|var n=rrand(9,99),e=EnvGen.ar(Env({1.0.rand2**3}!n,{exprand(1e-4,1)}!(n-1),i,n-2,0));e*Blip.ar(rrand(9,9e2),(e*99)%9) }!99).mean}



by Fredrik Olofsson

{RHPF.ar(GbmanN.ar([2300,1150]),LFSaw.ar(Pulse.ar(4,[1,2]/8,1,LFPulse.ar(1/8)/5+1))+2)}.play



by 'otmiv'

{Out.ar([0,1],e=Trig.ar(Dust.ar(10));e=TRand.kr(100,10000,e);e=SinOsc.ar(e).round(SinOsc.ar(Line.kr(0,100,30))))}.play; // #supercollider :D
play{Splay.ar(Array.fill(15,{Ringz.ar(Dust.ar(Rand(1,10)), Rand(50,9000).round(100), 2)},1,0.5,0))} // #supercollider tweets = good idea!!!



by 'josé henrique padovani'

{120.do{z=1e3;x={rrand(0.1,5)}!8;{{Klank.ar(`[x*z,x/60,2],LFNoise2.ar)*EnvGen.kr(Env.sine(2),doneAction:2)}!2}.play;1.wait;}}.fork
play{x=165;b=SinOsc;p=Trig.ar(Saw.ar(x),1);y=b.ar(p*x);z=b.ar(p);(GVerb.ar(GrainIn.ar(2,y,y/2,z,p*z,-1),9))/9}//basso gettato #SuperCollider



by Samuel Potter

{var r=SinOsc.ar(1/2,[0,1],3,1),s=Impulse.ar([r+0.2,r]);FreeVerb.ar(Decay.ar(s,r,MoogFF.ar(SinOsc.ar(([r.asin])*50),400)).softclip/2)}.play
{var d=Demand.kr(Impulse.kr(2),0,LFTri.kr(1,0,2,1));(Ringz.ar(Dust.ar([d,d+1]),d**d,1)+Decay.ar(Impulse.ar(4),0.5,SinOsc.ar(50!2)));}.play



by Julian Rohruber

/*eclecticity*/ Ndef(\x, { SinOsc.ar(BrownNoise.ar(30!2, 200), Ndef(\x).ar * LFNoise1.kr(1!2,1,1)) }).play;
{SinOsc.ar(XLine.kr(0.001,1,120).range(100,{exprand(300,10000)}!120)).mean}.play;//chdegaulle
{(SinOsc.ar(LFNoise1.kr(0.01).exprange(100,{exprand(300,10000)}!120)).mean)!2}.play;//chdegaulleabout
var f={rrand(0.2, 2.0)}; {Splay.ar(SinOsc.ar(SinOsc.ar(0.02 * (f!8)).sum.round(f!8) * (f!8+1) * 100)) * 0.1}.play;//stairs #supercollider
var f={rrand(1, 2.1)}; {Splay.ar(SinOsc.ar(SinOsc.ar(0.02 * (f!8)).sum.round(f!8) * (f!8+1) + 1 * 100)) * 0.1}.play;//stairs #supercollider
{Pulse.ar(Select.kr(LFSaw.kr(10).range(0,3), [1,1.25,1.5] * 440)) * LFPulse.kr(0.2, 0, 0.25) }.play; // #supercollider 040 -> 030
Ndef(\x, { var r = SinOsc.ar(Ndef(\x).ar, [0, pi]); Splay.ar(max(sin(r[0] * ({ exprand(1.0, 3000.0)}!8) + LFNoise1.kr(1!8)),0))*0.4 }).play;
Ndef(\x, { ring1(SinOsc.ar(234*XLine.kr(0.1,1,5)+LFNoise2.kr(2!2, 5)),DelayC.ar(Ndef(\x).ar.reverse,0.03,0.02+(Ndef(\x).ar*0.001)))}).play;



by Dan Stowell

{{PinkNoise.ar*LFSaw.ar(0-Duty.kr(1,0, Dseq((2**(0,1..5) ++ [3,3]).scramble,inf)),1).range(0,1).squared.squared}.dup}.play// #supercollider
{t=HPZ1.kr(LFNoise0.kr(4));{Pulse.ar((t*10000+0.0001).lag(0, 0.1))}.dup+(SinOsc.ar([220, 330])*Integrator.kr(t))*0.1}.play;// #supercollider
{{Klank.ar(`[{exprand(100,1000)}.dup(50)], Saw.ar(MouseX.kr(3, LFPulse.kr(6/3,0,1/5).range(3,3000),1),0.0005))}.dup}.play;// #supercollider
Pbind(\type,\set,\id,{|freq|Saw.ar(freq+[0,1])/10}.play.nodeID,\midinote,Pseq("supercollider!!!".ascii,inf),\dur,1/4).play//#supercollider
{LocalOut.ar(a=DynKlank.ar(`[LocalIn.ar.clip2(LFPulse.kr([1,2,1/8]).sum/2)**100*100],Impulse.ar(10)));HPF.ar(a).clip2!2}.play//#supercollider
i=LFPulse;k=[100,1];{i.ar(i.kr(5).lag(0.1).linexp(0,1,50,Duty.kr(0.1,0,Dseq([k,Dxrand(11.fib,28)],inf).midicps)))/9}.play;// #supercollider
i=SinOsc;x={exprand(0.1,0.01)};{Splay.ar({[PinkNoise,BrownNoise,GrayNoise].choose.ar*i.ar(i.ar(0.01).range(x,x))}!9)}.play// #supercollider
{b = 4410.collect(_.sin).as(LocalBuf); x=PlayBuf.ar(1,b,1.1,loop:1); RecordBuf.ar(x,b); x.dup}.play //#supercollider magic wand
[22,23,35].do{|x|Pbind(\type,\set,\id,{|freq=1|Saw.ar(freq)/10.dup}.play,\midinote,Pseq(x.fib%100++2,16),\dur,0.1).play;}//#supercollider
{Pulse.ar(Duty.kr(0.1,0,Dseq("123456.....ginghamginghamgingham".as(Array).pyramid.ascii.midicps/2, inf)),0.5,0.1)!2}.play
{h=100;b=((0..9)/h).as(LocalBuf);[h,1!32++[8,6]*h/2,h!32++"dead".ascii].mean{|n|COsc.ar(b,Duty.kr(0.2,0,Dseq(n,inf)))}}.play//#supercollider
{a=[0.02,0.1,1,2,3,4]; k=LFPar.kr(a+0.5).sum; f=Latch.kr(k,Impulse.kr(a)); Splay.ar(SinOsc.ar(f*100+300)/5)}.play // #supercollider
play{a=Duty.kr(0.1,0,Dseq(fib(32).wrap(20,55).midicps,inf));HPF.ar(LeakDC.ar(Splay.ar(LFCub.ar([-1,a,a/3,-2])))*9).clip2/9};//#supercollider



by 'superdorch'

( play{Out.ar([0,1],LPF.ar(Saw.ar(SinOsc.kr(XLine.kr(9,5000,9),0,20,99),0.7,0),500)*EnvGen.kr(Env.new([0,1,0],[7,1])));}) ) #supercollider



by Andrea Valle

// A sombre SuperCollider hymn in 138 chars
{13.do{|i|k="SuperCollider"[i].ascii;20.do{|u|{MoogFF.ar(Saw.ar((k/4).midicps)*EnvGen.ar(Env.perc),u+k*9,k/30)}.play;(k*0.001).wait}}}.fork



by Nathaniel Virgo ('headcube')

{a=PinkNoise.ar(1!2);50.do{a=BBandStop.ar(a,LFNoise1.kr(0.05.rand).exprange(40,15000),exprand(0.1,2))};LPF.ar(a,1e5)}.play// #supercollider
{a=LFTri.ar(1);20.do{a=BAllPass.ar(a,80,1);a=((a+0.02)*LFNoise0.kr(1/2)*8).tanh;a=LeakDC.ar(a,0.995)};a*0.1!2}.play// #supercollider
p={|f,a=1|LFPulse.ar(f)*a*[1,1.01]};{p.(p.(100-p.(1/16,20))+p.(2,1+p.(1/4))-0.5*200)+p.(100-p.(1/8,20),p.(8))*0.1}.play// #supercollider
f=0;Routine({inf.do{|i|f=i/12+f%[4,3];{Formant.ar(2**f*100,2**(i%8*f*0.2)*100,100)*Line.kr(0.1,0,1)}.play;0.25.wait;}}).play//#supercollider
{LocalOut.ar(a=CombN.ar(BPF.ar(LocalIn.ar(2)*7.5+Saw.ar([32,33],0.2),2**LFNoise0.kr(4/3,4)*300,0.1).distort,2,2,40));a}.play//#supercollider
d={|l,h,f,p|({Ringz.ar(LFPulse.ar(f,p,0.01),exprand(l,h),0.5)}!20).sum};{d.(50,100,2,[0,1/4])+d.(3e3,1e4,4,0)+d.(2e2,3e3,1,0.5)*3e-4!2}.play
d={|l,h,f,p,n|sum({Ringz.ar(LFPulse.ar(f,p,0.01),exprand(l,h).round(n),0.5)}!20)};{d.(50,150,[2,1,1],[0,1/4,3/4],[1,40,50])*3e-4!2}.play
x=LFPulse;d={|l,h,f,p,n|sum({Ringz.ar(x.ar(f,p,0.01),exprand(l,h).round(n),0.6)}!40)};{d.(30,150,2,[0,0.3],[1,x.kr(1/8)*10+40])*3e-4!2}.play
n={|r,f,d=1|2**LFNoise0.kr(1!d,r)*f};{p=n.(4,1e3);CombN.ar(Ringz.ar(LFPulse.ar(1,0,0.01),n.(2,p,80),0.6).sum,8/5,8/5,60)*4e-4!2}.play
n={|r,f,n=0,d=1|round(r**LFNoise0.ar([4,1,8,2]!d)*f,n)};play{Splay.ar(d=n.(3,0.6);Ringz.ar(d*0.01,n.(2,n.(20,400),40,20),d).mean.tanh)}
x=0;Pbind(*[type:\set,id:{|freq=10|LFTri.ar(freq.lag(0.1))!2}.play.nodeID,freq:Pfunc{x=x+32%355;x%12+1*40},dur:1/6]).play// #supercollider
x=0;Pbind(*[type:\set,id:{|freq=10|f=freq;LPF.ar(Saw.ar(f),f.lag(1)*3)!2}.play.nodeID,freq:Pfunc{x=x+32%35;x%12+1*40},dur:1/6]).play
play{p=PinkNoise.ar(1!2);BRF.ar(p+Blip.ar(p+2,400),150,2,0.1)+LPF.ar(FreeVerb2.ar(*LPF.ar(p+0.2*Dust.ar(0.1),60)++[1,1,0.2,1e4]).tanh,2000)}
Ndef('x',{Normalizer.ar(FreqShift.ar(Rotate2.ar(*Ndef('x').ar++1/8).tanh,20*[-3,0.995])+Dust.ar(1!2,0.005),1,0.5)}).play// #supercollider
Ndef(\x,{DelayN.ar(BRF.ar(Saw.ar(20!2)*0.01+Rotate2.ar(*(Ndef(\x).ar*2).tanh++0.1),20**LFNoise1.kr(0.6)*500,1),1,1)}).play// #supercollider
b=Buffer.read(s,"sounds/a11wlk01.wav");play{t=Impulse.kr(5);PlayBuf.ar(1,b,1,t,Demand.kr(t,0,Dseq(1e3*[103,41,162,15,141,52,124,190],4)))!2}
Ndef('x',{x=(Ndef('x').ar*1.8).tanh;BPF.ar(x+[0.01,0.1],12**Latch.ar(x.mean,Impulse.ar(3)).lag(0.1)*200)})// tin whistle #supercollider
Ndef('x',{x=Ndef('x').ar+0.01;a=BPF.ar(x,6**Latch.ar(x,Dust.ar(x))*200,0.1).sin;9.do{a=AllpassN.ar(a,0.2,{0.2.rand}!2,9)};a+a.mean}).play;
f=g=0;Routine({loop{g=g+1e-3;f=f+g%1;play{l=Line.kr(1,0,3,doneAction:2);h=2**f*100;e=Pluck.ar(CuspL.ar,1,i=1/h,i,2,0.3)!2};0.15.wait}}).play
a=1@2;f=1;w=Window().front.drawHook_({900.do{Pen.line(a*200,(a=(a*(f=f+2e-6)).y.cos+1@a.x)*200)};Pen.stroke});AppClock.play{w.refresh;0.01}
p={|f,a=5|GVerb.ar(LFPulse.ar(f)*a)+f};play{tanh(HPF.ar(p.(99-p.(1/2,20)*(1+p.(2,1/5))+p.(4+p.(1/2)),0.5),80,XLine.kr(4e-4,1/8,61,1,0,2)))}
n={|r,f,n=0,d=1|round(r**LFNoise0.ar([4,1,8,2]!d)*f,n)};play{Splay.ar(d=n.(3,0.6);Ringz.ar(d*0.01,n.(2,n.(20,400),40,20),d).mean.tanh)}
x=0;Pbind(*[type:\set,id:{|freq=10|LFTri.ar(freq.lag(0.1))!2}.play.nodeID,freq:Pfunc{x=x+32%355;x%12+1*40},dur:1/6]).play// #supercollider
play{p=PinkNoise.ar(1!2);BRF.ar(p+Blip.ar(p+2,400),150,2,0.1)+LPF.ar(FreeVerb2.ar(*LPF.ar(p+0.2*Dust.ar(0.1),60)++[1,1,0.2,1e4]).tanh,2000)}
Ndef('x',{Normalizer.ar(FreqShift.ar(Rotate2.ar(*Ndef('x').ar++1/8).tanh,20*[-3,0.995])+Dust.ar(1!2,0.005),1,0.5)}).play// #supercollider
b=Buffer.read(s,"sounds/a11wlk01.wav");play{t=Impulse.kr(5);PlayBuf.ar(1,b,1,t,Demand.kr(t,0,Dseq(1e3*[103,41,162,15,141,52,124,190],4)))!2}
b=Buffer.read(s,"sounds/a11wlk01.wav");play{t=Impulse.kr(6);BufGrain.ar(t,0.3,b,1,Demand.kr(t,0,Dseq([26,8,11,42,44,3,5,37,4,32,45]/50,4)))}
Ndef('x',{x=Ndef('x').ar+0.01;a=BPF.ar(x,6**Latch.ar(x,Dust.ar(x))*200,0.1).sin;9.do{a=AllpassN.ar(a,0.2,{0.2.rand}!2,9)};a+a.mean}).play;
a=1@2;f=1;w=Window().front.drawHook_({900.do{Pen.line(a*200,(a=(a*(f=f+2e-6)).y.cos+1@a.x)*200)};Pen.stroke});AppClock.play{w.refresh;0.01}
Ndef(\,{LPF.ar(x=DelayN.ar(LeakDC.ar(Ndef(\).ar,1-2e-6)*0.99,1,0.01)+Dust.ar(0.5!2);x+(Trig1.ar(x<(x.mean.lag(30)),4e-3)*0.05),800)}).play
Ndef(\,{x=DelayL.ar(n=Ndef(\);n.ar,2,LFNoise0.kr(0.03*_!20)+1)+Blip.ar(0.5);LeakDC.ar(LPF.ar(x+x.mean*0.15,4e3)).sin});play{Splay.ar(n.ar)}
play{w=LFSaw;a=w.ar(-3,1)+1/2;f=Sweep.ar(0,3).floor;f=(f**3+f%8+4)*(f%3+3)%49*3;CombN.ar(RLPF.ar(w.ar(f)*a,f**a*30,0.3).tanh,5/6,5/6,6)!2}
play{PitchShift.ar(CombN.ar(Formant.ar(101,4**LFNoise1.kr(0.5)*450,200),1,0.5,99),1,Duty.kr(4,0,Dseq([[6,8,10],[6,7.2,7]]/8,inf))).sum/25!2}
Ndef(\,{x=DelayN.ar(LeakDC.ar(Ndef(\).ar),1,z=1e-2);LPF.ar(Trig1.ar(Amplitude.kr(x,5,120)*1.5+x+z-Dust.ar(2),4e-3)*0.1+x*0.99,1200)}).play
play{b=LocalBuf(1e5,2).clear;x=BufRd.ar(2,b,Phasor.ar(0,1,0,1e5))*0.6;BufWr.ar(Blip.ar([1,1.01],10)/5+x,b,LFNoise1.ar(0.2)+1*5e4);x}// #sc
play{b=LocalBuf(4e5,2).clear;BufCombL.ar(b,LeakDC.ar(BufRd.ar(2,b,LFNoise1.ar(0.25)+1*2e5)*0.98)+Blip.ar(2!2,10),2,20)/10}// #supercollider
play{b=LocalBuf(4e5,2).clear;BufCombL.ar(b,LeakDC.ar(LPF.ar(PlayBuf.ar(2,b,16/15,0,0,1),300))+Blip.ar([20,21],1),2,40)/20}// #supercollider
play{b=LocalBuf(2*SampleRate.ir,2);BufCombL.ar(b,LeakDC.ar(RLPF.ar(Limiter.ar(PlayBuf.ar(2,b,0.4,0,0,1),0.5)+Dust.ar(0.1),5e3,0.03)),1,10)}
play{({|i|x=Dbufrd(b=LocalBuf(5).clear,i);x=x**x-LFNoise0.ar(1/(2**i),50).floor%16;Pulse.ar(Duty.ar(1/8,0,Dbufwr(x,b,i))*20)}!5).mean!2}
play{x=Splay.ar({|i|RLPF.ar(0.6**i*40*Impulse.ar(2**i/32,1/2),4**LFNoise0.kr(1/16)*300,5e-3).sin}!8);2.do{x=FreeVerb2.ar(*x++[0.1,1,1])};x}
play{Splay.ar({|i|f=1.9**i/128;BPF.ar(PinkNoise.ar(1!2),4**LFNoise2.kr(1.2**i/16)*300,0.15)*(5**LFNoise2.ar(f)/(i+8)*20)}!15)}
play{x=Saw.ar([50,50.1]);8.do{|i|f=2**(8-i);x=BRF.ar(AllpassN.ar(x,1,0.1/(12-i),2),80**TRand.ar(0,1,Impulse.ar(f/32,1/2)).lag(1/f)*80,2)};x}
p=Impulse;play{mean({|i|Pluck.ar(LFSaw.ar([102,101]),x=p.ar(1,i/10)+p.ar(0),1,1/Latch.ar(1.015**Sweep.ar(0,1)*64%1+1*200,x),4,0.2)}!10)}
p=SCImage(n=300);n.do{|i|n.do{|j|z=c=Complex(i-240,j-150)/n*2.5;{(r=rho(z=z*z+c)/8)>1&&{z=0}}!200;p.setColor(Color.hsv(r,1,1),i,j)}};p.plot
x=Ndef(\x,Pbind(\freq,Pseq(a=(3..5);a/.x a*.x[40,80],8)));Ndef(\,{Limiter ar:GVerb.ar(PitchShift.ar(Ndef ar:\,1,2,0,0.1),30,9)/4+x.ar}).play
x=Ndef(\x,Pbind(\freq,Pseq(a=(3..5);a*.x a*.x[4,8],8)));Ndef(\,{Limiter ar:GVerb.ar(PitchShift.ar(Ndef ar:\,1,2,0,0.1),20,20)/4+x.ar}).play
play{GVerb.ar(LFTri.ar(Duty.ar(Dseq([3,1]/12,inf),0,Dseq(x=(3..6);allTuples(x/.t x).flat*[100,200,400]++0))),25,5)/5} // #supercollider
play{GVerb.ar(Saw.ar(Duty.ar(1/8,0,Dseq(x=[5,2,9,3];1/(flat(allTuples(x/.t x).reject(any(_,{|i|i%1==0}))/.-1 x)%1)*30++0))),165,5)/5}
play{GVerb.ar(Saw.ar(Duty.ar(1/8,0,Dseq(x=[5,2,[9,7],3];1/(flat(allTuples(x/.t x).reject(any(_,{|i|i%1==0}))/.-1 x)%1)*30++0))),165,1)/5}
play{GVerb.ar(Pulse.ar(Duty.ar(1/8,0,Dseq(x=[5,2,7,3];1/flat(allTuples(x/.t x).reject(any(_,{|i|i%1==0}))%1)*.x[1,3,2,6]*40++0))),165,7)/5}
t={|u,d,a|u.ar(Duty.ar(d/5,0,Dseq(a++0))*300)};play{t.(Saw,1,x=[6,5,9,8];flat(y=allTuples(x/.t x)[(127..1)+[0,127]]%1))+t.(LFTri,4,y*2)!2/6}
play{GVerb.ar(VarSaw.ar(Duty.ar(1/5,0,Dseq(x=[[4,4.5],[2,3,5,6]];flat(x*.x allTuples(x*.x x)*4).clump(2)++0)),0,0.9)*LFPulse.ar(5),99,5)/5}
f=0;{inf.do{|i|f=f+log2(2*i%6+1+floor(f)/(i%5+1))%2;play{SyncSaw.ar(2**f*99+[0,1],i%8+2*52)*Line.kr(0.1,0,1,1,0,2)};0.3.wait}}.r.play



by Tim Walters

play{GVerb.ar(({|k|({|i|x=Impulse.kr(0.5**i/k);y=SinOsc;y.ar(i,y.ar(i+k**i)/Decay.kr(x,[i,i+1],k))}!6).sum}!16).sum,1)/512}//#supercollider
play{({|k|({|i|y=SinOsc;y.ar(i*k*k,y.ar(i*k**i/[4,5])*Decay.kr(Dust.kr(1/4**i),y.ar(0.1)+1*k+i,k*999))}!8).product}!16).sum}//#supercollider
play{({|k|x={|f,m,j|SinOsc.ar(f+(m*4*j),m,LFNoise1.ar(j+1/f*4)/2)};y=x.(0.1,0,8);9.do({|i|y=x.(i*k*[4,8],y,i)});y}!8).sum/4}//#supercollider
play{({|i|Blip.ar((i+2).sqrt/256,3,[-1,1].wrapAt(i))*Gendy1.ar(6,6,1,Blip.ar(i*i+1*[0.5,0.3],9),i+1*60,i+1*100)}!8).sum/4}//#supercollider


micromoog

// =====================================================================
// SuperCollider code analysis
// Bruno Ruviaro, 2011-06-12
// Original tweet by @micromoog
// http://swiki.hfbk-hamburg.de:8888/MusicTechnology/899
// =====================================================================

play{LFCub.ar(LFSaw.kr(LFPulse.kr(1/4,1/4,1/4)*2+2,1,-20,50))+(WhiteNoise.ar(LFPulse.kr(4,0,LFPulse.kr(1,3/4)/4+0.05))/8)!2}

// =====================================================================
// RIGHT SIDE OF + SIGN
// =====================================================================

// I'll start with the second part of the code, after the 'plus' sign.

// Quick reminder of what an LFPulse output looks like:

{LFPulse.ar(1000)}.plot

// Arguments: LFPulse.kr(freq, iphase, width, mul, add)
// LFPulse is unipolar. It outputs a high value of 1
// and a low value of 0. Default width is 0.5.

LFPulse.kr.signalRange     // tells us it's unipolar

{LFPulse.kr(1).poll}.play  // 0's and 1's, half a second each (1Hz)

// Listen to a LFPulse turning on and off some white noise.
// Frequency is 1 Hz, so one noise burst per second (quarter notes in a 4/4 bar).
// Notice that we actually have half a second of noise, and half second of silence.
// This is because the default "width" of LFPulse is 1/2.

{WhiteNoise.ar(LFPulse.kr(1))}.play

// By controlling the width parameter we can then control the note duration.
// The examples below are still 1 Hz ("quarter notes"), but the actual durations are different:

{WhiteNoise.ar(LFPulse.kr(freq: 1, width: 1/10))}.play // note dur is 1/10 of the beat (very "staccato")
{WhiteNoise.ar(LFPulse.kr(freq: 1, width: 0.9))}.play // note dur is 9/10 of the beat ("non legato")

// Now let's make this white noise pulsate 4 times per beat ("sixteenth notes")

{WhiteNoise.ar(LFPulse.kr(4))}.play              // standard staccato (width default = 0.5)
{WhiteNoise.ar(LFPulse.kr(4, width: 0.05))}.play // much more staccato, "hi-hat"

// What if we wanted to have one of the white noise bursts to simulate a snare drum?
// 1 out of every 4 would have to be longer. The width parameter has to change accordingly.
// We can use another LFPulse to do just that.

{LFPulse.kr(1, mul: 1/4, add: 0.05).poll(2, label: "out")}.play // outputs 0.05 and 0.3 for half a second each

// Plug the line above into the white noise:

{WhiteNoise.ar(LFPulse.kr(4, width: LFPulse.kr(1, mul: 1/4, add: 0.05)))}.play

// The beginning was a little off, so we adjust the iphase of inner LFPulse:

{WhiteNoise.ar(LFPulse.kr(4, width: LFPulse.kr(1, iphase: 3/4, mul: 1/4, add: 0.05)))}.play

/*
   Note: I still haven't figured out why this works like this. If LFPulse is sending out
   its min and max values (0.05 and 0.3) at equal intervals (0.5 seconds each), shouldn't
   we hear two short notes and two long notes?
*/

// Moving on... abbreviate the code above to make it "twitter friendly".
// Note that '0' is added as the iphase of first LFPulse in order to
// avoid having to declare the keyword 'width' afterwards, saving several characters...
// Also, the original code divides the whole thing by 8 to scale its global amplitude in the mix.

{WhiteNoise.ar(LFPulse.kr(4,0,LFPulse.kr(1,3/4)/4+0.05))/8}.play

// =====================================================================
// LEFT SIDE OF + SIGN
// =====================================================================

// Original tweet:

play{LFCub.ar(LFSaw.kr(LFPulse.kr(1/4,1/4,1/4)*2+2,1,-20,50))+(WhiteNoise.ar(LFPulse.kr(4,0,LFPulse.kr(1,3/4)/4+0.05))/8)!2}

// Let's look at the inner LFPulse.kr(1/4, 1/4, 1/4)*2+2
// This inner LFPulse is scaled to output numbers between 2 and 4.
// With freq = 1/4 and width = 1/4, the result is one pulse
// every 4 seconds, the duration of which will be 1 second.
// In other words: go to (and stay at) high value 4 for 1 second;
// then go back to (and stay at) low value 2 for 3 seconds.
// The iphase of 1/4 simply shifts the starting point.

{(LFPulse.kr(freq: 1/4, width: 1/4)*2+2).poll(1)}.play // 4 2 2 2 4 2 2 2 ...

{(LFPulse.kr(freq: 1/4, iphase: 1/4,  width: 1/4)*2+2).poll(1)}.play // 2 2 2 4 2 2 2 4 ...

{(LFPulse.kr(1/4,1/4,1/4)*2+2).poll(1)}.play // same thing without keywords

// The LFPulse above (2 2 2 4...) controls the frequency of a LFSaw, i.e.,
// we will have 2 full cycles of a sawtooth wave on every second for 3s,
// then 4 full cycles of the sawtooth wave in one second. In musical terms,
// the first three beats of a 4/4 bar are subdivided in eighth notes,
// while the fourth and last beat is subdivided in sixteenth notes.

// A typical LFSaw looks like this:

{LFSaw.ar(500)}.plot // sudden drops from +1 to -1, followed by upward ramps

// But if we multiply it by a negative number, we invert it:

{LFSaw.ar(500, mul: -1)}.plot // sudden upward leaps from -1 to +1, followed by downward ramps

// In the original tweet, the range of this LFSaw is scaled.
// With mul = -20 & add = 50 the range becomes 30 (min) to 70 (max).
// Since mul is negative, we have downward ramps from 70 to 30.
// These ramps happen at the frequency specified by the the LFPulse (2 2 2 4...)

{LFSaw.kr(freq: LFPulse.kr(1/4,1/4,1/4)*2+2, iphase: 1, mul: -20, add: 50).poll}.play

// Finally, the LFSaw above controls the frequency of a LFCub.
// LFCub is more or less like a sine wave, with a slightly different timbre.
// Thus we have a bass line glissando downwards from 70 Hz to 30 Hz;
// The rhythm of the bass line is the 2 2 2 4 pattern.

{LFCub.ar(LFSaw.kr(LFPulse.kr(1/4,1/4,1/4)*2+2,1,-20,50))}.play

// Compare how the same thing sounds using a SinOsc instead:

{SinOsc.ar(LFSaw.kr(LFPulse.kr(1/4,1/4,1/4)*2+2,1,-20,50))}.play

// PS. If you can't hear the low notes on your laptop built-in speakers,
// try using good headphones or external speakers.

// =====================================================================
// MIXING THE TWO PARTS TOGETHER
// =====================================================================

// Here's the first and second half of the code, still isolated:

{LFCub.ar(LFSaw.kr(LFPulse.kr(1/4,1/4,1/4)*2+2,1,-20,50))}.play

{WhiteNoise.ar(LFPulse.kr(4,0,LFPulse.kr(1,3/4)/4+0.05))/8}.play

// A simple '+' mixes them together:

{LFCub.ar(LFSaw.kr(LFPulse.kr(1/4,1/4,1/4)*2+2,1,-20,50)) + (WhiteNoise.ar(LFPulse.kr(4,0,LFPulse.kr(1,3/4)/4+0.05))/8)}.play

// Note that the WhiteNoise has been enclosed in parentheses
// to force its division by 8 to happen *before* the sum.

// Listen to it without parentheses (white noise becomes too loud in the mix):

{LFCub.ar(LFSaw.kr(LFPulse.kr(1/4,1/4,1/4)*2+2,1,-20,50)) + WhiteNoise.ar(LFPulse.kr(4,0,LFPulse.kr(1,3/4)/4+0.05))/8}.play

// Now add a !2 at the end of the line to make it stereo...

{LFCub.ar(LFSaw.kr(LFPulse.kr(1/4,1/4,1/4)*2+2,1,-20,50)) + (WhiteNoise.ar(LFPulse.kr(4,0,LFPulse.kr(1,3/4)/4+0.05))/8)!2}.play

// Finally, to save ONE more character, put the 'play' in the beginning:

play{LFCub.ar(LFSaw.kr(LFPulse.kr(1/4,1/4,1/4)*2+2,1,-20,50))+(WhiteNoise.ar(LFPulse.kr(4,0,LFPulse.kr(1,3/4)/4+0.05))/8)}

// Done!

// Outstanding unanswered question: how come the inner LFPulse of WhiteNoise.ar produces THREE short notes
// and ONE longer note? Why is it not two short and two long? (even with the phase change...)

headcube 1

// =====================================================================
// Bruno Ruviaro, 2011-07-01
// SuperCollider code analysis
// =====================================================================

// Original tweet by Nathaniel Virgo (headcube)
// http://swiki.hfbk-hamburg.de:8888/MusicTechnology/899

{LocalOut.ar(a=CombN.ar(BPF.ar(LocalIn.ar(2)*7.5+Saw.ar([32,33],0.2),2**LFNoise0.kr(4/3,4)*300,0.1).distort,2,2,40));a}.play


// ********************************************************
// FIRST PART: INSIDE THE BPF
// ********************************************************

// Starting from the BPF, a bandpass filter.
// Below is a simple BPF filtering white noise.
// BPF.ar(in, freq, rq) --> input, center frequency, rq
// This example uses a fixed center frequency of 1000 Hz and a rq of 0.1:

{BPF.ar(WhiteNoise.ar(1), 1000, 0.01)}.play

// Now instead of a fixed center frequency, let's use a
// LFNoise0 to generate new center frequencies for the BPF.
// The LFNoise0 will output a new value between 500 and 5000
// twice per second in this example:

{BPF.ar(WhiteNoise.ar(1), LFNoise0.kr(2).range(500, 5000), 0.1)}.play

// Same thing as above, but now using 'poll' so we
// can see the new freqs values being generated:

{BPF.ar(WhiteNoise.ar(1), LFNoise0.kr(2).range(500, 5000).poll(2, label: "bpf-freq"), 0.1)}.play

// Same thing but now using single impulses (Impulse.ar)
// as the input of the BPF, instead of WhiteNoise. We use the *5
// at the end just to make it louder (too soft otherwise). Listen:

{BPF.ar(Impulse.ar(2), LFNoise0.kr(2).range(500, 5000).poll(2, label: "bpf-freq"), 0.1)*5}.play // filtered impulses

// Now let's step back for a moment. Compare the sound
// of a single impulse to that of a slow sawtooth wave:

{Impulse.ar(1)}.play    // hear it
{Impulse.ar(1000)}.plot // see it
{Saw.ar(1)}.play        // hear it (you hear the dip of the sawtooth from +1 to -1)
{Saw.ar(1000)}.plot   // see it

// Let's use a 1 Hz sawtooth wave as the sound input for the BPF filter.
// These filtered 'saw pops' have a very different timbre from
// the filtered impulse pops created earlier with Impulse.ar:

{BPF.ar(Saw.ar(4), LFNoise0.kr(4).range(500, 5000).poll(4, label: "bpf-freq"), 0.1)}.play // "saw pops" BPF
// compare to
{BPF.ar(Impulse.ar(4), LFNoise0.kr(4).range(500, 5000).poll(4, label: "bpf-freq"), 0.1)*5}.play // "impulse pops" BPF

// Getting a bit closer to the original tweet...
// Let's have get the Saw.ar at 32 and 33 Hz:

{Saw.ar(33)}.play // the raw saw, mono [CAREFUL: LOUD!]
{BPF.ar(Saw.ar(33), LFNoise0.kr(2).range(500, 5000).poll(2, label: "bpf-freq"), 0.1)}.play // raw saw thru BPF

{Saw.ar([32, 33])}.play // two raw saws, stereo [CAREFUL: LOUD!]
{BPF.ar(Saw.ar([32, 33]), LFNoise0.kr(2).range(500, 5000).poll(2, label: "bpf-freq"), 0.1)}.play // raw saws thru BPF

// Now let's say we want the BPF frequencies to be
// in the range 18.75 Hz to 4800 Hz, which is the
// range of the original tweet (more on that later):

{BPF.ar(Saw.ar([32, 33]), LFNoise0.kr(2).range(18.75, 4800).poll(2, label: "bpf-freq"), 0.1)}.play

// Note that whenever the output of LFNoise0 produces a big leap from a very low to a
// very high number (center frequency for BPF), there's a loud "pop" as a consequence.
// These are the interesting "accented notes" we often hear in the final result.
// Watch the Post window as you listen, and check when the louder pops happen.

// One more step closer to the original tweet:
// Let's make the LFNoise0 freq to be 4/3, that is,
// 4 new values every 3 seconds (note that we change
// the poll frequency accordingly):

{BPF.ar(Saw.ar([32, 33]), LFNoise0.kr(4/3).range(18.75, 4800).poll(4/3, label: "bpf-freq"), 0.1)}.play

/* What does this mean? If you think of this rhythm in a Tempo of quarter note = 60,
   which will be the case in the final result, you have something like this
   (imagine these are representations of 16th notes):

>  >   >   >
|||| |||| ||||

   In other words: the frequency of change of the BPF center-freqs (4/3 Hz)
   actually promotes a certain "syncopated" feel of the final result, especially
   when the louder pops appear (created by the occasional sudden change from a very low
   to a very high BPF center-freq)
*/

// Now take a look at how the scaling of the output of LFNoise0
// is actually accomplished in the original tweet. The author does
// NOT use .range(18.75, 4800). Instead we see this:

2**LFNoise0.kr(4/3,4)*300 // output range is 18.75 to 4800 Hz

// With 4 as the "mul", the range of this LFNoise0 becomes -4 to + 4.
// "2 to the power of (-4 up to + 4), and this result multiplied by 300"

2**(-4)*300 // Evaluate this: if LFNoise0 outputs its lowest -4, result is 18.75
2**(0)*300  // Evaluate this: if LFNoise0 outputs its middle value 0, the result is 300
2**(4)*300  // Evaluate this: if LFNoise0 outputs its highest +4, result is 4800

// So, in fact, the range boundaries are the same as in our earlier examples
// using .range(18.75, 4800), but, unlike before, the distribution is NOT linear.
// Compare how often you see numbers below 300 appearing in these two examples:

{LFNoise0.kr(4/3).range(18.75, 4800).poll(4/3, label: "linear")}.play  // Watch the Post window
{(2**LFNoise0.kr(4/3,4)*300).poll(4/3, label: "exponential")}.play     // Watch the Post window

// You can see from the math above that, in the second case, the distribution
// of random values is not anymore linear. Basically, there's 50% of chance that
// the selected value will be BELOW 300; and 50% of chance that it will be above 300.
// In other words, lower center-freqs for the BPF are now being favored.

// This is how the linear distribution sounds like with the rest of our code so far:

{BPF.ar(Saw.ar([32, 33]), LFNoise0.kr(4/3).range(18.75, 4800).poll(4/3, label: "bpf-freq"), 0.1)}.play

// And this is how the exponential one sounds like:

{BPF.ar(Saw.ar([32,33]),(2**LFNoise0.kr(4/3,4)*300).poll(2, label: "bpf-freq"),0.1)}.play

// The exponential one not only favors lower notes in general, but also
// increases the likelihood of louder pops to appear (leaps from
// very low to very high center-freq). That's probably why the original tweet
// uses a multiplier of 0.2 for the Saw:

{BPF.ar(Saw.ar([32,33],0.2),(2**LFNoise0.kr(4/3,4)*300).poll(4/3, label: "bpf-freq"),0.1)}.play

// Finally, a 'distort' method is added to this to smooth things out a bit:

{BPF.ar(Saw.ar([32,33],0.2),(2**LFNoise0.kr(4/3,4)*300).poll(4/3, label: "bpf-freq"),0.1).distort}.scope

// A few visual examples of what distort does:

{LFSaw.ar(300)}.plot          // sawtooth
{LFSaw.ar(300).distort}.plot  // sawtooth with distort

{SinOsc.ar(300)}.plot          // sine
{SinOsc.ar(300).distort}.plot  // sine with distort

{LFTri.ar(300)}.plot          // triangle
{LFTri.ar(300).distort}.plot  // triangle with distort


// Back to the tweet, inside the BPF. Here's the original tweet again:

{LocalOut.ar(a=CombN.ar(BPF.ar(LocalIn.ar(2)*7.5+Saw.ar([32,33],0.2),2**LFNoise0.kr(4/3,4)*300,0.1).distort,2,2,40));a}.play

// There is still this LocalIn.ar(2)*7.5+ in the code,
// preceding the Saw, and which we have not analyzed yet.
// Forget about it for now. Let's look at the the CombN,
// which has the entire BPF code as its first argument.


// ********************************************************
// SECOND PART: CombN
// ********************************************************

// This is a comb delay line.
// CombN.ar(in, maxdelaytime, delaytime, decaytime, mul, add)
// Simple example with Impulses:

{CombN.ar(Impulse.ar(1/2), 2, 0.25, 3)}.play

// Input signal: one impulse every 2 seconds (1/2 Hz)
// Maximum delay time: 2 seconds
// Delay time: 0.25 seconds
// Decay time: 3

// You can hear the 'echoing' impulse fading out.
// Now let's plug that BPF code into a CombN:

{CombN.ar(
	BPF.ar(Saw.ar([32,33],0.2),(2**LFNoise0.kr(4/3,4)*300),0.1).distort, // input signal
	2, // max delay time
	0.25, // delay time
	3) // decay time
}.play

// Same thing, with longer decay time (10s), and delay of 1 second:

{CombN.ar(
	BPF.ar(Saw.ar([32,33],0.2),(2**LFNoise0.kr(4/3,4)*300),0.1).distort, // input signal
	2, // max delay time
	1, // delay time
	10) // decay time
}.play

// Now with the actual values used in the original tweet,
// that is, very long decay time (40s) and delay = 2 seconds

{CombN.ar(
	BPF.ar(Saw.ar([32,33],0.2),(2**LFNoise0.kr(4/3,4)*300),0.1).distort, // input signal
	2, // max delay time
	2, // delay time
	40) // decay time
}.play

// Because the delay is now 2 seconds, we hear it more as 'meter'
// rathern than 'echo'. The result is a kind of 2-beat metric structure
// (say, a 2/4 with quarter note = 60), which gradually gets filled
// with "sixteenth notes" (the 4:3 pattern of the LFNoise0)
// as the CombN accumulates decaying echoes of these attacks.

// Remember the earlier example with a linear distribution of the
// random numbers between 18.75 and 4800? If we use THAT one now,
// a lot LESS pops (attacks) are generated, and the whole thing is
// much less rhythmic as a result. The exponential distribution
// of random numbers is then directly relevant to the
// effectiveness of the final rhythmic result. Here's how
// this same bit of code sounds with the linear distribution:

{CombN.ar(
	BPF.ar(Saw.ar([32,33],0.2),LFNoise0.kr(4/3).range(18.75, 4800),0.1).distort, // input signal
	2, // max delay time
	2, // delay time
	40) // decay time
}.play

//  Another variation below. A version with white noise instead of the
//  sawtooth reveals an interesting aspect about the sawtooth:

{CombN.ar(
	BPF.ar(WhiteNoise.ar([1,1]),(2**LFNoise0.kr(4/3,4)*300),0.1).distort, // input signal
	2, // max delay time
	2, // delay time
	40) // decay time
}.play

// We still get occasional "rhythmic" pops; but note that the distance
// in amplitude between the pops and the 'sustained' portions of
// the texture is smaller; the continuous white noise
// competes for the foreground with the pops. In the original Saw
// version, the dynamic distance between 'explosive' pops and the
// continuous notes is much bigger, so that the pops (thus the rhythm)
// becomes clearly the foreground within an overall 'quieter' texture.

// Here's another version, back with Saw, but with a more limited
// range of center freqs for the BPF. The attacks (pops) disappear, since
// there are no more big leaps from low to high center-freqs. A more continuous
// texture becomes prevalent, but you can still hear the underlying rhythm:

{CombN.ar(
	BPF.ar(Saw.ar([32,33],0.2),LFNoise0.kr(4/3).range(500, 1500),0.1).distort, // input signal
	2, // max delay time
	2, // delay time
	40) // decay time
}.play


// ********************************************************
// THIRD PART: LocalIn and LocalOut
// ********************************************************

// LocalIn.ar and LocalOut.ar are internal buses (see help file).
// In the example below, we feed one impulse every 3 seconds
// into this local bus. LocalIn is inside LocalOut, thus a feedback
// is created. The impulse is repeated every 64 samples (block size),
// each time multiplied by 0.99 (so it fades out quickly).

{LocalOut.ar(a=LocalIn.ar(1)+Impulse.ar(1/3)*0.99);a}.play

// Assuming the current sampling rate (sr) is 44100, we can find out the
// frequency of this "note" by dividing sr by 64 (block size):

44100/64  // result is 689.0625 Hz if your sr = 44100

// Check it with a sine wave, they should sound the same pitch:

{SinOsc.ar(44100/64, mul: 0.5)}.play // freq = sampling rate / block size

{LocalOut.ar(a=LocalIn.ar(1)+Impulse.ar(1/3)*0.99);a}.play // freq = sampling rate / block size

// With a delay line we can hear a gradual accumulation
// of impulses. One impulse is generate every 1 second, and
// mixed (+) with the ones played before. Because there is
// an extra delay of 64 samples "built-in" due to the use of
// LocalIn & LocalOut, the successive impulses do not pile up
// in a simultaneous attack; instead they are gradually
// juxtaposed one after the other, 64 samples apart each time.
// This builds up as a repeated note (689 Hz) of increasing length:

{LocalOut.ar(a=DelayN.ar(LocalIn.ar(1)+Impulse.ar(1),1,1));a}.play // thanks to Nathaniel for this example

// The variable 'a' above works like in the simpler example below.
// There are two statements separated by a semicolon:

{a=SinOsc.ar(440);a}.play

// Finally, this is how the original tweet
// uses the LocalIn LocalOut structure:

{LocalOut.ar(a=CombN.ar(BPF.ar(LocalIn.ar(2)*7.5+Saw.ar([32,33],0.2),2**LFNoise0.kr(4/3,4)*300,0.1).distort,2,2,40));a}.play

// The variable 'a' is the CombN code we analyzed earlier:

{CombN.ar(BPF.ar(Saw.ar([32,33],0.2),2**LFNoise0.kr(4/3,4)*300,0.1).distort,2,2,40)}.play

As of 2011-07-01, I was not sure what's the exact role of the LocalIn / LocalOut structure in this example, nor why LocalIn.ar(2) is multiplied by 7.5. I contacted Nathaniel Virgo (the author of the original tweet) and he kindly sent me an explanation which I reproduce below.

// =====================================================================
// Extra explanation by Nathaniel Virgo, 2011-07-02
// =====================================================================

{LocalOut.ar(a=LocalIn.ar(1)+Impulse.ar(1/3));a}.play
// This rings at 689 Hz

// But we can make it into a much longer echo by adding a delay.
// This never decays away:

{LocalOut.ar(a=DelayN.ar(LocalIn.ar(1)+Impulse.ar(4/3),2,2));a}.play

// So we multiply the feedback signal by 0.75
// to get something more like a syncopated echo:

{LocalOut.ar(a=DelayN.ar(LocalIn.ar(1)*0.75+Impulse.ar(4/3),2,2));a}.play

// Now if we apply an effect (e.g. a BPF) we can hear it being applied
// again each time the sound passes through the delay line (I've changed
// the timings to make it easier to hear what's happening):

{LocalOut.ar(a=DelayN.ar(BPF.ar(LocalIn.ar(1)*0.75+Impulse.ar(1/2),8000,0.2),0.5,0.5));a}.play

// We can add in some of the 'dry' signal to the delay line by
// changing the DelayN to a CombN. (However, by doing it this way, the
// feedback signal gets an additional delay of 64 samples that the dry
// signal doesn't get, which is why this example builds up a nasty ringing
// sound after a while.)

{LocalOut.ar(a=CombN.ar(BPF.ar(LocalIn.ar(1)*0.75+Impulse.ar(4/3),8000,0.1),2,2,40));a}.play

// So let's modulate the BPF and add some distortion, which
// also gets applied on each pass through the feedback loop:

{LocalOut.ar(a=CombN.ar(BPF.ar(LocalIn.ar(1)*0.75+Impulse.ar(4/3),2**LFNoise0.kr(4/3,4)*300,0.1).distort,2,2,40));a}.play

// (Note that 2**LFNoise0.kr(4/3,4)*300 is equivalent to
// LFNoise0.kr(4/3).exprange(18.75, 4800), but it takes up less space)

// Compare the above to this one without the LocalOut & LocalIn (*)
// [(*) Note: I added this line to Nathaniel's explanation. BTR]

{CombN.ar(BPF.ar(Impulse.ar(4/3),2**LFNoise0.kr(4/3,4)*300,0.1).distort,2,2,40)}.play

// Now all that's left is to replace the impulse by a stereo Saw to
// get the original tweet. The distortion stops it from becoming too
// loud and occasionally adds some nice dirty sounds.

{LocalOut.ar(a=CombN.ar(BPF.ar(LocalIn.ar(2)*7.5+Saw.ar([32,33],0.2),2**LFNoise0.kr(4/3,4)*300,0.1).distort,2,2,40));a}.play

This tweet was also discussed in the sc-users list. You can read more about it here:

http://comments.gmane.org/gmane.comp.audio.supercollider.user/75493

Below I quote an explanation by Wouter Snoei posted on 2011-07-16, answering a question about the LocalIn being multiplied by 7.5:

"Indeed, which means an increase in level of about 18 dB. Normally that will cause most signals to go out of the -1.0 to 1.0 range. Here as well. That is no problem as long as you don't feed it directly to your outputs. SC can handle out-of-range signals to an almost infinite range internally because it works with floating point numbers. In the bandpass line the magic happens. The signal is filtered with a bandwidth of 0.1, basically reducing it's level again by apx 25db (depending on the cutoff frequency and the material in the loop). This is the reason why there is no build up in the feedback loop; the level earlier multiplied is now lowered again, and becomes apx -7dB. Sometimes a specific frequency gets amplified and the level increases, but because the LFNoise0 changes the bandpass frequency every ~1.33s this never happens for too long." [Wouter Snoei]

// This is the tweet rewritten in a longer, more "readable" way:
{LocalOut.ar(
  a = CombN.ar(
	  in: BPF.ar(in: LocalIn.ar(2)*7.5 + Saw.ar([32,33], 0.2), // BPF in
		     freq: LFNoise0.kr(4/3).exprange(18.75, 4800), // BPF freq
		     rq: 0.1				           // BPF rq
		    ).distort,					   // distort BPF
	  maxdelaytime:	2,	// CombN max delay time
	  delaytime: 2,		// CombN delay time
	  decaytime: 40)	// CombN decay time
	    ); // end of LocalOut parentheses
  a; // last thing to be returned, ie., it gets played
}.play

headcube 2

// =====================================================================
// SuperCollider code analysis
// Bruno Ruviaro, 2011-10-23
// Original tweet by Nathaniel Virgo (headcube)
// http://twitter.com/#!/headcube
// =====================================================================

play{GVerb.ar(VarSaw.ar(Duty.ar(1/5,0,Dseq(a=[[4,4.5],[2,3,5,6]];flat(a*.x allTuples(a*.x a)*4).clump(2)++0)),0,0.9)*LFPulse.ar(5),99,5)/5}

// Variable Duty Saw (freq, iphase, width, mul):

plot{VarSaw.ar(440, 0, 0.0)}; // width 0.0
plot{VarSaw.ar(440, 0, 0.5)}; // width 0.5
plot{VarSaw.ar(440, 0, 1.0)}; // width 1.0

// Change width with mouse up and down, hear the results:

play{VarSaw.ar(440, 0, MouseY.kr(0, 1), 0.2)};

// The tweet uses VarSaw with iphase=0 and width=0.9:

play{VarSaw.ar(440,0,0.9)};

// The 'freq' parameter of VarSaw in this tweet is the
// UGen Duty.ar with lots of stuff inside.

// Take a look at a simple case of Duty at control rate (Duty.kr):

{Duty.kr(1/8, 0, SinOsc.kr(3)).poll}.play // Duty parameters: dur, reset, level

// What happens above? Every 1/8 of a second (dur=1/8), Duty "demands" a value from
// the SinOsc UGen that is the "level" parameter (level=SinOSc.kr(3)). SinOsc outputs
// numbers between -1 and +1. The second parameter ("reset") would reset all values
// upon its triggering, but it's not really used in the example (reset=0).

// We could use this construction to control for example the frequency of any oscillator.
// Here's an example spelling out each parameter with keywords:

(
play{VarSaw.ar(
	freq: Duty.ar(1/8, 0, SinOsc.ar(3).range(440, 550)), // scaled SinOsc output
	iphase: 0,
	width: 0.9,
    	mul: 0.3)};
)

// Duty acts as a "sample and hold" in this case.
// Change Duty's "dur" value from 1/8 to, say, 1/30 to hear
// a better defined contour of the sine wave being sampled.

// Of course we can write the same thing in one simplified line such as:

play{VarSaw.ar(Duty.ar(1/8,0,SinOsc.ar(3).range(440,550)),0,0.9,0.3)};

// You can save a few more characters by rewriting the "range" method
// using SinOsc's own "mul" and "add" parameters...

play{VarSaw.ar(Duty.ar(1/8,0,SinOsc.ar(3,0,55,495)),0,0.9,0.3)};

// Moving closer to the original tweet: the "level" parameter of Duty
// is not a SinOsc UGen, but rather a Dseq. A Dseq simply holds an array of values
// (or an array of other UGens), and a "length" specifying the number of repeats.

d = Dseq([256, 144, 128, 72, 162, 450], 3); // (array, length)

// Below is a simple example. Dseq holds a bunch of numbers that will be
// fed into a SinOsc as frequencies, one at a time. The sequence repeats 4 times.
// The "dur" parameter of Duty (dur=1/5) specifies that a new value will be
// demanded from Dseq every 1/5 of a second. We inspect the variable 'freq'
// with poll just to watch the results in the Post window.

(
{
var a, freq;
a = Dseq([256, 144, 128, 72, 162, 450], 4);
freq = Duty.kr(1/5, 0, a);
freq.poll;
SinOsc.ar(freq) * 0.1
}.play;
)

// Here's a concise example of this construction within a VarSaw oscillator.
// Duty picks a number from the Dseq list every 0.2 s; sequence repeats 4 times:

play{VarSaw.ar(Duty.ar(1/5,0,Dseq([256, 144, 128, 72, 162, 450], 4)),0,0.9,0.3)};

// Don't like legato? Try staccato:

play{VarSaw.ar(Duty.ar(1/5,0,Dseq([256, 144, 128, 72, 162, 450], 4)),0,0.9,0.3)*LFPulse.ar(5)};

// LFPulse: For each pulse, it simply goes from zero to one abruptly, and back to zero.
// By default it stays half of the time on 1, and other half on 0. See for yourself:

plot{LFPulse.ar(1000)};

// Using 5 as the frequency of the LFPulse (5 pulses per second) ensures that we will be
// at the same rate as the notes coming out from Dseq (one every 1/5 of a second).
// Thus, LFPulse is providing an amplitude envelope for each new note: first half of the
// note is ON (*1), second half is OFF (*0). Staccato.

// Because the LFPulse envelope is abrupt, we get the audible clicks that are
// part of the interesting texture of the original tweet. Listen to it again,
// and play around with the LFPulse frequency to see what happens (try 10, for example):

play{VarSaw.ar(Duty.ar(1/5,0,Dseq([256, 144, 128, 72, 162, 450], 4)),0,0.9,0.3)*LFPulse.ar(5)};

// Maybe it's time to add some reverb?

play{GVerb.ar(VarSaw.ar(Duty.ar(1/5,0,Dseq([256, 144, 128, 72, 162, 450], 4)),0,0.9)*LFPulse.ar(5),99,5)/5};

// 99 is room size, 5 is reverb time; these are the GVerb values used in the original tweet.
// The "divide by five" at the end is also used to scale down amplitude (note that the original
// tweet does not use a "mul" value for VarSaw).

// Compare the construction above with the original tweet:

play{GVerb.ar(VarSaw.ar(Duty.ar(1/5,0,Dseq(a=[[4,4.5],[2,3,5,6]];flat(a*.x allTuples(a*.x a)*4).clump(2)++0)),0,0.9)*LFPulse.ar(5),99,5)/5}

// The only thing left to decipher is the code inside the Dseq.
// The frequencies I have been "arbitrarily" using in the examples above
// [256, 144, 128, 72, 162, 450] make the sequence sound a bit the like the
// original harmonic texture of the tweet, but that's cheating.

// How is the stuff inside Dseq providing all the notes we hear in the original tweet?

Dseq(a=[[4,4.5],[2,3,5,6]];flat(a*.x allTuples(a*.x a)*4).clump(2)++0) // (no need to evaluate this)

// Break this down in two lines:

a=[[4,4.5],[2,3,5,6]]; // evaluate this first
flat(a *.x allTuples(a *.x a) * 4).clump(2)++0 // then evaluate this & see result

// We see that the result is a big array of smaller arrays,
// with two frequency values inside each smaller array. Something like this:

//[ [ 256, 144 ], [ 128, 72 ], [ 256, 144 ], [ 128, 162 ], [ 256, 144 ], [ 128, 450 ], [ 256, 144 ], [ 128, 648 ], [ 256, 144 ], [ 216, 72 ], [ 256, 144 ], ...etc....

// Let's try a portion of this array with one of
// the simpler Dseq examples we saw earlier:

(
{
var a, freq;
a = Dseq([[256,144], [128,72], [256,144], [128,162], [256,144], [128,450], [256,144], [128,648], [256,144], [216,72]], 4);
freq = Duty.kr(1, 0, a); // slower rate of 1 per second, so we can listen more closely
VarSaw.ar(freq) * 0.1
}.play;
)

/*
SuperCollider's multichannel expansion is in action here. VarSaw receives as "freq" not a single number, but an array like [256, 144]. Thus, the two frequencies are generated, one going to the left channel, the other being sent to the right channel. The Dseq does not contain a list of single notes; it is a list of intervals (two notes sounding together). When played in fast sequence, and thanks to the proximity of certain notes of this sequence, we hear a kind of polyphonic texture going on (multiple voices evolving seemingly independently). This phenomenon is called "stream segregation" -- check out Bregman's book "Auditory Scene Analysis" http://webpages.mcgill.ca/staff/Group2/abregm1/web/downloadstoc.htm#01 and, while we are at it, here's Bach's Cello Suite 1... http://www.youtube.com/watch?v=LU_QR_FTt3E
*/

// In the code example above, try changing Duty's "dur" parameter to 1/5,
// which is the actual speed of the original tweet: stream segregation becomes
// more clear (especially frequencies 450 and 648 forming the "upper voice").

// Finally, let's go back and see how exactly the big array of arrays is generated inside Dseq:


a=[[4,4.5],[2,3,5,6]];
flat(a *.x allTuples(a *.x a) * 4).clump(2)++0;

// "flat" simply flattens an array (removes internal brackets):

[1, 2, [3, 4, 5], 6, 7].flat

// "clump" regroups elements of an array:

[1, 2, 3, 4, 5, 6, 7].clump(2)

// "++" concatenates something to the end of an array:

[1, 2, 3, 4, 5, 6, 7] ++ 0;

// "allTuples" returns a new Array whose elements contain all possible combinations of the receiver's subcollections.

[[1, 2, 3, 4, 5], [10, 20, 30]].allTuples;
[[1, 2, 3, 4, 5], [10, 20, 30], [5, 6]].allTuples;

// The trickiest thing here is probably the *.x operator. This is called an operator with an adverb.
// The operator is the regular multiplication sign; the adverb is the letter 'x' preceded by a dot '.'
// The adverb slightly modifies the behavior of the normal operator.
// Here's a normal multiplication of two arrays:

[1, 2, 3, 4, 5] * [10, 11, 12] // evaluate and see the result

// A new array is created which is the length of the longer array;
// Items from each array are multiplied one by one in sequence, wrapping
// around the shorter array until all items from longer array have been multiplied.

// Now this is what happens when we use the adverb .x to modify
// the behavior of the array multiplication:

[1, 2, 3, 4, 5] *.x [10, 11, 12] // evaluate and see the result

// Result: all items of first array are multiplied by first item
// of second array; then all items of first array are multiplied
// by second item of second array; and so on. All products are
// then collected in a single flat list.
// [a,b,c] *.x [d,e,f] = [ad,bd,cd,ae,be,ce,af,bf,cf]

// For more info on adverbs, look up "Adverbs for Binary Operators" in the documentation.

a=[[4,4.5],[2,3,5,6]];
flat(a *.x allTuples(a *.x a) * 4)

// Breaking down the code above:

a *.x a; // that is, [ [4,4.5], [2,3,5,6] ] *.x  [ [4,4.5], [2,3,5,6] ]

allTuples(a *.x a); // all combinations of previous result

a *.x allTuples(a *.x a); // 'a' * previous result

a *.x allTuples(a *.x a) * 4; // previous result * 4

flat(a *.x allTuples(a *.x a) * 4); // flatten previous result

flat(a *.x allTuples(a *.x a) * 4).clump(2); // regroup in pairs

flat(a *.x allTuples(a *.x a) * 4).clump(2)++0; // add a zero to the very end (otherwise last note pair would keep repeating)

// OK, that's it. We arrived at the final form of this tweet:

play{GVerb.ar(VarSaw.ar(Duty.ar(1/5,0,Dseq(a=[[4,4.5],[2,3,5,6]];flat(a*.x allTuples(a*.x a)*4).clump(2)++0)),0,0.9)*LFPulse.ar(5),99,5)/5}



/*

In fact, the original tweet was slightly different. Instead of using the letter "a" for the variable inside Dseq, it actually used the letter "x". Intentionally or not, this was a potential source of confusion, since the "x" meaning the variable could be mixed up with the "x" meaning the adverb for the binary operator. So for this analysis I rewrote the tweet simply using the letter "a" as the variable instead of the letter "x"... here's how the real original looked like:

play{GVerb.ar(VarSaw.ar(Duty.ar(1/5,0,Dseq(x=[[4,4.5],[2,3,5,6]];flat(x*.x allTuples(x*.x x)*4).clump(2))),0,0.9)*LFPulse.ar(5),99,5)/5}

*/





)
mathk

// Original tweet by mathk
// http://swiki.hfbk-hamburg.de:8888/MusicTechnology/899

{k=LFNoise1.kr(8.0.rand+2,0.5,0.5);SinOsc.ar([[333,444],[222,555]]*(k+(rrand(1.0,5.0))),0,k).sum.cubed * 0.1}.play
// #supercollider #babies

mutantsounds

// Original tweet by mutantsounds
// http://swiki.hfbk-hamburg.de:8888/MusicTechnology/899

{x=Array.fill(5,{[0.00001,0.03].asSpec.map(LFNoise2.kr(3))});Splay.ar(Friction.ar(LFTri.ar(50),friction:x,mass:x*30000))}.play

//END OF sctweets2.scd
//END OF sctweets2.scd
//END OF sctweets2.scd

//START OF sillyVoice
//START OF sillyVoice
//START OF sillyVoice
(
SynthDef("sillyVoice", { arg
	freq = 220,
	amp = 0.5,
	vibratoSpeed = 6,
	vibratoDepth = 4,
	vowel = 0,
	att = 0.01,
	rel = 0.1,
	lag = 1,
	gate = 1;

	var in, vibrato, env, va, ve, vi, vo, vu, snd;

	vibrato = SinOsc.kr(vibratoSpeed, mul: vibratoDepth);
	in = Saw.ar(Lag.kr(freq, lag) + vibrato);
	env = EnvGen.kr(Env.asr(att, 1, rel), gate, doneAction: 2);

	va = BBandPass.ar(
		in: in,
		freq: [ 600, 1040, 2250, 2450, 2750 ],
		bw: [ 0.1, 0.067307692307692, 0.048888888888889, 0.048979591836735, 0.047272727272727 ],
		mul: [ 1, 0.44668359215096, 0.35481338923358, 0.35481338923358, 0.1 ]);

	ve = BBandPass.ar(
		in: in,
		freq: [ 400, 1620, 2400, 2800, 3100 ] ,
		bw: [ 0.1, 0.049382716049383, 0.041666666666667, 0.042857142857143, 0.038709677419355 ],
		mul: [ 1, 0.25118864315096, 0.35481338923358, 0.25118864315096, 0.12589254117942 ]);

	vi = BBandPass.ar(
		in: in,
		freq: [ 250, 1750, 2600, 3050, 3340 ] ,
		bw: [ 0.24, 0.051428571428571, 0.038461538461538, 0.039344262295082, 0.035928143712575 ],
		mul: [ 1, 0.031622776601684, 0.15848931924611, 0.079432823472428, 0.03981071705535 ] );

	vo = BBandPass.ar(
		in: in,
		freq:[ 400, 750, 2400, 2600, 2900 ] ,
		bw: [ 0.1, 0.10666666666667, 0.041666666666667, 0.046153846153846, 0.041379310344828 ],
		mul: [ 1, 0.28183829312645, 0.089125093813375, 0.1, 0.01 ]);

	vu = BBandPass.ar(
		in: in,
		freq: [ 350, 600, 2400, 2675, 2950 ],
		bw: [ 0.11428571428571, 0.13333333333333, 0.041666666666667, 0.044859813084112, 0.040677966101695 ],
		mul: [ 1, 0.1, 0.025118864315096, 0.03981071705535, 0.015848931924611 ]);

	snd = SelectX.ar(Lag.kr(vowel, lag), [va, ve, vi, vo, vu]);
	snd = Mix.new(snd);
	Out.ar(0, snd!2 * env * amp);
}).add;
)

Synth("sillyVoice");
//END OF sillyVoicE
//END OF sillyVoicE
//END OF sillyVoicE

//START OF \sinarpegg1
//START OF \sinarpegg1
//START OF \sinarpegg1
(
SynthDef(\sinarpegg1, {arg freq=440, amp=0.1,attack=0.01, sustain=0.1, decay=0.01,pan=0.0;
var source, filter, env;

source= SinOsc.ar(EnvGen.kr(Env([1,2,3,4,5,6]*freq,(0.2*attack).dup(5))));

filter= CombN.ar(source*EnvGen.kr(Env([1,1,0],[attack,0.01])),0.025,0.025,5);

env= EnvGen.kr(Env([0,0,1,1,0],[attack, 0.01,sustain, decay]), doneAction:2);

Out.ar(0,PanAz.ar(numChannels,filter*env*0.5*amp,pan))
}).send(s);
)


Synth(\sinarpegg1);
//END OF \sinarpegg1
//END OF \sinarpegg1
//END OF \sinarpegg1

//START OF \singleoscillatorwobble
//START OF \singleoscillatorwobble
//START OF \singleoscillatorwobble
//vibrato on oscillator
(
SynthDef(\singleoscillatorwobble,{|out= 0 freq = 440 amp = 1.0 gate=1 lforate = 10 lfowidth= 0.5 cutoff= 12000 rq=0.5 pan=0.0|

	var lfo, pulse, filter, env;

	lfo = LFTri.kr(lforate,Rand(0,2.0)!2);

	pulse = Pulse.ar(freq*(1.0+(lfowidth*lfo)),0.5);

	filter = RLPF.ar(pulse,cutoff,rq);

	env = EnvGen.ar(Env.adsr(0.01,0.0,1.0,0.5),gate,doneAction:2);

	Out.ar(out,Pan2.ar(filter*env*amp*0.5,pan));

}).add;


SynthDef(\choruseffect, {|out =0 gate= 1|
	var source = In.ar(out,2);
	var chorus;
	var env = Linen.kr(gate, 0.1, 1, 0.1, 2);

	chorus= Mix.fill(7, {

		var maxdelaytime= rrand(0.005,0.02);

		DelayC.ar(source, maxdelaytime,LFNoise1.kr(Rand(4.5,10.5),0.25*maxdelaytime,0.75*maxdelaytime) )

	});

	XOut.ar(out,env, chorus);

}).add;

)



(
Pmono(
	\singleoscillatorwobble,
	\midinote,Pseq([0,3,8,7,5,8,7,3]+48,inf),
	\dur,Pseq((0.5!8) ++ (1.0!8) ++ (2.0!8),inf),
	\lfowidth,Pn(Pseries(0.0,0.01,7),inf),
	\lforate,Pn(Pseries(2,1,11),inf),
	\rq,Pn(Pseries(0.9,-0.1,5),inf)
).play
)


(
var p =
Pbind(
	\instrument, \singleoscillatorwobble,
	\tempo,2,
	\midinote,Pseq([0,3,8,7,5,8,7,3]+36,24),
	\dur,Pseq((0.5!8) ++ (1.0!8) ++ (2.0!8),1),
	\lfowidth,Pn(Pseries(0.0,0.01,7),4),
	\lforate,Pn(Pseries(2,1,11),3),
	\rq,Pn(Pseries(0.9,-0.1,5),6)
);


Pseq([p,Pfx(p,\choruseffect)],inf).play
)



//trying it on its own
a = Synth(\singleoscillatorwobble);
a.release




//END OF \singleoscillatorwobble
//END OF \singleoscillatorwobble
//END OF \singleoscillatorwobble

//START OF  \situationsynth
//START OF  \situationsynth
//START OF  \situationsynth
(

SynthDef(\situationsynth,{|out= 0 freq = 440 amp = 0.1 gate=1 cutoff=8000 rq=0.8 lfowidth=0.001 lforate= 3.3 pan=(-0.1)|

	var pulse, filter, env, filterenv, lfo;

	lfo = LFTri.kr(lforate,Rand(0,2.0)!2);

	pulse = Mix(Pulse.ar((((freq.cpsmidi)+[0,0.14])+(lfo*lfowidth)).midicps,[0.5,0.51]+(lfowidth*lfo)))*0.5;

	filterenv = EnvGen.ar(Env([0.0,1.0,0.3,0.0],[0.005,0.57,0.1],-3));

	filter =  RLPF.ar(pulse,100+(filterenv*cutoff),rq);

	env = EnvGen.ar(Env.adsr(0.002,0.57,1.0,0.3),gate,doneAction:2);

	Out.ar(out,Pan2.ar(filter*env*amp,pan));

}).add;


SynthDef(\yazoodelayeffect, {|out =0 gate= 1 pan= 0.1|
	var source = In.ar(out,2);
	var delay;
	var env = Linen.kr(gate, 0.0, 1, 0.1, 2);

	delay= DelayC.ar(source[0].distort,0.25,0.25);

	Out.ar(out,Pan2.ar(delay*env,pan));

}).add;

)


//says original tempo 118, we'll keep 120 for note as it's so close.

//Pmono allows use of the lag between setting frequency values
(
Pfx(
	Pbind(
		\instrument,\situationsynth,
		\midinote,Pseq([1,1,13,1,-1,-1,-1,11,8,11,13,1,1,13,1,-1,-1,11,16,15,11,13]+60,inf),	\dur,Pseq([0.5,0.5,0.5,0.25,0.5,0.5,0.25,0.25,0.25,0.25,0.25,0.5,0.5,0.5,0.25,0.5,0.5,0.25,0.25,0.25,0.25,0.25],inf),
		\lfowidth,0.2,
		\cutoff,6000,
		\rq,0.6,
		\pan,-0.1,
		\amp,0.3
	),
	\yazoodelayeffect
).play
)
//END OF \situationsynth
//END OF \situationsynth
//END OF \situationsynth

//START OF \solo
//START OF \solo
//START OF \solo
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
//END OF \solo
//END OF \solo
//END OF \solo

//START OF someextraDEFS.scd
//START OF someextraDEFS.scd
//START OF someextraDEFS.scd

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

//END OF someextraDEFS.scd
//END OF someextraDEFS.scd
//END OF someextraDEFS.scd

//START OF \spacetheremin
//START OF \spacetheremin
//START OF \spacetheremin
(

SynthDef(\spacetheremin,{|out= 0 freq = 440 amp = 0.1 gate=1 lforate = 6 lfowidth= 0.5 cutoff= 4000 rq=0.25 lagTime=0.1 pan=0.0|

	var lfo, osc, filter, env;

	lfo = LFTri.kr(lforate+(LFNoise1.kr(5,0.3,0.3)),Rand(0,2.0));

	osc = Saw.ar((freq.lag(lagTime).cpsmidi+(lfo*lfowidth)).midicps,0.5);

	filter = BLowPass4.ar(osc,cutoff.lag(lagTime*4),rq);

	env = EnvGen.ar(Env.adsr(0.6,0.0,1.0,0.05),gate,doneAction:2);

	Out.ar(out,Pan2.ar(filter*env*amp.lag(lagTime*4),pan));

}).add;


SynthDef(\spacereverb,{|out =0 gate= 1 threshold= 0.1 amp=0.1|

	var a,c,z,y,in;
	var env = Linen.kr(gate, 0.1, 1, 0.1, 2);

	c = 6; // number of comb delays
	a = 4; // number of allpass delays

	in=In.ar(out,2);

	// reverb predelay:
	z = DelayN.ar(in, 0.048,0.048);

	y=Mix.arFill(c,{CombL.ar(z,0.1,rrand(0.01, 0.1),5)});

	// chain of 4 allpass delays on each of two channels (8 total) :
	a.do({ y = AllpassN.ar(y, 0.051, [rrand(0.01, 0.05),rrand(0.01, 0.05)], 1) });

	Out.ar(out,Pan2.ar(y,0)*env*amp);

}).add;

)



(
Pfx(
	Pmono(
		\spacetheremin,
		\amp,Prand([0.4,0.45,0.5,0.55,0.5],inf),
		\midinote,Prand([0,2,3,5,6,8,9,11]+60,inf), //octotonic
		\dur,Prand([1.0,1.5,0.5,0.75,1.25,2.0,0.57],inf),
		\lagTime,Pstutter(7,Pn(Pseries(0.05,0.05,8),inf)),
		\lfoRate,Pstutter(9,Pn(Pseries(6,0.5,5),inf)),
		\cutoff,Pstutter(11,Prand([1000,1500,2000,3000],inf))
	),
	\spacereverb
).play
)




//END OF \spacetheremin
//END OF \spacetheremin
//END OF \spacetheremin

//START OF \spookystrings
//START OF \spookystrings
//START OF \spookystrings

(

SynthDef(\spookystrings,{|out= 0 freq = 440 amp = 0.1 gate=1 cutoff=8000 rq=0.2 lfowidth=0.01 lforate=3.8 pan=0.0|

	var pulse, filter, env, lfo;

	lfo = LFTri.kr(lforate,Rand(0,2.0)!2);

	//LFO only on second oscillator
	pulse = Mix(Saw.ar(freq*[1,1.001]*[1.0,1.0+(lfowidth*lfo)]))*0.5;

	filter = BHiPass.ar(pulse,cutoff,rq);

	env = EnvGen.ar(Env.adsr(0.1,0.0,1.0,3),gate,doneAction:2);

	Out.ar(out,Pan2.ar(filter*env*amp,pan));

}).add;

SynthDef(\spookyeffect, {|out =0 gate= 1 delaytime=0.25 phaserate=0.1|
	var source = In.ar(out,2);
	var delay,phaser;

	var env = Linen.kr(gate, 0.0, 1, 0.1, 2);

	delay= DelayN.ar(source,0.8,delaytime);

	phaser = delay;
	//phaser = AllpassN.ar(delay,0.04,SinOsc.kr(phaserate,0,0.005,0.035)); //not working that well, too obvious, need to make more subtle

	Out.ar(out,phaser);

}).add;

SynthDef(\spookystrings2,{|out= 0 freq = 440 amp = 0.1 gate=1 cutoff=8000 rq=0.2 pan=0.0|

	var saw, pulse, filter, env, lfo, pulsewidthlfo;

	lfo = LFTri.kr([3.5,5],Rand(0,2.0)!2);

	pulsewidthlfo = SinOsc.kr(4.5);

	saw = Saw.ar(freq*(1.0+(0.052*lfo[0])));

	pulse = Pulse.ar(freq*(1.0+(0.072*lfo[1])),pulsewidthlfo*0.25+0.5);

	//combine, equal mix
	pulse = 0.5*(saw+pulse);

	//filter specification not the clearest, so just going for slow attack to brightness
	filter = BLowPass.ar(pulse,XLine.kr(678,cutoff,0.378),rq);

	env = EnvGen.ar(Env.adsr(0.1,0.0,1.0,3),gate,doneAction:2);

	Out.ar(out,Pan2.ar(filter*env*amp,pan));

}).add;

)

(
Pfx(
	Pbind(
		\instrument, \spookystrings,
		\midinote,Pseq([69,67,62,59,55],inf),
		\dur,Pseq([9.5,1.5,1.0,1.5,2.5],inf),
		\amp,0.2,
		\lfowidth,0.04,
		\cutoff,1000,
		\rq,0.1
	),
	\spookyeffect
).play
)


(
Pfx(
	Pbind(
		\instrument,\spookystrings2,
		\midinote,Pseq([69,67,62,59,55],inf),
		\dur,Pseq([5.5,1.5,1.0,1.5,2.5],inf),
		\amp,0.2,
		\cutoff,10000,
		\rq,0.5
	),
	\spookyeffect
).play
)


//END OF \spookystrings
//END OF \spookystrings
//END OF \spookystrings

//START OF \string
//START OF \string
//START OF \string
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
//END OF \string
//END OF \string
//END OF \string

//START OF \synchronicity
//START OF \synchronicity
//START OF \synchronicity
(

SynthDef(\synchronicity,{|out= 0 freq = 440 amp = 0.1 gate=1 cutoff=8000 rq=0.2 pan=0.0|

	var pulse, filter, env, slavefreq;

	slavefreq = EnvGen.ar(Env([1,5,1],[0.04,0.9]))*freq;

	pulse = SyncSaw.ar(freq,slavefreq);

	filter = BLowPass.ar(pulse,cutoff,rq);

	env = EnvGen.ar(Env.adsr(0.01,0.0,1.0,0.1),gate,doneAction:2);

	Out.ar(out,Pan2.ar(filter*env*amp,pan));

}).add;

)


(
Pbind(
	\instrument,\synchronicity,
	\midinote,Pseq([57,59,62,62,61,59,57],inf),
	\dur,Pseq([1.0,1.0,2.0,1.0,0.5,1.0,1.5],inf),
	\amp,0.2,
	\cutoff,7000,
	\rq,1.0
).play
)
//END OF \synchronicity
//END OF \synchronicity
//END OF \synchronicity

//START OF \tonewheeltwo
//START OF \tonewheeltwo
//START OF \tonewheeltwo
(
SynthDef(\tonewheeltwo,{|out= 0 freq = 440 amp = 0.1 gate=1 lforate = 4.85 lfowidth= 0.1 cutoff= 5000 rq=0.25 pan = 0.0|

	var lfo, pulse, filter, env;

	lfo = LFTri.kr(lforate*[1,1.01],Rand(0,2.0)!2);

	pulse = Pulse.ar( (((freq*[1,3]).cpsmidi) + (lfo*lfowidth)).midicps,[0.5,0.51],[0.4,0.6]);

	env = EnvGen.ar(Env.adsr(0.0,0.0,1.0,0.1),gate,doneAction:2);

	filter = BLowPass4.ar(pulse,cutoff,rq);

	filter= BPeakEQ.ar(filter,500,1.0,3);

	Out.ar(out,Pan2.ar(Mix(filter)*env*amp,pan));

}).add
)


(
Pbind(
	\instrument,\tonewheeltwo,
	\midinote,Prand([48,50,52,60,64,67,58,72],inf),
	\dur,0.5,
	\rq,Pstutter(6,Pn(Pseries(0.75,-0.1,6),inf)),
	\lfowidth,Pstutter(7,Pn(Pseries(0.0,0.05,10),inf)),
	\cutoff,Pstutter(8,Pn(Pseries(2000,1000,4),inf))
).play
)
//END OF \tonewheeltwo
//END OF \tonewheeltwo
//END OF \tonewheeltwo

//START OF trianglewavebells
//START OF trianglewavebells
//START OF trianglewavebells
/*
Mitchell Sigman (2011) Steal this Sound. Milwaukee, WI: Hal Leonard Books
pp. 10-11

Adapted for SuperCollider and elaborated by Nick Collins
http://www.sussex.ac.uk/Users/nc81/index.html
under GNU GPL 3 as per SuperCollider license

Minor modifications by Bruno Ruviaro, June 2015.
*/
(
SynthDef("trianglewavebells",{
	arg out = 0, pan = 0.0, freq = 440, amp = 1.0, gate = 1, att = 0.01, dec = 0.1, sus = 1, rel = 0.5, lforate = 10, lfowidth = 0.0, cutoff = 100, rq = 0.5;

	var osc1, osc2, vibrato, filter, env;
	vibrato = SinOsc.ar(lforate, Rand(0, 2.0));
	osc1 = Saw.ar(freq * (1.0 + (lfowidth * vibrato)), 0.75);
	osc2 = Mix(LFTri.ar((freq.cpsmidi + [11.9, 12.1]).midicps));
	filter = RHPF.ar((osc1 + (osc2 * 0.5)) * 0.5, cutoff, rq);
	env = EnvGen.ar(
		envelope: Env.adsr(att, dec, sus, rel, amp),
		gate: gate,
		doneAction: 2);
	Out.ar(out, Pan2.ar(filter * env, pan));
}).add;


	Pbind(
		\instrument, "trianglewavebells",
		\amp, Pwhite(0.1, 0.15),
		\legato, 1.1,
		\note, Pseq([0, 7, 3, 0, 8, 7, 8, 5, 7, 12, 5, 3, 12, 7, 15, [-19, -7], [-12, -5, 0, 3, 7]], inf),
		\dur, Pwrand([0.6, 1.2], [0.9, 0.1], inf),
		\lfowidth, Pn(Pseries(0.0, 0.005, 16), inf),
		\lforate, Pn(Pseries(1, 0.5, 16), inf),
		\rq, Pn(Pseries(0.9, -0.01, 16),inf),
		\cutoff, Pn(Pseries(60, 20, 16),inf)
	).play;
)
//END OF trianglewavebells
//END OF trianglewavebells
//END OF trianglewavebells

//START OF \voicform
//START OF \voicform
//START OF \voicform
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
//END OF \voicform
//END OF \voicform
//END OF \voicform

//START OF werkit
//START OF werkit
//START OF werkit
s/*
Mitchell Sigman (2011) Steal this Sound. Milwaukee, WI: Hal Leonard Books
pp. 14-15

Adapted for SuperCollider and elaborated by Nick Collins
http://www.sussex.ac.uk/Users/nc81/index.html
under GNU GPL 3 as per SuperCollider license

Minor modifications by Bruno Ruviaro, June 2015.
*/
(
SynthDef("werkit", {
	arg out = 0, pan = 0.0, freq = 440, amp = 0.1, gate = 1, cutoff = 100, rq = 0.1, att = 0.01, dec = 0, sus = 1, rel = 1, delay = 0.3;

	var source, filter, env, snd, delayEnv;
	source = WhiteNoise.ar;
	filter = BLowPass4.ar(source, freq, rq) * 0.3;
	env = EnvGen.ar(
		envelope: Env.adsr(att, dec, sus, rel, amp),
		gate: gate,
		doneAction: 2);
	snd = (0.7 * filter + (0.3 * filter.distort)) * env;
	Out.ar(out, Pan2.ar(snd, pan));
}).add;


	Pbind(
		\instrument, "werkit",
		\amp, Pwhite(0.05, 0.1),
		\note, Pseq([-1, 1, -1, 1, 3, 6, 9, 11, 12, 15, 17, 18, 19, 20, 23, 26], inf),
		\dur, 0.25,
		\rq, Pwhite(0.005, 0.01)
	).play;
)
//END OF werkit
//END OF werkit
//END OF werkit

//START OF werkit2
//START OF werkit2
//START OF werkit2
/*
Mitchell Sigman (2011) Steal this Sound. Milwaukee, WI: Hal Leonard Books
pp. 14-15

Adapted for SuperCollider and elaborated by Nick Collins
http://www.sussex.ac.uk/Users/nc81/index.html
under GNU GPL 3 as per SuperCollider license

Minor modifications by Bruno Ruviaro, June 2015.
*/

SynthDef("werkit2", {
	arg out = 0, freq = 440, amp = 0.1, gate = 1, cutoff = 100, rq = 0.1, att = 0.01, dec = 0, sus = 1, rel = 0.1;

	var source, filter, env, snd;
	source = LFSaw.ar(Array.fill(16, { Rand(100, 200) }));
	filter = BLowPass4.ar(source, freq, rq) * 0.1;
	env = EnvGen.ar(
		envelope: Env.adsr(att, dec, sus, rel, amp),
		gate: gate,
		doneAction: 2);
	snd = (0.7 * filter + (0.3 * filter.distort)) * env;
	snd = HPF.ar(snd, 100);
	snd = Splay.ar(snd);
	Out.ar(out, snd);
}).add;


loadRelative("utilities.scd");

~addSynthDemo.value("werkit2",
	Pbind(
		\instrument, "werkit2",
		\amp, Pwhite(0.05, 0.1),
		\note, Pseq([-1, 1, -1, 1, 3, 6, 9, 11, 12, 15, 17, 18, 19, 20, 23, 26], inf),
		\dur, 0.25,
		\att, Pn(Pgeom(0.01, 1.1, 16), inf),
		\rel, Pn(Pgeom(0.02, 1.35, 16), inf),
		\rq, Pwhite(0.005, 0.02)
	);
)
//END OF werkit2
//END OF werkit2
//END OF werkit2

//START OF \whoorgan
//START OF \whoorgan
//START OF \whoorgan
(

SynthDef(\whoorgan,{|out= 0 freq = 440 amp = 0.1 gate=1 cutoff=8000 rq=0.8 pan=(-0.1)|

	var osc, filter, env;
	var basefreq =  ((freq.cpsmidi)+[0,0.1]).midicps;

	//osc = Mix(Blip.ar(basefreq,16))*0.5;

  	osc = Mix.fill(10,{|i| SinOsc.ar(basefreq*(i+1),0.0,(0.25+(0.75*LFNoise0.kr(10.1+i,0.5,0.5)))/(1.0+(0.5*i)))})*0.2;

	filter =  BLowPass.ar(osc,2000+(amp*cutoff),rq);

	env = EnvGen.ar(Env.adsr(0.02,0.1,0.9,1.0),gate,doneAction:2);

	Out.ar(out,Pan2.ar(Mix(filter)*env*amp,pan));

}).add;


SynthDef(\filtereffect, {|out =0 gate= 1|
	var source = In.ar(out,2);
	var env = Linen.kr(gate, 0.0, 1, 0.1, 2);
	var output;

	output = BLowPass.ar(BLowPass.ar(source,SinOsc.ar(0.25,0,5000,5500),0.4),(200+(5000*SinOsc.ar(4.01,0.5,0.5,0.5))),0.6);

	//output = BLowPass.ar(source,SinOsc.ar(0.275,0,5000,5500),0.1);

	XOut.ar(out,env,output*env);

}).add;

)


(
Pfx(
	Pbind(
		\instrument,\whoorgan,
		\midinote,Pseq([7,5,4,0]+60,inf),
		\dur,0.5,
		\amp,Pstutter(8,Pn(Pseries(0.3,0.05,8),inf)),
		\cutoff,8000
	),
	\filtereffect
).play
)
//END OF \whoorgan
//END OF \whoorgan
//END OF \whoorgan

//START OF \winwoodlead
//START OF \winwoodlead
//START OF \winwoodlead
(

SynthDef(\winwoodlead,{|out= 0 freq = 440 amp = 0.1 gate=1 cutoff=8000 rq=0.8 lfowidth=0.01 lforate= 8 lagamount=0.01 pan=0.0|

	var pulse, filter, env, lfo;

	lfo = LFTri.kr(lforate,Rand(0,2.0)!2);

	pulse = Mix(Pulse.ar((freq.lag(lagamount))*[1,1.001]*(1.0+(lfowidth*lfo)),[0.2,0.19]))*0.5;

	filter =  RLPF.ar(pulse,cutoff,rq);

	//remove low end
	filter = BLowShelf.ar(filter,351,1.0,-9);

	env = EnvGen.ar(Env.adsr(0.01,0.0,0.9,0.05),gate,doneAction:2);

	Out.ar(out,Pan2.ar(filter*env*amp,pan));

}).add;

)



//Pmono allows use of the lag between setting frequency values
(
Pmono(
	\winwoodlead,
	\midinote,Pseq([Pshuf([60,76,77,76,74,72],2)],inf),
	\dur,Pseq([0.5,1.0,0.5,0.5,0.5,1.0],inf),
	\amp,Pseq([0,1,1,1,1,1],inf),
	\lagamount,0.1,
	\lfowidth,Pstutter(6,Pseq([0.0,0.01,0.02,0.03,0.05,0.1],inf)),
	\cutoff,Pstutter(6,Pn(Pgeom(2000,1.5,5),inf))
).play
)
//END OF \winwoodlead
//END OF \winwoodlead
//END OF \winwoodlead

//START OF clap_oto309
//START OF clap_oto309
//START OF clap_oto309
(
SynthDef("clap_oto309", {
	arg out=0, amp = 0.1, pan=0;
	var env1, env2, son, noise1, noise2;

	env1 = EnvGen.ar(Env.new([0, 1, 0, 1, 0, 1, 0, 1, 0], [0.001, 0.013, 0, 0.01, 0, 0.01, 0, 0.03], [0, -3, 0, -3, 0, -3, 0, -4]));
	env2 = EnvGen.ar(Env.new([0, 1, 0], [0.02, 0.3], [0, -4]), doneAction:2);

	noise1 = WhiteNoise.ar(env1);
	noise1 = HPF.ar(noise1, 600);
	noise1 = BPF.ar(noise1, 2000, 3);

	noise2 = WhiteNoise.ar(env2);
	noise2 = HPF.ar(noise2, 1000);
	noise2 = BPF.ar(noise2, 1200, 0.7, 0.7);

	son = noise1 + noise2;
	son = son * 2;
	son = son.softclip * amp;

	Out.ar(out, Pan2.ar(son, pan));
},
metadata: (
	credit: "from 08091500Acid309 by_otophilia",
	tags: [\clap, \percussion]
	)
).add;
)


Synth("clap_oto309");
//END OF  clap_oto309
//END OF  clap_oto309
//END OF  clap_oto309

//START OF closedhat
//START OF closedhat
//START OF closedhat
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
//END OF closedhat
//END OF closedhat
//END OF closedhat

//START OF \cymbal808_ryan
//START OF \cymbal808_ryan
//START OF \cymbal808_ryan
(SynthDef(\cymbal808_ryan, {
	arg out=0, baseFreq = 300, time = 250, amp=0.1;
	//var freqs = [baseFreq, baseFreq*1.3420, baseFreq*1.2312, baseFreq*1.6532, baseFreq*1.9523, baseFreq*2.1523];
	//var freqs = [78.6, 140.44, 123.87, 219.4, 787.5, 531.3];
	//var freqs = [205.35, 254.29, 294.03, 304.41, 369.64, 522.71];
	var freqs = [205.35, 304.41, 369.64, 522.71, 540.54, 812.21];
	var signal, pulseEnv;

	pulseEnv = EnvGen.ar(Env.new([1.0, 0.6], [time], [-0.5]), timeScale:(1/1000));
	signal = Mix.new(LFPulse.ar(freqs * 4.09));
	signal = (BinaryOpUGen('==', signal, 6.0) * 0.6) + (BinaryOpUGen('==', signal, 2.0) * 0.2) + (BinaryOpUGen('==', signal, 1.0) * 0.9); // XOR
�� 	signal = (signal * pulseEnv) + (Mix.new(LFPulse.ar(freqs, width:0.55)) * 0.9);
�	signal = RLPF.ar(signal, 7000, 0.6);
� 	signal = RHPF.ar(signal, 6800, 1.5);
�	signal = RHPF.ar(signal, 6800, 1.5);
�	signal = RHPF.ar(signal, 1200, 1.5);
	signal = signal + FreeVerb.ar(signal);
	signal = signal * EnvGen.ar(Env.new([0, 1, 0.4, 0, 0], [2, time, 50, 500], [0, -0.5, 0, -50]), timeScale:(1/1000), doneAction:2);
	signal = [signal, DelayN.ar(signal, 0.005, 0.005)];
	OffsetOut.ar(out, signal*4*amp);
},
metadata: (
	credit: "Published on sc-users 2007-08-25 by Ryan Brown",
	tags: ['808', \hihat, \percussion, \cymbal]
	)
).add;)


Synth(\cymbal808_ryan);

//END OF \cymbal808_ryan
//END OF \cymbal808_ryan
//END OF \cymbal808_ryan

//START OF \cymbalic_mcld
//START OF \cymbalic_mcld
//START OF \cymbalic_mcld
/*
Based on the example at
http://www.mcld.co.uk/cymbalsynthesis/
published 2008 by Dan Stowell

Synth(\cymbalic_mcld)
*/
(SynthDef(\cymbalic_mcld, { |out=0, pan=0, amp=0.1|
	var lodriver, locutoffenv, hidriver, hicutoffenv, freqs, res, thwack;

	locutoffenv = EnvGen.ar(Env.perc(0.5, 5)) * 20000 + 10;
	lodriver = LPF.ar(WhiteNoise.ar(0.1), locutoffenv);

	hicutoffenv = 10001 - (EnvGen.ar(Env.perc(1, 3)) * 10000);
	hidriver = HPF.ar(WhiteNoise.ar(0.1), hicutoffenv);
	hidriver = hidriver * EnvGen.ar(Env.perc(1, 2, 0.25));

	thwack = EnvGen.ar(Env.perc(0.001,0.001,1));

	// This bit will regenerate new freqs every time you evaluate the SynthDef!
	freqs  = {exprand(300, 20000)}.dup(100);

	res    = Ringz.ar(lodriver + hidriver + thwack, freqs).mean;

	Out.ar(out, Pan2.ar(((res * 1) + (lodriver * 2) + thwack) * amp, pan));
},
metadata: (
	credit: "Based on the example at http://www.mcld.co.uk/cymbalsynthesis/ published 2008 by Dan Stowell",
	tags: [\percussion, \cymbal, \gong, \inharmonic, \additive, \subtractive]
	)
).add;
)

Synth(\cymbalic_mcld);
//END OF \cymbalic_mcld
//END OF \cymbalic_mcld
//END OF \cymbalic_mcld

//START OF \drum_kick
//START OF \drum_kick
//START OF \drum_kick
(
SynthDef(\drum_kick, {
	arg freq=440, gate=1, amp=0.5, source,pan = 0.0 ;
	source =
	Pan2.ar(
		SinOsc.ar(EnvGen.kr(Env.perc(0.0001, 1.5, 1, -200), gate, 1000, 45, doneAction:2), 1, 1) +
		((BPF.ar([GrayNoise.ar(6),GrayNoise.ar(6)],EnvGen.kr(Env.perc(0.001, 0.3, 1, -200), gate, 6000, 70), 1.5)).distort * Line.kr(0.3,0,0.1))
		*
		EnvGen.kr(Env.perc(0.0001, 0.09, amp, 8)),0);
	Out.ar(0, source);
}).add;

)

Synth(\drum_kick);
//END OF \drum_kick
//END OF \drum_kick
//END OF \drum_kick

//START OF drumkit1.scd
//START OF drumkit1.scd
//START OF drumkit1.scd
// Basic drum kit

(
SynthDef("hihat", {arg out = 0, amp = 0.5, att = 0.01, rel = 0.2, ffreq = 6000, pan = 0;
	var snd = WhiteNoise.ar(amp);
	var env = Env.perc(att, rel).kr(doneAction: 2);
	snd = HPF.ar(snd * env, ffreq);
	Out.ar(out, Pan2.ar(snd, pan));
}).add;

SynthDef("snare", {arg out = 0, amp = 0.1, sinfreq = 180, att = 0.01, rel = 0.2, ffreq = 2000, pan = 0;
	var snd1 = WhiteNoise.ar(amp);
	var snd2 = SinOsc.ar(sinfreq,0,amp);
	var env = EnvGen.kr(Env.perc(att, rel), doneAction: 2);
	var sum = HPF.ar(snd1 * env, ffreq)+(snd2*env);
	Out.ar(out, Pan2.ar(sum, pan));
}).add;

SynthDef("kick", {arg out = 0, amp = 0.3, sinfreq = 70, glissf = 0.9, att = 0.01, rel = 0.45, pan = 0;
	var gliss = XLine.kr(sinfreq, sinfreq*glissf, rel);
	var snd = SinOsc.ar(gliss);
	var env = EnvGen.kr(Env.perc(att, rel), doneAction: 2);
	snd = snd * env * amp;
	snd = Limiter.ar(snd,1,0.001);
	Out.ar(out, Pan2.ar(snd, pan));
}).add;
)


// Example
(
Ppar([
	Pbind(
		\instrument, "hihat",
		\dur, Pseq([Rest(1/4), 1/4], inf),
		\ffreq, 9000,
		\rel, 0.1,
		\amp, 0.3
	),
	Pbind(
		\instrument, "kick",
		\dur, 1/2,
		\amp, 0.9,
		\rel, 0.12,
		\glissf, 0.99
	),
		Pbind(
		\instrument, "snare",
		\dur, Pseq([Rest(1/2), 1/2], inf),
		\amp, 0.25,
		\rel, 0.1
	)
]).play;
)

//END OF drumkit1.scd
//END OF drumkit1.scd
//END OF drumkit1.scd

//START OF \handclapsmash
//START OF \handclapsmash
//START OF \handclapsmash

(
SynthDef(\handclapsmash,{|out= 0 amp = 0.1 gate=1 cutoff= 12000 rq=0.5 releaseTime=0.5 pan=0.0|

	var noise, filter, filterenv, env;

	noise = WhiteNoise.ar;

	filterenv = EnvGen.ar(Env([0.0,1.0,0.3,0.0],[0.0,0.3,0.3]));
	//this involves a gate control, less use here
	//filterenv = EnvGen.ar(Env.adsr(0.0,0.3,0.3,0.3),gate);

	filter = BHiPass.ar(RLPF.ar(noise,cutoff*filterenv,rq),150);

	//body
	filter = BPeakEQ.ar(filter,440,1.0,8);
	//snap
	filter = BPeakEQ.ar(filter,1200,1.0,14);

	//no gate, fixed percussion sound
	env = EnvGen.ar(Env.perc(0.005,releaseTime),doneAction:2);

	Out.ar(out,Pan2.ar(filter*env*amp,pan));

}).add;


//with dirty attack
SynthDef(\handclapsmash2,{|out= 0 amp = 0.1 gate=1 cutoff= 12000 cutoff2=10000 rq=0.5 modamount=0.0 modrate=50 releaseTime=0.7 pan=0.0|

	var noise, filter, filterenv, modulation, env;

	noise = WhiteNoise.ar;

	filterenv = EnvGen.ar(Env([0.0,1.0,0.3,0.0],[0.0,0.3,0.3]));

	modulation = (LFSaw.ar(modrate).range(0.0,1.0))*EnvGen.ar(Env([1,1,0,0],[0.1,0.0,1.0]));

	//filter = BHiPass.ar(RLPF.ar(noise,cutoff*filterenv*(1.0+(modamount*modulation)),rq),150); //alternative
	filter = BHiPass.ar(RLPF.ar(noise,cutoff*filterenv+ (cutoff2*modamount*modulation),rq),150);

	//body
	filter = BPeakEQ.ar(filter,440,1.0,8);
	//snap
	filter = BPeakEQ.ar(filter,1200,1.0,14);

	//no gate, fixed percussion sound
	env = EnvGen.ar(Env.perc(0.005,releaseTime),doneAction:2);

	//amp modulation too not very effective ((1.0-modamount)+(modamount*modulation))
	Out.ar(out,Pan2.ar(filter*env*amp,pan));

}).add;


)




(
Pbind(
	\instrument,\handclapsmash,
	\dur,0.5,
	\rq,1.0
).play
)



(
Pbind(
	\instrument,\handclapsmash2,
	\dur,0.5,
	\cutoff,Pstutter(2,Pn(Pseries(12000,-1000,11),inf)),
	\cutoff2, Pstutter(3,Pn(Pseries(10000,-1000,9),inf)),
	\rq,1.0,
	\modrate,Pstutter(8,Pn(Pseries(25,5,7),inf)),
	\modamount,Pstutter(4,Pseq([0.1,0.3,0.5,0.6,0.7,0.9],inf)),
	\releaseTime,Pstutter(2,Pn(Pseries(0.8,-0.1,6),inf))
).play
)


//END OF \handclapsmash
//END OF \handclapsmash
//END OF \handclapsmash

//START OF \hat
//START OF \hat
//START OF \hat
(

SynthDef(\hat, { | out=0 |
	var osc1, env;
	osc1 = WhiteNoise.ar;
	env = EnvGen.kr(Env.perc(0, 0.01), doneAction: 2);
	Out.ar(out, Pan2.ar(osc1, 0, env));
}).add;

)


Synth(\hat);
//END OF \hat
//END OF \hat
//END OF \hat

//START OF \kick_chrp
//START OF \kick_chrp
//START OF \kick_chrp
(// a kick made using what radio folks would call a "chirp"
SynthDef(\kick_chrp, { |out=0, amp=0.1, pan=0|

var ampenv, pitchenv;

ampenv   = EnvGen.ar(Env.perc(0, 0.2, curve: 0), doneAction: 2);
pitchenv = EnvGen.ar(Env.perc(0, 0.1, curve: -20).exprange(0, 1000), doneAction: 0);

Out.ar(out, Pan2.ar(SinOsc.ar(pitchenv) * amp, pan))


},
metadata: (
	credit: "by dan stowell. public domain",
	tags: [\kick, \drum, \percussion, \chirp]
	)
).add;
)

Synth(\kick_chrp);
//END OF \kick_chrp
//END OF \kick_chrp
//END OF \kick_chrp

//START OF kick_oto309
//START OF kick_oto309
//START OF kick_oto309
(SynthDef("kick_oto309", {
	arg out=0, amp=0.5, pan=0;
	var env0, env1, env1m, son;

	env0 =  EnvGen.ar(Env.new([0.5, 1, 0.5, 0], [0.005, 0.06, 0.26], [-4, -2, -4]), doneAction:2);
	env1 = EnvGen.ar(Env.new([110, 59, 29], [0.005, 0.29], [-4, -5]));
	env1m = env1.midicps;

	son = LFPulse.ar(env1m, 0, 0.5, 1, -0.5);
	son = son + WhiteNoise.ar(1);
	son = LPF.ar(son, env1m*1.5, env0);
	son = son + SinOsc.ar(env1m, 0.5, env0);

	son = son * 1.2;
	son = son.clip2(1);

	Out.ar(out, Pan2.ar(son * amp));
},
metadata: (
	credit: "from 08091500Acid309 by_otophilia",
	tags: [\kick, \drum, \percussion]
	)
).add;)


Synth("kick_oto309");
//END OF kick_oto309
//END OF kick_oto309
//END OF kick_oto309

//START OF kick3
//START OF kick3
//START OF kick3
(

SynthDef("kick3", {arg punch = 1, amp = 1;
    var freq = EnvGen.kr(Env([400, 66], [0.08], -3)),
	sig = Normalizer.ar(SinOsc.ar(freq, 0.5pi, punch).distort, 1) * amp
            * EnvGen.kr(Env([0, 1, 0.8, 0], [0.01, 0.1, 0.2]), doneAction: 2);
    Out.ar(0, sig ! 2);
}).add;

)

Synth("kick3");
//END OF kick3
//END OF kick3
//END OF kick3

//START OF kick808
//START OF kick808
//START OF kick808

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
//END OF kick808
//END OF kick808
//END OF kick808

//START OF kik
//START OF kik
//START OF kik
(
SynthDef("kik", { |basefreq = 50, ratio = 7, sweeptime = 0.05, preamp = 1, amp = 1, decay1 = 0.3, decay1L = 0.8, decay2 = 0.15, out|
    var fcurve = EnvGen.kr(Env([basefreq * ratio, basefreq], [sweeptime], \exp)),
        env = EnvGen.kr(Env([1, decay1L, 0], [decay1, decay2], -4), doneAction: 2),
        sig = SinOsc.ar(fcurve, 0.5pi, preamp).distort * env * amp;
    Out.ar(out, sig ! 2)
}).add;
)

Synth("kik");
//END OF kik
//END OF kik
//END OF kik

//START OF kraftySnr
//START OF kraftySnr
//START OF kraftySnr
(
SynthDef("kraftySnr", { |amp = 1, freq = 2000, rq = 3, decay = 0.3, pan, out|
	var sig = PinkNoise.ar(amp),
	env = EnvGen.kr(Env.perc(0.01, decay), doneAction: 2);
	sig = BPF.ar(sig, freq, rq, env);
	Out.ar(out, Pan2.ar(sig, pan))
}).add;
)

Synth("kraftySnr");
//END OF kraftySnr
//END OF kraftySnr
//END OF kraftySnr

//START OF \oneclap_thor
//START OF \oneclap_thor
//START OF \oneclap_thor
(SynthDef(\oneclap_thor, {arg out=0, t_trig=1, amp=0.1, filterfreq=1000, rq=0.1, pan=0;
var env, signal, attack,� noise, hpf1, hpf2;
	noise = WhiteNoise.ar(1)+SinOsc.ar([filterfreq/2,filterfreq/2+4 ], pi*0.5, XLine.kr(1,0.01,4));
	noise = PinkNoise.ar(1)+SinOsc.ar([(filterfreq)*XLine.kr(1,0.01,3), (filterfreq+4)*XLine.kr(1,0.01,3) ], pi*0.5, XLine.kr(1,0.01,4));
	//signal = signal * SinOsc.ar(1,0.75);
	hpf1 = RLPF.ar(noise, filterfreq, rq);
	hpf2 = RHPF.ar(noise, filterfreq/2, rq/4);
	env = EnvGen.kr(Env.perc(0.003, 0.00035));
	signal = (hpf1+hpf2) * env;
	signal = CombC.ar(signal, 0.5, 0.03, 0.031)+CombC.ar(signal, 0.5, 0.03016, 0.06);
	//signal = Decay2.ar(signal, 0.5);
	signal = FreeVerb.ar(signal, 0.23, 0.15, 0.2);
	Out.ar(out, Pan2.ar(signal * amp, pan));
	DetectSilence.ar(signal, doneAction:2);
},
metadata: (
	credit: "published on the sc-users list 2009-01-08 by thor",
	tags: [\clap, \handclap]
	)
).add;)


Synth(\oneclap_thor);
//END OF \oneclap_thor
//END OF \oneclap_thor
//END OF \oneclap_thor

//START OF \ping_mh
//START OF \ping_mh
//START OF \ping_mh
(SynthDef(\ping_mh,{arg freq=440,amp=0.2,dur=0.1,attack=0.001,pan=0,out=0;
    var sig,freq2;
    freq=freq*rrand(1,1.01);
    freq2=freq*rrand(1,1.01);
    e=EnvGen.ar(Env.perc(attack,dur,curve:-4),doneAction:2);
    sig=SinOsc.ar([freq,freq2],0,amp*e);
    sig=Pan2.ar(sig,pan);
    Out.ar(out,sig)
},
metadata: (
	credit: "Your basic percussive synth instrument, a good default sound for testing patterns, etc.",
	tags: [\percussive, \ping, \default, \simple, \stereo, \detuned, \tuned]
	)
).add;)



Synth(\ping_mh);
//END OF \ping_mh
//END OF \ping_mh
//END OF \ping_mh

//START OF ringkick
//START OF ringkick
//START OF ringkick
(

SynthDef("ringkick", {arg freq = 40, decay = 0.25, amp = 1;
	var snd;
	snd = Ringz.ar(
		in: LPF.ar(
			in: Impulse.ar(0),
			freq: 1000),
		freq: freq,
		decaytime: decay,
		mul: 7 * amp).tanh.sin*2;
	Out.ar(0, snd!2);
}).add;


)

Synth("ringkick");
//END OF ringkick
//END OF ringkick
//END OF ringkick

//START OF \sd
//START OF \sd
//START OF \sd
(
SynthDef(\sd, { | out=0 |
	var osc1, osc2, env;
	osc1 = WhiteNoise.ar;
	osc2 = FSinOsc.ar(200);
	env = EnvGen.kr(Env.perc(0, 0.05), doneAction: 2);
	Out.ar(out, Pan2.ar(LPF.ar(Mix([osc1, osc2]), 12000), 0, env));
}).add;
)


Synth(\sd);
//END OF \sd
//END OF \sd
//END OF \sd

//START OF snare_oto309
//START OF snare_oto309
//START OF snare_oto309
(SynthDef("snare_oto309", {
	arg out=0, amp=0.1, pan=0;
	var env0, env1, env2, env1m, oscs, noise, son;

	env0 = EnvGen.ar(Env.new([0.5, 1, 0.5, 0], [0.005, 0.03, 0.10], [-4, -2, -4]));
	env1 = EnvGen.ar(Env.new([110, 60, 49], [0.005, 0.1], [-4, -5]));
	env1m = env1.midicps;
	env2 = EnvGen.ar(Env.new([1, 0.4, 0], [0.05, 0.13], [-2, -2]), doneAction:2);

	oscs = LFPulse.ar(env1m, 0, 0.5, 1, -0.5) + LFPulse.ar(env1m * 1.6, 0, 0.5, 0.5, -0.25);
	oscs = LPF.ar(oscs, env1m*1.2, env0);
	oscs = oscs + SinOsc.ar(env1m, 0.8, env0);

	noise = WhiteNoise.ar(0.2);
	noise = HPF.ar(noise, 200, 2);
	noise = BPF.ar(noise, 6900, 0.6, 3) + noise;
	noise = noise * env2;

	son = oscs + noise;
	son = son.clip2(1) * amp;

	Out.ar(out, Pan2.ar(son, pan));
},
metadata: (
	credit: "from 08091500Acid309 by_otophilia",
	tags: [\snare, \drum, \percussion]
	)
).add;)


Synth("snare_oto309");
//END OF snare_oto309
//END OF snare_oto309
//END OF snare_oto309

//START OF \snare_stein
//START OF \snare_stein
//START OF \snare_stein
(SynthDef(\snare_stein, { |out=0, amp=0.1, pan=0|
var snare, filtWhite;

filtWhite = LPF.ar(WhiteNoise.ar(1), 7040, 1);

snare = ((SinOsc.ar(330,0,0.25) * EnvGen.ar(Env.perc(0.0005,0.055)))
� � � � � � � � � � � �+(SinOsc.ar(185,0,0.25) * EnvGen.ar(Env.perc(0.0005,0.075)))
� � � � � � � � � � � �+(filtWhite * EnvGen.ar(Env.perc(0.0005,0.2), doneAction: 2) * 0.2)
� � � � � � � � � � � �+(HPF.ar(filtWhite, 523, 1) * EnvGen.ar(Env.perc(0.0005,0.183)) * 0.2)
� � � � � � � � � � � �);

Out.ar(out, Pan2.ar(snare * amp * 10, pan));

},
metadata: (
	credit: "Snare written by Esben Stein, I believe",
	tags: [\percussion, \drum, \snare]
	)
).add;
)

Synth(\snare_stein);
//END OF \snare_stein
//END OF \snare_stein
//END OF \snare_stein

//START OF \sos_bell
//START OF \sos_bell
//START OF \sos_bell
(
SynthDef(\sos_bell, { |freq=440, out=0, amp=0.1, pan=0|
var son, strike, hum;

// Stretched harmonic series
son = SinOsc.ar(#[2, 3, 4.1, 5.43, 6.8, 8.21] * freq, 0,
		 #[1, 0.9, 0.8, 0.7, 0.6, 0.5] * 0.1);

son = son * EnvGen.ar(Env.new([0,1,0.3, 0.2, 0], [0, 0.3, 0.3, 0.3]));

// A bit of FM adds 'warble'
son = son * LFTri.ar({Rand(1.0, 1.8)}.dup(6), 1, 0.3, 0.7);

// Mix down the partials in the main sound
son = son.mean;

strike = SinOsc.ar(LFNoise1.ar(freq * 36, 100, freq*8), 1, 0.1) *
			EnvGen.ar(Env.new([0,1,0.2, 0.1, 0], [0, 0.01, 0, 0.04]));

hum = SinOsc.ar([freq*1.01, freq*0.47], 0, EnvGen.ar(Env.new([0,0.05,0.05,0], [0.5,0.5,1]), doneAction:2)).mean;

Out.ar(out, Pan2.ar((son + strike + hum) * 4 * amp, pan));


},
metadata: (
	credit: "by dan stowell. based on a sound-on-sound 'synth secrets' tutorial",
	tags: [\bell, \percussion, \pitched, \additive]
	)
).add;)



Synth(\sos_bell);
//END OF \sos_bell
//END OF \sos_bell
//END OF \sos_bell

//START OF GRAINNN EFX
//START OF GRAINNN EFX
//START OF GRAINNN EFX

(
Server.local.waitForBoot({
(
z.free;
z = Buffer.alloc(s, 512, 1);
z.sine1(1.0 / [1, 2, 3, 4], true, true, true);

 fork( { loop {
 SynthDef("g1",{ arg out=0,bufnum=0,dur=1,rate=1,pos=0,sdens=1,edens=1;
     var dens = Line.kr(sdens,edens,dur);
     var trig = [LFNoise0,SinOsc,Impulse,LFPulse,LFSaw].choose.ar(Line.kr(sdens,edens,dur));
     //var env = EnvGen.kr(Env.perc(0.0001.rrand(0.1),dur*0.5.rrand(2)),doneAction:2);
     var env = EnvGen.kr(Env.perc(0.0001.rrand(0.1),dur*(0.5.rrand(4))),doneAction:2);
     Out.ar(out,
         GrainBuf.ar(2,trig,1/dens,bufnum,rate,pos)*env;
         )
     }).add();
  [1,2,4,8,16,32].choose.postln.wait;
 }
 }
 );


a = Pbind(\instrument,\g1,\dur,Pseq([Pseq([0.25],32),Pseq([0.25,0.125,0.125],32),Pseq([0.125],32)],inf),\sdens,Pseq([9000,1000,500]/10,inf),\edens,Prand([Pseq([9000,1000,500]/10,4),Pseq([1],1)],inf),\rate,Pfunc({-10.0.rrand(10)}),\pos,Pfunc({1.0.rand}),\bufnum,z.bufnum);
b = Pbind(\instrument,\g1,\dur,Pseq([4],inf),\sdens,Pseq([9000,1000,500]/100,inf),\edens,Prand([Pseq([9000,1000,500]/10,1),Pseq([1],3)],inf),\rate,Pfunc({-10.0.rrand(10)}),\pos,Pfunc({-10.0.rrand(10)}),\bufnum,z.bufnum);
c = Pbind(\instrument,\g1,\dur,Pseq([4/3],inf),\sdens,Pseq([9000,1000,500,25],inf),\edens,Prand([Pseq([9000,1000,500,25],1),Pseq([1],4)],inf),\rate,Pfunc({-100.0.rrand(100)}),\pos,Pfunc({-10.0.rrand(10)}),\bufnum,z.bufnum);


a =a.play;
b =b.play;
c =c.play;

)
});
)

//END OF GRAIN EFX
//END OF GRAIN EFX
//END OF GRAIN EFX



//START OF KraftWerk SNare
//START OF KraftWerk SNare
//START OF KraftWerk SNare

(
s = Server.default;
s.boot;
)

(
x = SynthDef("more_fun_snare", {

	arg audioOutBus = 0;

	var env_amp, env_pitch;
	var envGen_amp;
	var noise, pulse_cluster, envGen_hihat, out_hihat;
	var sine_noise;
	var flick, envGen_flickPitch, envGen_flickAmp;
	var trig_flick, gapTime_flick;
	var lastFlick, envGen_lastFlickPitch, envGen_lastFlickAmp, lastFlickDelayTime;

	var output;

	env_amp = Env([1.0, 1.0, 0.0], [0.0, 0.8]);
	envGen_amp = EnvGen.ar(env_amp, doneAction: 2);

	noise = BPF.ar(WhiteNoise.ar, 214, 0.1, 0.5);
	noise = noise + BPF.ar(WhiteNoise.ar, 1157, 0.1, 0.5);
	noise = noise + RHPF.ar(WhiteNoise.ar, 3000, 0.1, 0.2) * 0.2;

	pulse_cluster = Mix.fill(6, {
		LFPulse.ar(ExpRand(250, 360), Rand(0, 0.99), Rand(0.3, 0.7));
	});
	pulse_cluster = RHPF.ar(pulse_cluster, 8000, 0.1, 0.2);
	pulse_cluster = LPF.ar(pulse_cluster, 8000);

	envGen_hihat = EnvGen.ar(Env.perc(0.001, 0.85, 0.5, -7));

	sine_noise = SinOsc.ar(1131 + BrownNoise.ar.range(-90, 90)) * 0.025;

	out_hihat = (pulse_cluster + noise + sine_noise) * envGen_hihat * 0.7;

	gapTime_flick = 0.019 * TRand.kr(0.999, 1.001, 1.0);
	trig_flick = Impulse.ar(gapTime_flick.reciprocal) * EnvGen.ar(Env([1, 1, 0], [gapTime_flick * 2, 0]));

	envGen_flickPitch = EnvGen.ar(Env.perc(0.003, 0.024, 1.0, -4.2), 1.0, levelScale: 5300, levelBias: 50);
	envGen_flickAmp = EnvGen.ar(Env.perc(0.0, 0.04, 1.0, 5));
	flick = SinOsc.ar(envGen_flickPitch * Rand(0.999, 1.001), Rand(0, 6.2)) * envGen_flickAmp * 0.15;
	flick = flick +
		HPF.ar(
			SinOsc.ar(envGen_flickPitch * 4.9 * Rand(0.999, 1.001), Rand(0, 6.2)) * envGen_flickAmp * 0.1,
			2000
			);
	flick = flick + CombC.ar(flick, 0.2, gapTime_flick, 0.1, 0.55);
	flick = LPF.ar(flick, 3000);
	flick = HPF.ar(flick, 140);


	envGen_lastFlickPitch = EnvGen.ar(Env.perc(0.0026, 0.022, 1.0, -7), 1.0, levelScale: 3300, levelBias: 90);
	envGen_lastFlickAmp = EnvGen.ar(Env.perc(0.0, 0.035, 1.0, 2));
	lastFlick = SinOsc.ar(envGen_lastFlickPitch * Rand(0.999, 1.001)) * envGen_lastFlickAmp * 0.8;

	lastFlickDelayTime = 0.054 * TRand.kr(0.99, 1.01, 1.0);

	lastFlick = CombC.ar(lastFlick, 0.2, lastFlickDelayTime, 0.02) * 0.09;
	lastFlick = HPF.ar(lastFlick, 200);
	output = (flick + lastFlick + out_hihat) *  envGen_amp;
	output = LPF.ar(output, 6000);
	output = output + BPF.ar(output, 6000, 0.1, 0.6);
	output = output + (trig_flick * 0.4);
	Out.ar(audioOutBus, output ! 2);

}).send(s);
)

(
{

100.do {

	Synth("more_fun_snare", [\audioOutBus, 0], s);
	(60 / 120 / 0.5).wait;

};


}.fork;

)

//END OF KraftWerk SNare
//END OF KraftWerk SNare
//END OF KraftWerk SNare

//START OF SCTWITTZZ
//START OF SCTWITTZZ
//START OF SCTWITTZZ

//--tweet0000
{GlitchRHPF.ar(GbmanN.ar([2300,1150]),LFSaw.ar(Pulse.ar(4,[1,2]/8,1,LFPulse.ar(1/8)/5+1))+2)}.play//#SuperCollider

//--tweet0001
r{99.do{|i|x={Pan2.ar(SinOsc.ar(i+1,SinOsc.ar((i%9).div(3)*100+(i%9)+500),0.03),1.0.rand2)}.play;2.wait;x.release(25)}}.play//#SuperCollider

//--tweet0002
r{99.do{x={Pan2.ar(BPF.ar(Impulse.ar(18.linrand+0.5),9999.linrand,0.3.linrand,5),1.0.rand2)}.play;3.wait;x.release(9)}}.play//#SuperCollider

//--tweet0003
r{loop{x=play{t=SinOsc.ar(999.rand).abs;Formlet.ar(TDuty.ar(t,0,t),4e3.linrand,t,1-t)!2};wait(9.rand+1);x.release(39)}}.play//#SuperCollider

//--tweet0004
r{loop{z=20.rand+6;x={y=LFTri.ar(z).abs/9/z;RLPF.ar(TDuty.ar(y,0,y),z*600,0.06,9)!2}.play(s,0,z);wait(26-z);x.release}}.play//#SuperCollider

//--tweet0005
r{loop{z=60.rand+1;x={y=LFTri.ar(z).abs/z;RLPF.ar(TDuty.ar(y,0,y),z*99+y,0.01,6+y)!2}.play(s,0,z);wait(z/3);x.release}}.play//#SuperCollider

//--tweet0006
r{loop{x={GVerb.ar(MoogFF.ar(ClipNoise.ar*0.4,LFPar.kr({0.3.rand}!2,0,600,990)),9,9,1)}.play(s,0,19);3.wait;x.release}}.play//#SuperCollider

//--tweet0007
r{loop{x={BPF.ar(Pluck.ar(Crackle.ar([1.9,1.8]),Impulse.ar(5.rand+1),0.05,0.05.linrand),1200.rand)}.play(s,0,9);wait(9);x.release(69)}}.play

//--tweet0008
play{x=LFNoise1.ar(0.5!2);Formlet.ar(Crackle.ar(x.range(1.8,1.98)),TExpRand.ar(200,2e3,x).lag(2),x.range(5e-4,1e-3),0.0012)}//#SuperCollider

//--tweet0009
{|i|x=i+6.rand;Pbind(\dur,0.06,\sustain,1,\amp,0.01,\degree,Pgauss(x,sin(x+Ptime()%6/6e3)*9),\pan,Pkey(\degree)-x*9).play}!6//#SuperCollider

//--tweet0010
play{a=SinOsc;LeakDC.ar(a.ar(a.ar(0.31),a.ar(a.ar(0.21),a.ar(a.ar(0.11,a.ar(0.01)),0,a.ar([2,3],0,400))),a.ar([0.3,0.21])))}//#SuperCollider

//--tweet0011
play{f={|o,i|if(i>0,{SinOsc.ar([i,i+1e-4]**2*f.(o,i-1),f.(o,i-1)*1e-4,f.(o,i-1))},o)};f.(60,6)/60}//#SuperCollider

//--tweet0012
r{loop{Document.current.text[0..z].do{|x|z=x.ascii;play{Blip.ar(z/3,z,Line.kr(3,0,3/z,1,0,2))!2};wait(1/z)}}}.play(AppClock)//#SuperCollider

//--tweet0013
a=play{|a|Saw.ar(68,a)};fork{inf.do{|i|t="";{|j|b=cos(i*cos(j**(i/1e4)));t=t++" @"[b+1]}!68;a.set(\a,b);t.postcs;0.01.wait}}//#SuperCollider

//--tweet0014
play{a=SinOscFB;sum({|i|a.ar(a.ar(a.ar(a.ar(i+1,1/9,999),1/9,a.ar(1/9,1,1/9)),a.ar(0.1,3),i+2*999),a.ar(1/9,1/9),1/9)}!9)!2}//#SuperCollider

//--tweet0015
a=play{|b|Saw.ar*b};fork{inf.do{|i|t="";{|j|b=cos(i*sin(j+sin(i/9)/234));t=t++" @"[b+1]}!68;a.set(\b,b);t.postln;0.01.wait}}//#SuperCollider

//--tweet0016
play{b=LocalBuf(9e4,2).clear;i=Sweep.ar(BufRd.ar(2,b,Saw.ar(12,3e4,4e4)),9e4);BufWr.ar(Saw.ar([8,9]),b,i);BufRd.ar(2,b,i)/2}//#SuperCollider

//--tweet0017
play{b=LocalBuf(8e4,2).clear;i=Sweep.ar(BufRd.ar(2,b,Saw.ar(3.1,4e4,4e4)),8e4);BufWr.ar(Blip.ar([2,3]),b,i);BufRd.ar(2,b,i)}//#SuperCollider

//--tweet0018
play{b=LocalBuf(5e3,2).clear;i=Sweep.ar(BufRd.ar(2,b,Saw.ar(50,2e3,5e3)),6e4);BufWr.ar(Saw.ar([4,3]),b,i);BufRd.ar(2,b,i)/6}//#SuperCollider

//--tweet0019
play{b=LocalBuf(1e4,2).clear;i=Sweep.ar(BufRd.ar(2,b,Saw.ar(1,2e3,5e3)),5e5);BufWr.ar(Saw.ar([8,50]),b,i);BufRd.ar(2,b,i)/3}//#SuperCollider

//--tweet0020
play{a=LFPulse;b=(1..4);Mix(a.ar(a.ar(a.ar(a.ar(b/32)+1/8)+1*b)+(Mix(a.ar(b/64))+a.ar(4/b)*(a.ar(a.ar(b/8))*2+b))*100))/8!2}//#SuperCollider

//--tweet0021
r{{|j|a=play{sin(Decay.ar(Duty.ar(1/50,0,Dseq(flat({|i|asBinaryDigits(j+1*i)}!8),4),2),j+1*0.008))/2!2};5.12.wait}!256}.play//#SuperCollider

//--tweet0022
play{a=1/(2..5);GVerb.ar(Splay.ar(Ball.ar(LPF.ar(Impulse.ar(a),500),7-(1/a),1e-5,LFNoise2.kr(a/5,2e-4,12e-4))/2),5,0.5,0.9)}//#SuperCollider

//--tweet0023
play{Splay.ar({|i|f=i+5*99;RHPF.ar(Ringz.ar(Ball.ar(Saw.ar(i+1)>0,SinOsc.kr(0.1,0,1/5,0.3),0.05,0.02)/99,f,0.05),f,0.1)}!5)}//#SuperCollider

//--tweet0024
{|j|r{{|i|x=sin(i/5+(j*5));Ndef(i%5+(j*5),{Pan2.ar(LFCub.ar(j*2+x*40+400+i)/15,i%5/2-1)}).play;wait(x.abs+0.5)}!500}.play}!5//#SuperCollider

//--tweet0025
{|i|defer{Document.allDocuments.do{|d,c|x=sin(c+1*i/91);y=cos(c+1*i/88*x);d.bounds=Rect(a=x*160+320,b=y*120+240,a,b)}}}!555;//#SuperCollider

//--tweet0026
{CombL.ar(In.ar(8).tanh/8,1,1,8)!2}.play;Pbind(\amp,8,\dur,1/4,\degree,Pseq(List.fib(32)%(List.fib(64)%12),inf),\out,8).play//#SuperCollider

//--tweet0027
play{GVerb.ar(ceil(In ar:8*4+4)-4/10)};Pbind(\dur,2,\legato,Pgeom(0.5,1.1),\degree,Pseq(List fib:8+[[1,4]]-9,9),\out,8).play//#SuperCollider

//--tweet0028
play{MoogFF.ar(LFTri.ar(CombN.ar(Duty.ar(1/8,0,Dseq(Dshuf(List.fib(16)%8*99,8),inf)),4,4,16))/4,LFTri.kr(1/16,0,2e3,3e3))!2}//#SuperCollider

//--tweet0029
play{{|i|CombC.ar(In.ar(8),3+i,LFTri.ar(0.5,0,1,2+i),99)}!2};Pbind(\out,8,\note,Pstutter(8,Pseq(List.fib(32)%9/3,inf))).play//#SuperCollider

//--tweet0030
play{a=LFPar;GVerb.ar(VarSaw.ar(a.ar(1,0,5,a.ar([0.05,0.04],0,50,160).round(50)),0,a.ar(0.2,0,0.5,a.ar(3,0,0.2,0.5)))/8,80)}//#SuperCollider

//--tweet0031
x=0;{|i|Pbind(\dur,i+1/4,\lag,i/6/6,\octave,i+3,\legato,i+1/6,\degree,Pn(Plazy{x=x+1%6;Pseq(asDigits(x+1*142857))})).play}!6//#SuperCollider

//--tweet0032
{Splay.ar({|i|l=LFTri.ar(1/6,i/1.5,2.5,3.5).round;SinOsc.ar(142.857*l,lag(l,i-3/6),1-poll(0.142857*l,10/6,"\t\t"))}!6)}.play//#SuperCollider

//--tweet0033
play{f=LFPar.ar(1/14).round*20+80;Splay.ar(LFPar.ar({|i|[i+1*f,i*f+(i+1/3)]}!4)>BrownNoise.ar(Pulse.ar({|i|i+1}!4,0.35))/3)}//#SuperCollider

//--tweet0034
play{x=CombN.ar(Phasor.ar(0,{|i|i+1/20}!22),0.042,0.042);y=Phasor.ar(LPF.ar(x,LFPar.ar(1/99,0,400,500)),x);Splay.ar(y)*0.25}//#SuperCollider

//--tweet0035
play{x=CombC.ar(Phasor.ar(0,{|i|i+1/4}!5),0.2,LFPar.ar(0.09,0,0.05,0.1).round(0.022));Splay.ar(Phasor.ar(BPF.ar(x,50),x)/4)}//#SuperCollider

//--tweet0036
play{Splay.ar({|i|SinOsc.ar(i+SinOsc.ar(0.01,a=pi/[2,4,8]@@i,0.1,1)*80+SinOsc.ar(i+1*1e-4+i),a,SinOsc.ar(i+1*1e-3,a)/4)}!9)}//#SuperCollider

//--tweet0037
play{a=LFCub;n=8;Splay.ar(a.ar({|i|pow(i+1,a.kr(1/n,i/n,1/n,1))}!n*150,0,a.kr({|i|pow(i+1,a.kr(i+0.5/n,i/n))}!n).max(0))/4)}//#SuperCollider

//--tweet0038
play{PingPong.ar(LocalBuf(3e4,2).clear,Ringz.ar(CuspN.ar*Impulse.kr([9,8]/12)/9,LFPar.kr(1/[3,2]).range(51,[99,17])*9),0.5)}//#SuperCollider

//--tweet0039
play{a=SinOsc;Splay.ar({|i|i=i+1;a.ar(a.ar(i)+1**a.ar(2**a.ar(i/500)*(9-i))*a.ar(9*i).exprange(90,2**a.ar(i/20)*800))}!5)/4}//#SuperCollider

//--tweet0040
a={play{|b|LFTri.ar(b+69)}}!3;fork{inf.do{|i|x=sin(sin(i/99)*i/(i%3+68))*34+34;a[i%3].set(1,x);join($@!x).postln;0.01.wait}}//#SuperCollider

//--tweet0041
play{o=SinOsc.ar(1/RunningMax.ar(Sweep.ar(LocalIn.ar(6)),Impulse.ar([1,0.749,6,12,3,4])));LocalOut.ar(o);Splay.ar(o).tanh/2}//#SuperCollider

//--tweet0042
play{c=[97,99];l=3**9;a=LocalBuf(l,2).clear;BufWr.ar(Saw.ar(c/5),a,BPF.ar(VarSaw.ar(c),98,0.1)*l);PlayBuf.ar(2,a,1/4,1,0,1)}//#SuperCollider

//--tweet0043
fork{1e4.do{|i|text(d=Document.current).size.do{|j|d.font_(Font("Arial",sin(i+j/16)*18+22),j,1)};wait(1/60)}}.play(AppClock)//#SuperCollider

//--tweet0044
play{a=SinOsc;Limiter.ar(LeakDC.ar(a.ar(0.11,BRF.ar(a.ar(a.ar(0.12).exprange(1,1e4),2pi),1/a.ar(0.13).range(1,[99,100])))))}//#SuperCollider

//--tweet0045
play{a=SinOsc;a.ar(a.ar(a.ar(0.11)),a.ar(a.ar(95*a.ar(0.01,0,1,1),0,a.ar(5e-3,0,50),100),a.ar([98,97]),pi+a.ar(5e-4))).tanh}//#SuperCollider

//--tweet0046
play{a=LFTri;GVerb.ar(Mix(Limiter.ar(BRF.ar(a.ar(50,1e-4),a.ar(a.ar([1.01,1.0111])*a.ar(8e3)*1e3+4e3,55),a.ar(0.01)*3))))/9}//#SuperCollider

//--tweet0047
play{CombN.ar(Limiter.ar(BRF.ar(LFSaw.ar(10,0,0.01),LFTri.ar([5,6]*0.1))),0.1,LFTri.kr(0.1,0,0.05,0.05).round(0.01))}//#SuperCollider#SC2012

//--tweet0048
play{a=Impulse;b=SinOsc;c=b.ar(0,BRF.ar(a.ar([7,8]),a.ar(9).lag2(1e-3),1.5,2pi));Ringz.ar(c,b.ar(0.02,0,99,150),1/9)+c*0.02}//#SuperCollider

//--tweet0049
play{Splay.ar(SinOsc.ar(9,SinOsc.ar(midicps((Sweep.ar(0,(33..3))%128&(Sweep.ar(0,(3..9))%(LFSaw.ar(3)*9+99)))+33),0,pi)))/3}//#SuperCollider

//--tweet0050
play{a=Saw;b=(2..12);c=0.015;GVerb.ar(Splay.ar(Klank.ar(`[b*50+b,c,c],Hasher.ar(a.ar(b/4pi,a.ar(c)*b+b).ceil)))/9,5.rand+1)}//#SuperCollider

//--tweet0051
play{a=Saw;GVerb.ar(Splay.ar(BBandPass.ar(a.ar("sunday".ascii),a.ar(9/"slow".ascii)*400+500,a.ar(7/"coding".ascii)+1.1)/5))}//#SuperCollider

//--tweet0052
{Splay.ar(BLowPass.ar(Impulse.ar("sunday".ascii),LFTri.ar(3/"live".ascii)*1800+1900,LFTri.ar(4/"coding".ascii)+1.01))}.play// #SuperCollider

//--tweet0053
Pbind(\freq,Pseq("SUPERCOLLIDER".ascii,inf)*Pstutter(64,Pseq([3,4,5],inf))*[1,2.045],\dur,0.03,\amp,Pseq([0,0.1],inf)).play// #SuperCollider

//--tweet0054
play{CombN.ar(SyncSaw.ar(Saw.ar([3,4],32,64),Saw.ar([4,3],99,Duty.kr(1,0,flop(Dseq(2!6++4++3,99)*(4**(0..4))))))/9,1,1/6,2)}//#SuperCollider

//--tweet0055
play{a=Pulse;CombN.ar(Slope.ar(a.ar(a.ar([1,2]/3,1/9,50,[50,150])),a.ar([3,4],1/3)+a.ar([2,3],1/4)/10+0.005).cos/5,1,1/6,2)}//#SuperCollider

//--tweet0056
play{MantissaMask.ar(Pulse.ar(LFPulse.ar(1/8,0,0.55,15,76)+LFSaw.ar([0.1,0.11]),Saw.ar(10)),LFPar.ar(1/16,[0,0.5],3,3),0.7)}//#SuperCollider

//--tweet0057
a=GVerb;fork{loop{z=play{#b,c,d,e,f,g,h,i=(1..50).scramble;a.ar(a.ar(a.ar(a.ar(Dust.ar(1),b,c),d,e),f,g),h,i)/20};6.wait;z.release(5)}}//#sc

//--tweet0058
play{CombN.ar(SinOsc.ar(Saw.ar(3,64,99),Saw.ar([3,4],Saw.ar(1,32,128),Duty.ar(1,0,flop(Dseq([0,8,1,5])*[1,4,8]))))/9,1,1/6)}//#SuperCollider

//--tweet0059
a=LFTri;play{CombN.ar(SinOsc.ar(Saw.ar(3,128,128),Saw.ar([3,4],a.ar(a.kr(0.1,0,8,12),0,32,128)).sin)/4,1,1/6,a.kr(1/32)+1)}// #SuperCollider

//--tweet0060
a=LFSaw;play{FreeVerb.ar(CombN.ar(VarSaw.ar(a.ar([32,48],0,42*a.ar(1/[16,24]),8),0,a.ar([18,12],0,1/64,1/64)).sin/2,1,1,2))}//#SuperCollider

//--tweet0061
a=Demand;b=SinOsc;play{b.ar(a.ar(t=Saw.ar([9,9.01]),0,Dseq(0!6++500,inf)),b.ar(a.ar(t,0,Dshuf((0..7)*99,inf)).lag(0.04)))/2}//#SuperCollider

//--tweet0062
play{a=SinOsc;b=(1..9);Splay.ar(a.ar(b*55).clip(a.ar(2/b,0,0.5),a.ar(3/b,0,0.5,1))*a.ar(b*55+(4/b),0,a.ar(1/b,0,6)).tanh)/5}//#SuperCollider

//--tweet0063
format(a="c=SinOsc;play{FreeVerb.ar(c.ar(0,c.ar(Duty.ar(v=1/8,0,Dseq("+($%!96)+",inf)!2))),v,1)}",*a.ascii-96*96).interpret// #SuperCollider

//--tweet0064
format(a="play{GVerb.ar(SinOsc.ar(0,SinOsc.ar(Duty.ar(1/8,0,Dseq("+($%!16)+",inf))))/8,20,1/8)}",*a.ascii.midicps).interpret//#SuperCollider

//--tweet0065
format(a="play{SinOsc.ar(%/[%,%],LPF.ar(LFSaw.ar(Duty.ar(16/%,0,Dseq("+($%!96)+",inf)),%),%,%))}",*a.ascii).postln.interpret//#SuperCollider

//--tweet0066
tr(a="play{VarSaw.ar(Duty.ar(0.1,0,Dseq("+($%!8)+".flat.midicps,inf)!2).lag3(0.03),0,0.3)}",$%,a.ascii%64+36).post.interpret//#SuperCollider

//--tweet0067
("nj_wy_;JDRpg,_p&.,./*.*.,/*0ng'9QglMqa,_p&77)_*Quccn,_p&Q_u,_p&Y/*/,./03[(_'*2..(_'#_',r_lf-0{".ascii+2).asAscii.interpret//#SuperCollider

//--tweet0068
play{a=LocalIn.ar(2);LocalOut.ar(a=Hasher.ar(a.round(LFTri.ar(LFTri.ar(1e-4)/4+1e-3,0,LFTri.ar(1e-3)).round(2e-4))));a*0.45}//#SuperCollider

//--tweet0069
play{a=LocalIn.ar(2);LocalOut.ar(a=Hasher.ar(a.round(LFPar.ar(4e-3).round(3e-3)/3+a)));FreeVerb2.ar(a[0],a[1],0.33,1,1,0.4)}//#SuperCollider

//--tweet0070
play{a=LocalIn.ar(2);LocalOut.ar(a=Hasher.ar(a.round(SinOsc.ar(3.3e-4,a*2pi).round(5e-4))));a/3+CombN.ar(a,1,[1,0.9],3,0.4)}//#SuperCollider

//--tweet0071
play{a=LFTri;b=(2..5);Splay.ar(a.ar(abs(a.ar(b/9/9/9).round(a.ar(9-b*99,9-b/9,a.ar(b/9,b/99)))*a.ar(9,0,9-b*99,99*b),b/9)))}//#SuperCollider

//--tweet0072
play{a=Pulse;b=(1..8-1);GVerb.ar(Limiter.ar(Splay.ar(a.ar(abs(a.ar(b,1/8,8-b/8)).round(a.ar(b*8,b/8,a.ar(b))))))/8,8,1,0.8)}//#SuperCollider

//--tweet0073
play{a=Pulse;b=(1..8);CombN.ar(Splay.ar(a.ar(a.ar(b,a.ar(b/9),b*9,b*99+99),1/3,a.ar(b/9+a.ar(1,2/3,8,10)/9)).tanh),1,2/3,4)}//#SuperCollider

//--tweet0074
play{a=Pulse;BLowPass4.ar(a.ar(a.ar(2,0.2,a.ar(3,0.3)*500,[600,606]*a.ar(5))).sin,LFPar.ar(0.07)*4e3+5e3,LFPar.ar(0.1)+1.3)}//#SuperCollider

//--tweet0075
play{a=SinOsc;b=(1..16)*8;a.ar(a.ar(b).sum+[2,3]+a.ar(1/8)*99*a.ar(b/(a.ar(1/6)*2+2.05),0,4+a.ar(1/8)).reduce('bitOr'))*0.5}//#SuperCollider

//--tweet0076
play{a=SinOsc;a.ar(a.ar([1,2,4,8]/4*999).sum*50+[2,1]/3,a.ar(60,0,a.ar([1,2]/3)*a.ar(1/8,0,a.ar(1/8)*8)).tanh*a.ar(4)*6)/2}// #SuperCollider

//--tweet0077
play{a=SinOsc;b=a.ar(a.ar(1/[5,6])+[798,912],a.ar(1/16)*19+99*a.ar([9,8]),a.ar(a.ar(6)*a.ar(0.009)));a.ar([201,301],b).tanh}//#SuperCollider

//--tweet0078
play{a=GrayNoise.ar;b=(1..9);CombL.ar(a,1,b/Duty.ar(3,0,Dseq([0.5,1,2,3]*99,99)).lag3(1)).mean/2+Ringz.ar(a/99,b*99).mean!2}//#SuperCollider

//--tweet0079
play{Saw.ar((99,111..999),LFSaw.ar(1.1/(1..76))).mean.distort.distort.distort.distort.distort.distort.distort.distort*3.5!2}//#SuperCollider

//--tweet0080
play{a=SinOsc;b=a.ar(1/3);Duty.ar(SampleDur.ir,0,Dseq([0,1],inf)).bitXor(a.ar(b>0*30+60,0,a.ar(4,0,a.ar([3,2]/9,b*3,9))))/9}//#SuperCollider

//--tweet0081
fork{inf.do{t=3.0.linrand;play{{XLine.ar(1.0.rand,0.5.rand,t)}!2*SinOsc.ar(XLine.ar(999.rand+99,999.rand,t,1,0,2))};t.wait}}//#SuperCollider

//--tweet0082
play{a=LFTri.ar(1/9)*0.07+0.0708;CombN.ar(Decay2.ar(Duty.ar(Dseq([1e-4,a/2],inf),0!2,Dseq([-1,0,1,0],inf)),a/9,a)/5,1,1,12)}//#SuperCollider

//--tweet0083
play{a=LFCub;Splay.ar({|i|i=i+1;Formant.ar(*Sweep.ar(a.ar(i/[1,2,3])>a.ar(i/9,i/9,1/6,1/3),0.05)*99*i+99*i)*a.ar(0.1/i)}!6)}//#SuperCollider

//--tweet0084
play{a=Saw;Splay.ar(Formant.ar(a.ar((5,7..15)*19)*99+199,a.ar((1,3..13)*29)*199+299,a.ar((3,5..11)*a.ar(3,2,3))*299+399))/3}//#SuperCollider

//--tweet0085
play({Duty.ar(1/9600,0,Dseq((0..255).collect{|i|[1]++(1-i.asBinaryDigits.reverse)++[0]}.flat,inf),2)!2},s,0,0)// #SuperCollider talks serial

//--tweet0086
play{a=LFNoise2.kr(1/(9..17));Splay.ar(Ringz.ar(BPF.ar(Dust2.ar(a.abs*1e4),a.exprange(99,1e4),1.1-a),(9..1)*99,a+1.1,a)/5)}// #SuperCollider

//--tweet0087
play{BLowPass4.ar(Splay.ar(VarSaw.ar(200*Duty.kr(1/(1..5),0,Dseq(flat({|x|{|y|y+1/(x+1)}!8}!8),inf)))),5e3,LFTri.kr(9)+1.1)}//#SuperCollider

//--tweet0088
play{a=SinOsc;LPF.ar(LeakDC.ar(a.ar([98,99],a.ar([8,9],a.ar(1/[88,99],0,2pi),pi).lag(a.ar([9,8])),a.ar(1/[8,9])*9)%1),9e3)}// #SuperCollider

//--tweet0089
play{GVerb.ar(Splay.ar(Ringz.ar(Blip.ar(a=[4,14,5,15,6,16,8],LFNoise0.ar(4/a)*99,LFNoise1.ar(4/a).max(0)),a*99,4/a))/6,200)}//#SuperCollider

//--tweet0090
play{FreeVerb.ar(Splay.ar(BBandPass.ar(Blip.ar(b=(1..8)+1,LFTri.ar(1/b)*9e3,LFTri.ar(3/4/b).max(0)),b*999,1/b),2,3),0.3,1)}// #SuperCollider

//--tweet0091
play{a=LFPulse;Splay.ar(Pulse.ar((1..10)*a.ar(1/24+a.ar(1/3)*12,0,1/9,a.ar(1/12,0,0.5,9,48)).abs+6).reduce(\mod).softclip)}// #SuperCollider

//--tweet0092
play{Mix(Pan2.ar(Formlet.ar(Dust.ar(b=(1..8)),b*99,b/99,b/9),SinOsc.ar(b),LFSaw.ar(9.5-b,b/9,LFTri.ar(b/5)*4).max(0)).sin)}// #SuperCollider

//--tweet0093
play{x=SinOsc;a=LocalIn.ar(2);z=x.ar([3.1,4.2]+a)-Balance2.ar(a[0],a[1],x.ar(a*x.ar(a)*999));LocalOut.ar(CombN.ar(z/3));z/5}//#SuperCollider

//--tweet0094
play{a=Blip;b=LFSaw;CombN.ar(a.ar(a.ar(b.ar(1/[9,99])*1e3+4e3,b.ar(1/[23,24])*4+5,b.ar(1/[5,6])+b.ar(1/[8,9])*9)),0.3,0.3)}// #SuperCollider

//--tweet0095
{|i|a=VarSaw;b=i/8;play{Pan2.ar(a.ar(b*666+a.ar(b+0.03,b),0,b+0.06,a.ar(b+1,0,b+0.1,6+b,7+b)).sin.tanh,a.ar(b+1,b),0.2)}}!8// #SuperCollider

//--tweet0096
play{a=LFTri;b=LocalIn.ar;LocalOut.ar(c=Limiter.ar(CombC.ar(a.ar(d=b+1)*a.ar(d*999),1,a.ar((2..5)/3).mean/2+0.5,6)));c/2!2}// #SuperCollider

//--tweet0097
play{a=LFTri;b=LocalIn.ar;LocalOut.ar(c=Limiter.ar(CombC.ar(a.ar(400)*a.ar(d=b+2),1,a.ar((2..5)/d/d/d).mean*0.5+0.5)));c!2}// #SuperCollider

//--tweet0098
play{a=LFSaw;b=LocalIn.ar;LocalOut.ar(c=Limiter.ar(CombC.ar(a.ar(d=b+3.3*99)*a.ar(a.ar(d/9)*99),2,a.ar(1/d)/2+1,9)));c/2!2}// #SuperCollider

//--tweet0099
Pspawn(Pbind(\method,\par,\delta,1/8,\pattern,{Pbind(\dur,a=Pseq((1..9).sputter),\sustain,1/8/a,\degree,a,\detune,a)})).play//#SuperCollider

//--tweet0100
r{loop{x=play{a=DelayN.ar(LPF.ar(InFeedback.ar(0,2),z=1.rrand(9)*99));SinOsc.ar(z+[0,3],a*pi)/2};6.wait;x.release(9)}}.play// #SuperCollider

//--tweet0101
r{loop{x=play{c=c?1%8+1;a=DelayN.ar(InFeedback.ar(0,2),1,1);SinOsc.ar(c*99+[0,2],a[1..0])/4};wait(9-c);x.release(16)}}.play// #SuperCollider

//--tweet0102
{|i|play{a=DelayC.ar(InFeedback.ar(1-i),8,LFSaw.ar(1e-5*i+1e-4*(LFSaw.ar(0.1)>0),i,4,4));SinOsc.ar(99+[0,a/9],a*pi)/5!2}}!2// #SuperCollider

//--tweet0103
{|i|b=SinOsc;play{a=DelayC.ar(InFeedback.ar(1-i),6,b.ar(1e-3*(b.ar(1,i)),i,3,3));b.ar(45+[a/8,a/9]+b.ar(0.123),a*3)/5!2}}!2// #SuperCollider

//--tweet0104
play{a=LFCub;(50..85).midicps.clump(2).collect{|x,y|a.ar(TRand.ar(x,y,Dust.ar(b=a.ar(y/x).exprange(1,5e3))),0,b/5e3)}.mean}// #SuperCollider

//--tweet0105
play{a=SinOsc;f=InFeedback.ar(0,2);Pan2.ar(a.ar(a.ar(b=(1..9))*b+99,f/(9-b),a.ar(a.ar(b,f))).sum.sin,a.ar(a.ar(2.001)*12))}// #SuperCollider

//--tweet0106
play{a=SinOsc;b=InFeedback.ar(0,2);a.ar(9,a.ar(Pitch.kr(Balance2.ar(b[0],b[1],a.ar(12)),execFreq:99).flop[0])+a.ar(3,b,2))}// #SuperCollider

//--tweet0107
play{a=SinOsc;d=a.ar(12*a.ar(9))%1/4;c=Amplitude.ar(InFeedback.ar(0),d,d)+a.ar(d*d+[32.01,32]);BBandPass.ar(a.ar(0,c*9,c))}// #SuperCollider

//--tweet0108
play{a=SinOsc;Splay.ar({|i|j=i/700;a.ar(j,a.ar(j*2,a.ar(j*3,a.ar(j*4,a.ar(j*5,InFeedback.ar/99,2pi),2pi),2pi),2pi))}!15)/2}// #SuperCollider

//--tweet0109
play{a=LFSaw;Formant.ar(b=a.ar(a.ar(a.ar(a.ar(0.1)+1.0905*9)/99)*999)*999,c=CombN.ar(b,1,[0.1,0.11]),CombN.ar(c,1,0.19))/3}// #SuperCollider

//--tweet0110
play{Splay.ar({a={LFSaw.kr(0.05.rand2,0,1.0.rand)}!3;BLowPass4.ar(Saw.ar(a@0*250+300,a[2].max(0)),a@1*2e3+2100,0.025)}!99)}// #SuperCollider

//--tweet0111
play{a=SinOsc;Splay.ar(a.ar(PulseCount.ar(f=InFeedback.ar(0,2).sum)%999+(60,63.0005..99)*a.ar(2**f)*2+[3,4],f>0*f*9)).tanh}// #SuperCollider

//--tweet0112
r{inf.do{|i|Ndef(\,{VarSaw.ar(Duty.ar(1/12,0,Dseq((12..0)*(i%63+99)),2)*[1,1.01],0,i/9%9/9)/9}).play.spawn;wait(1/3)}}.play// #SuperCollider

//--tweet0113
{|i|play{a=Duty.ar(b=1/24,0,Dseq(Dshuf({b.linrand}!8,16+i),99));Pan2.ar(BPF.ar(Saw.ar(c=a+i+1*99,a*3),c*2,0.6)*5,i/4-1)}}!9// #SuperCollider

//--tweet0114
play{a=LFNoise1;BPF.ar(Splay.ar(SinOsc.ar(0,a.ar((999,888..111),a.ar(1/(9..1),a.ar({|i|i+1/(9-i)}!9,99))))/4),1500,a.ar+1)}// #SuperCollider

//--tweet0115
play{a=Pulse;d=Splay.ar(a.ar(Duty.ar(c=a.ar(b=(6..1),b/7.5)/8+1,0,Dseq(b*c+c.lag3(9)*66,inf))))/9;d+GVerb.ar(d.mean,25,25)}// #SuperCollider

//--tweet0116
play{BPF.ar(SinOsc.ar(Duty.ar(1/300,0,Dseq([Dseq([a=1270,b=2225],2e2),Drand([[1070,a],[2025,b]],[1e3,2e3])],inf))),1500,3)}// #SuperCollider

//--tweet0117
play{a=LFTri.ar(1/[8,7]).abs;CombC.ar(Pulse.ar(Duty.ar(a+0.1/9,0,Dseq([Dshuf((1..9)*99,7),3e3],inf)).lagud(*a/6),a),1,a,5)}// #SuperCollider

//--tweet0118
fork{999.do{|i|unixCmd("afplay -v"+5.0.rand+" -r"+(9.rand+1)+Platform.resourceDir+/+"sounds/a11wlk01.wav");wait(0.5.rand)}}// #SuperCollider

//--tweet0119
OSCFunc({|m|a.set(\f,m[4]-0.555%4)},'/');a=play{|f=55|SendPeakRMS.kr(x=SinOsc.ar(f.lag(5)*[155,555]*f,5**f),9*f,5,'/');x/5}// #SuperCollider

//--tweet0120
play{a=LFTri;CombN.ar(VarSaw.ar(Select.kr(a.kr(1/[7,8])*a.kr(1/9,0,99),(60..79).midicps),0,a.kr(1/[3,4])%1),1,1/[5,6],8)/4}// #SuperCollider

//--tweet0121
play{a=SinOsc;CombN.ar(a.ar(Select.kr(a.kr(1/[8,7])*a.kr(1/30,0,9),(56,62..98).midicps),0,a.ar(1/[4,3])),1,1/[6,5],9).tanh}// #SuperCollider

//--tweet0122
play{a=LFPar;BLowPass.ar(a.ar(Select.kr(a.kr(1/[3,4],0,64*a.kr(5)),(60..67).midicps)),a.kr(0.04)+5*500,a.kr(1/[5,6])+1.01)}// #SuperCollider

//--tweet0123
play{a=SinOsc;a.ar(a.ar(1/[8,12])>0.9+1*[400,404],InFeedback.ar([1,0]).lagud(a.ar(b=1/(1..6)).mean,a.ar(b*1.25).mean)*4pi)}// #SuperCollider

//--tweet0124
play{a=SinOsc;a.ar(a.ar(4)>0.2+1*[99,98],InFeedback.ar([1,0]).lagud(a.ar(0.1).abs/5,a.ar(a.ar(1/99)).abs)*a.ar([301,303]))}// #SuperCollider

//--tweet0125
play{a=SinOsc;a.ar(a.ar(1/[8,9])*4+[400,202],CombC.ar(InFeedback.ar([1,0]).lagud(a.ar(1/9)+1/88,a.ar(1/8)+1/99),1,0.08,9))}// #SuperCollider

//--tweet0126
play{a=SinOsc;c=HPF.ar(a.ar([1,4/3],HPF.ar((1..9).sum{|x|Pan2.ar(a.ar(1/x)>0.5,a.ar(666/x))},5)),5);GVerb.ar(c,99,9)/7+c/4}// #SuperCollider

//--tweet0127
play{a=LFTri;distort(LeakDC.ar(a.ar(LeakDC.ar((1..9).sum{|x|Pan2.ar(a.ar(1/x)>0.51,a.ar(a.ar(x+1)*9.99+1200/x))})*4e3))/9)}// #SuperCollider

//--tweet0128
play{a=LFTri;RLPF.ar(LeakDC.ar(a.ar(LeakDC.ar((1..9).sum{|x|Pan2.ar(a.ar(1/x,x/3)>0.3333,a.ar(666/x))})*999)).distort,3e3)}// #SuperCollider

//--tweet0129
play{a=SinOsc;LeakDC.ar(a.ar(LeakDC.ar((1/[1,2,4,3,9]).mean{|x|Pan2.ar(a.ar(x*9)>0.6,a.ar(a.ar(x/9)+a.ar(x)*666))})%1*4e3))}//#SuperCollider

//--tweet0130
play{a=SinOsc;LeakDC.ar(a.ar(LeakDC.ar((1/(1,3..9)).mean{|x|Pan2.ar(a.ar(x)<a.ar(x*9),a.ar(a.ar(x/3)*3e3))})%0.5-0.25*2e3))}//#SuperCollider

//--tweet0131
{|k|play{a=SinOsc;Mix({|i|LeakDC.ar(Pan2.ar(a.ar(1/9+i,0,j=a.ar(i+1/99)),a.ar(i+1+k*(j.ceil*39+39),a.ar(k+2),j)))}!9)/3}}!2// #SuperCollider

//--tweet0132
play{a=SinOsc;HPF.ar(a.ar(HPZ1.ar(Amplitude.ar(InFeedback.ar(0,2)*9,0,a.ar(2)%1/6)*8e3),Decay2.ar(a.ar(0.5005)>0.93)),9)/2}// #SuperCollider

//--tweet0133
play{a=LFSaw;Splay.ar(RLPF.ar(Blip.ar(Duty.ar(1,a.ar(a.ar(1)*9+99),a.ar(7)>(a.ar(12)*0.3+0.6)*8+9),17),(1..12)*99,6e-3))/4}// #SuperCollider

//--tweet0134
play{a=LFSaw;mean({|i|Ringz.ar(Blip.ar(a.ar(i+1/[3,4])>(a.ar(i+1/8)+1)*25+50,i+[2,3])*a.ar(i+1/50,i/25),i+1*99,0.1)}!50)/5}// #SuperCollider

//--tweet0135
play{a=Pulse;a.ar(a.ar(a.ar(1,b=(1..8)/9,9,8e3),a.ar(2/3,1/9).lag(a.ar(1)*9),a.ar(b/9,0.6,9,99),250),b/(a.ar(4)+4)).mean!2}// #SuperCollider

//--tweet0136
play{a=Pulse;a.ar(a.ar(a.ar(1,b=(1..8)/9,99,9e3),a.ar(b,0.4).lag(2),a.ar(0.2*b,0.1,9,99).lag(1),300),b/(a.ar(4)+4)).mean!2}// #SuperCollider

//--tweet0137
play{a=LFSaw;b=a.ar(1/64)*8+9;Splay.ar({|i|a.ar(round(a.ar(i+1/32/b,i/40)+1**2*2e3+50,50),0,a.ar(i/16/b,i/48).min(0))}!64)}// #SuperCollider

//--tweet0138
play{a=LFTri;b=a.ar([199.99,200]);BPF.ar(b+DelayC.ar(b+a.ar(399.9),1,a.ar(1/99,[0,0.05])/99),999,0.1,5)};s.scope(2).style=2// #SuperCollider

//--tweet0139
play{a=LFPar;Splay.ar({|i|Pluck.ar(GrayNoise.ar(a.ar(i=i+1)),a.ar(i/2)%a.ar(i/3/2),1,i*pi/3e3,3,a.ar(i/9,i,0.499,0.5))}!6)}// #SuperCollider

//--tweet0140
play{a=LFTri;LFPulse.ar(a.ar(Duty.ar(1/8,0,Dswitch([Dseq((1..8),4),Dseq([60,1,2],[4,3])]/2,Dseq([0,1],99))*99),0,3e3,300))}// #SuperCollider

//--tweet0141
play{Mix({|i|BPF.ar(a=Pulse;a.ar(i+[50,a.ar(1/16).lag2(i)+2*99]@@i,a.ar(j=i+1)*a.ar(j)+a.ar(1/12).lag3(10)),j*500)}!8)/3!2}// #SuperCollider

//--tweet0142
play{Splay.ar({|i|HPF.ar(a=Pulse;a.ar(a.ar(i+4/32).lag3(0.1,8-i)+1*99,a.ar(j=i+1)*a.ar(i+8/j)+a.ar(8/j).lag3(8)),50)}!8)/2}// #SuperCollider

//--tweet0143
play{l=LocalBuf(b=1e4,2);{|i|BufWr.ar(a=LFTri.ar(i+1*[8,19.2]),l,a/[i+1]*b)}!3;LPF.ar(PlayBuf.ar(2,l,1/9,1,0,1).clip2,b)/2}// #SuperCollider

//--tweet0144
play{l=LocalBuf(b=3e3).clear;{|i|BufWr.ar(LFTri.ar(i+1*99),l,LFSaw.ar(i).lag(LFSaw.ar(1/9)+1)*b)}!6;PlayBuf.ar(1,l,loop:1)}// #SuperCollider

//--tweet0145
play{a=LFTri;l=LocalBuf(b=600,9).clear;BufWr.ar(a.ar(c=(3..11)*3.5),l,a.ar(9/c,c/99)*b);Splay.ar(PlayBuf.ar(9,l,loop:1)/2)}// #SuperCollider

//--tweet0146
play{a=LFTri;l=LocalBuf(c=99,20).clear;RecordBuf.ar(a.ar(c=(1..20)),l);GVerb.ar(HPF.ar(IndexL.ar(l,a.ar(c/45)).sum,9)/9,1)}// #SuperCollider

//--tweet0147
play{f=LFCub.ar(_);e=f*16+16;BufWr.ar(PanAz.ar(c=32,f.(4.008),f.(9)),l=LocalBuf(c,c),e.(4));Splay.ar(BufRd.ar(c,l,e.(99)))}// #SuperCollider

//--tweet0148
play{f=LFPar.ar(_);e=f*31+31;BufWr.ar(PanAz.ar(c=64,f.(5.04),f.(3)),l=LocalBuf(c,c),e.(1));Splay.ar(BufRd.ar(c,l,e.(200)))}// #SuperCollider

//--tweet0149
play{f=LFTri.ar(_);e=f*4e3+4e3*f.(1.2).abs;BufWr.ar(f.([3,4]),l=LocalBuf(8e3,2).clear,e.(1/9));COsc.ar(l,99,f.(1/[7,8]))/4}// #SuperCollider

//--tweet0150
play{o=CombC.ar(Limiter.ar(HPF.ar(LocalIn.ar(2),9)+Impulse.ar(1/3,1/[4,5])),4,LFTri.ar(0.02)*1.9+2,9,0.9);LocalOut.ar(o);o}// #SuperCollider

//--tweet0151
a=SinOsc;Ndef.clear.new(\,{a.ar(b=[98,99],Ndef.ar(\).lag3(Ndef.ar(\)%2/b),a.ar(1/b))});Ndef(\y,{a.ar(b+1,Ndef.ar(\))}).play// #SuperCollider

//--tweet0152
play{a=SinOscFB;Splay.ar({|i|Pan2.ar(a.ar(a.ar(b=1.995**i,0.5/b)+(a.ar(2/b,a.ar(b))*999),a.ar(b*1.01)),a.ar(pi/b,2))}!9/4)}// #SuperCollider

//--tweet0153
play{a=LFTri;b=[3,4,8];Splay.ar(Formlet.ar(a.ar(b*99+99),a.ar(b).round(a.ar(0.05).round(1/3))*99+200,1,a.ar(b/6.011)%1)/9)}// #SuperCollider

//--tweet0154
play{a=SinOsc;b=(4.002,9..99);mean(Pan2.ar(c=a.ar(b),c))>mean(a.ar(d=1/99)/b)*Splay.ar(a.ar(b%round(a.ar(d/b*8,b,12))*99))}// #SuperCollider

//--tweet0155
play{a=LFTri;b=(1..9).pyramid;LeakDC.ar(Pan2.ar(a.ar(d=6.01/b),a.ar(99*b),a.ar(d)%1)+Ringz.ar(a.ar(d)<d,60,0.07)).sum.tanh}// #SuperCollider

//--tweet0156
play{b=(1,3.075..16);a=SinOsc;GVerb.ar(Splay.ar(a.ar(1/b,3*a.ar(b*Duty.ar(b,0,Dseq(b+23,inf).midicps).lag(2))).tanh/5),90)}// #SuperCollider

//--tweet0157
a=SinOscFB;play{LeakDC.ar(Splay.ar(RHPF.ar(PinkNoise.ar(a.ar(b=1/(1..32),b)),a.ar(a.ar(b,b),1.35)+1/b*50,0.009,b))).tanh/2}// #SuperCollider

//--tweet0158
{|i|Pmono(\default,\dur,Pseq(1/[i=i+0.999,Pn(Pseq(b=(2..8)*i),Pseq(b))],inf),\amp,1/b,\freq,Pseq([b,b*i/4]*99,inf)).play}!8// #SuperCollider

//--tweet0159
play{a=LFTri;BufWr.ar(a.ar([2.995,4]*99),b=LocalBuf(3e4,2).clear,a.ar([2,6]/99)*3e4);BufRd.ar(2,b,a.ar([6,9.06]/99)*9e3)/5}// #SuperCollider

//--tweet0160
play{a=SinOscFB;c=a.ar([50,99],0.4);RecordBuf.ar(InFeedback.ar(0,2)+c/3,b=LocalBuf(8e4,2).clear);BufRd.ar(2,b,a.ar(c)*6e4)}// #SuperCollider

//--tweet0161
play{c=CombN.ar(InFeedback.ar(0,2),1,1/8,2.4,1.4);LeakDC.ar(SinOscFB.ar(Pitch.kr(c).flop[0]-0.2+(d=c.abs.lag(0.032)),1-d))}// #SuperCollider

//--tweet0162
play{a=SinOscFB;a.ar(Pitch.kr(CombN.kr(InFeedback.ar([1,0]),1,1/[2,3])).flop[0]*a.ar(1/[3,4],0.1,0.3,1.2),a.ar(1/[4,5])/2)}// #SuperCollider

//--tweet0163
play{a=LFPulse;a.ar(Pitch.kr(CombN.ar(InFeedback.ar([1,0]),4,4,8)).flop[0]*a.ar([6,3],0,a.ar(1.99)/8+0.3,1.2),0,a.ar(1)/2)}// #SuperCollider

//--tweet0164
play{a=SinOsc;LeakDC.ar(a.ar([1,2],a.ar(Pitch.kr(CombN.ar(InFeedback.ar([1,0]),5,[4.8,4.7])).flop[0]-4)*2pi*a.ar(1/16)))/2}// #SuperCollider

//--tweet0165
play{CombC.ar(BLowPass.ar(Limiter.ar(LeakDC.ar(InFeedback.ar([1,0]))),2e3)+Impulse.ar(0),1,LFTri.ar(1/[6,8])*0.4+0.5)*0.99}// #SuperCollider

//--tweet0166
play{a=LFTri;BufWr.ar(a.ar(b=[303,404]),l=LocalBuf(64,2).clear,a.ar(b*a.ar(99/b)));BufRd.ar(2,l,a.ar(b+2)*a.ar(0.01)*12)/4}// #SuperCollider

//--tweet0167
play{a=LFTri;Splay.ar(Pulse.ar(b=(101,202..1010)/2,RHPF.ar(a.ar(99/b)*0.9%1,a.ar(9/b,b).linexp(0,1,4,1e4),a.ar(5/b)+1.5)))}// #SuperCollider

//--tweet0168
30.do{|i|play{b=13.fib;Resonz.ar(Splay.ar(Blip.ar(i+1/b,19)*ClipNoise.ar),i*[50,60]+400,LFTri.ar(1/[20,30]*i,i/9)/9+0.13)}}// #SuperCollider

//--tweet0169
play{GVerb.ar(Splay.ar(SinOsc.ar(0,Blip.ar(a=(1..5),99)*99,Blip.ar(a+2.5,a).lag2(LFSaw.ar(1/(a+2.25),2/a)+1)))/3,99,6,0.7)}// #SuperCollider

//--tweet0170
play{a=SinOsc;c=a.ar(0,a.ar(b=[2,3])*400,a.ar(b/4.1));c+a.ar(b*99*Amplitude.ar(c,0,1/7))+GrayNoise.ar(CombN.ar(c,1,b/3))/2}// #SuperCollider

//--tweet0171
play{b=(1..4);Splay.ar(CombN.ar(SinOsc.ar(1/b,Spring.ar(LFPulse.ar(pi/b),99*b,1.3e-3)*LFTri.ar(0.13/b,0,pi,2pi)),1,1/4,2))}// #SuperCollider

//--tweet0172
play{a=LFCub;b=(1..8);sum(CombN.ar(SinOsc.ar(c=2/b,a.ar(ceil(a.ar(c)*a.ar(1/b,0,75)).round(75),0,a.ar(0.1/c)*9)),1,1/5))/9}// #SuperCollider

//--tweet0173
a=LFTri;Ndef(\a,{CombC.ar(Ndef(\).ar,1,a.ar([2,3])/8+0.2,8)+8&(a.ar(1/[3,2])*7)});Ndef(\,{a.ar(Ndef(\a).ar*[99,199])}).play// #SuperCollider

//--tweet0174
a=LFTri;Ndef(\a,{CombC.ar(Ndef(\).ar,1,a.ar(2)/8+0.2,6)+9&(a.ar(1/3)*6+5)});Ndef(\,{LPF.ar(a.ar(Ndef(\a).ar*99),3e3)}).play// #SuperCollider

//--tweet0175
a=LFPar;play{Out.ar(5,a.ar(1)|a.ar(5)+RLPF.ar(x=Pan2.ar(InFeedback.ar(5),SinOsc.ar(5.5)),3e3,a.ar(1/25)/2+1.7));x*a.ar(99)}// #SuperCollider

//--tweet0176
SynthDef(\,{|f|Out.ar(0,LFPar.ar(f)*EnvGate()!2)}).add;PmonoArtic(\,\legato,c=Pn(Pshuf(6/8.fib,8)),\dur,c/22,\f,400/c).play// #SuperCollider

//--tweet0177
{|i|SynthDef(i,{|f|Out.ar(i,Saw.ar(f)*EnvGate())},0.123456).add;Pmono(i,\dur,c=Pn(Pshuf(i*4+4/8.fib,8))/20,\f,15/c).play}!2// #SuperCollider

//--tweet0178
play{a=LFTri;b=(1..8)+0.505;Splay.ar(a.ar(a.ar(1/(101-b))+1*99|a.ar(a.ar(1/b,1/b,pi,a.ar(1/b)+9)/b,1/b,404,404))*3).tanh/2}// #SuperCollider

//--tweet0179
play{a=LFTri;b=(1..5);Splay.ar(a.ar(b*99+round(a.ar(2/b)*40,40),b,a.ar(a.ar(0.5/b),b,a.ar(1/b,b,a.ar(2**b,b,pi)))).asin)/2}// #SuperCollider

//--tweet0180
play{a=SinOsc;GVerb.ar(a.ar(1+round(a.ar(0.01),c=[1,2]/3)*99*round(a.ar(c/2)+2))*a.ar(a.ar(c))*a.ar(c/4,0,a.ar(1/c)),99)/4}// #SuperCollider

//--tweet0181
play{Splay.ar(Formant.ar(RLPF.ar(Blip.ar(b=[4,0.5,8,16],LFSaw.ar(1/b,0,c=99,c),c,64),c,SinOsc.ar(b,b,0.5,0.6)).midicps,c))}// #SuperCollider

//--tweet0182
play{c=LFTri;mean({|i|Splay.ar([a=Saw.ar(i/98+99),DelayC.ar(a,2,c.ar(i/97+c.ar(i+1/(c.ar(i/96)*2e3+2e3),i/9,9))+1),a])}!9)}// #SuperCollider

//--tweet0183
play{c=SinOsc;mean({|i|Splay.ar({|j|CombC.ar(c.ar(j+1*99),1,c.ar(a=i*2+j/12)/2+0.5)*c.ar(i+j*99+99)*c.ar(a/3)}!8)}!8).tanh}// #SuperCollider

//--tweet0184
play{a=SinOsc;f={|i|Vibrato.ar(*if(i>0,{[a.ar(1/i)+2*f.(i-1)]},{[(99..96),(1..4),a.ar(0.1)+1,9]}))};Splay.ar(a.ar(f.(10)))}// #SuperCollider

//--tweet0185
play{a=LFSaw;c=(1..32);Splay.ar(SinOsc.ar(0,BPF.ar(a.ar(pi/c)*8pi*a.ar(c*a.ar(2/c,1/c,8.16,16)),c*99,a.ar(3/c)/3+0.34))/2)}// #SuperCollider

//--tweet0186
play{a=LFTri;b=(1..11).rotate(4)*1.011;LeakDC.ar(Splay.ar(Sweep.ar(0,b+999).fold(a.ar(11.11/b)/2-0.5,a.ar(11.1/b)/2+0.5)))}// #SuperCollider

//--tweet0187
Ndef(\,{|g,f|Pulse.ar([g,f])}).play;{|i|Ndef(\)[i=i+1]=\set->Pbind(\lag,i,\g,Pseq((i..9)*99,inf),\f,Pseq((i..91)*9,inf))}!9// #SuperCollider

//--tweet0188
Ndef(\,{|g,f|LPF.ar(Saw.ar([g,f]),1999)}).play;{|i|Ndef(\)[i+1]=\set->Pbind(\lag,i/9.1,\g,a=Pseq((i..9)*91,inf),\f,a-i)}!19// #SuperCollider

//--tweet0189
play{Splay.ar(Limiter.ar(Formlet.ar((a=LFSaw).ar((b=(1..8))+200),b*a.ar(b/29).round(0.51)+1*99,a.ar(b/9)*0.5+0.50001)/99))}// #SuperCollider

//--tweet0190
play{a=LFTri.ar(b=8/(1..11))%(LFTri.ar(b-3))+2.01;Limiter.ar(Splay.ar(Formant.ar(202*a[0..3],404*a[4..7],606*a[8..11])))/2}// #SuperCollider

//--tweet0191
play{a=LFSaw;Splay.ar(CombN.ar(Blip.ar(a.ar(b=(1..5)).ceil*(a.ar(1/b)*30+60)+99,a.ar(0.2/b).round(1/3)*8+9).tanh,4,4/b,9))}// #SuperCollider

//--tweet0192
play{a=Pulse;c=a.ar(b=[4,1,5,8,3],d=b/9).lag(1/b);Splay.ar(a.ar(b*99*a.ar(b,1/4,1,1.01)|a.ar(d,d,98,99).lag(c%1),c/2+0.5))}// #SuperCollider

//--tweet0193
play{a=LFSaw;Splay.ar(BLowPass4.ar(b=a.ar(a.ar(c=3/(1..12),d=c/3*2,99/c+99,900+c)),c*999+a.ar(c),a.ar(c,d)%1+0.01*2)).tanh}// #SuperCollider

//--tweet0194
play{a=SinOsc;b=(2,4..20);CombN.ar(Splay.ar(HPF.ar(a.ar(0,Duty.ar(2/b,0,Dseq(b,inf)).lag2(a.ar(1/b,b)%1)*2pi),9)),1,2/3,4)}// #SuperCollider

//--tweet0195
play{a=SinOsc;tanh(a.ar(3e-3,DelayC.ar(Ringz.ar(b=InFeedback.ar(1),[9,12],a.ar(c=1/[3,4])+15),1,a.ar(0,b.lag3(1))/9+0.5)))}// #SuperCollider

//--tweet0196
play{a=SinOsc;Normalizer.ar(Splay.ar(a.ar(811+b=(2..8),a.ar((c=a.ar(0.1/b,b))<0*9*b+855+(9/b),a.ar(899/b)*2,2).tanh*6,c)))}// #SuperCollider

//--tweet0197
play{a=SinOsc;mean({|i|b=a.ar(a.ar(j=i+0.99)/9,a.ar(a.ar(j/99))*9,j*9).tanh;Pan2.ar(a.ar(b.exprange(j*99,j+1*99)+i),b)}!9)}// #SuperCollider

//--tweet0198
play{a=LFSaw;Splay.ar(Ringz.ar(CombN.ar(ClipNoise.ar(a.ar(b=(1..5)/8)>a.ar(0.1,0,1,0.5)),1,b,2),[261,311,349,391,466]))/90}// #SuperCollider

//--tweet0199
play{Splay.ar({|i|SinOsc.ar(c=1/8,LFCub.ar(Duty.ar(b=InFeedback.ar(i%pi)+c,b-c,Dseq(midicps((1..9)*25%32+40),inf)))+i)}!9)}// #SuperCollider

//--tweet0200
a=SinOsc;{|i|play{Pan2.ar(a.ar(i+1/99,i+[1,2]+a.ar(i+1*999)*a.ar([50,74,99]@@i*a.ar(i/9+99,i,i,i))),a.ar(a.ar(i/9)))/11}}!9// #SuperCollider

//--tweet0201
play{a=LFSaw;HPF.ar(SinOsc.ar(2**Decay.ar(a.ar(c=[2,3]),b=2**a.ar(1/9)-0.5)+99))*BLowPass4.ar(a.ar([261,369]),b+1*5e3,0.2)}// #SuperCollider

//--tweet0202
a=SinOsc;fork{inf.do{|i|play{Pan2.ar(a.ar(i,a.ar(Duty.ar(b=0.1,0,Dseq([0,i%9,2,3,4,0,2,1]*150,9))),b),i%3-1)};wait(i%5+1)}}// #SuperCollider

//--tweet0203
{|i|play{a=LFPulse;HPF.ar(Ringz.ar(a.ar(a.ar(1/(j=i+1)+a.ar(b=(2..5),0,1/b)*b).sum+1*[89,99]*j),2**i*99,0.42).tanh,9)/5}}!4// #SuperCollider

//--tweet0204
play{a=LFSaw;c=(2..22)*99;b=999/c;Splay.ar(MoogFF.ar(a.ar(b*99*a.ar(b*9*a.ar(a.ar(b/9)*b))),(d=a.ar(9/c,9/c))+2*c,d+2.99))}// #SuperCollider

//--tweet0205
a=(1,3..9)*99;fork{inf.do{play{SinOsc.ar(Duty.ar(1/[8,9],0,Dseq(a=wrap(a*9,99,8e3),99)),0,Line.kr(0.2,0,9,1,0,2))};2.wait}}// #SuperCollider

//--tweet0206
a=Blip;play{Splay.ar(Formant.ar(a.ar(9/b=(1..9),a.ar(1/b,b)+2*99,b)+1*[99,400,999,50],a.ar(1/4/b,a.ar(0.2/b,b))*99*b)).sin}// #SuperCollider

//--tweet0207
{|i|play{Normalizer.ar(Saw.ar(i+1*[48.9,49+LFTri.ar(1e-3,i/9,b=1/9)],2pi).sin*tanh(LFTri.ar(b/(i+1),0,2,1).max),b,1e-5)}}!9// #SuperCollider

//--tweet0208
play{a=SinOsc;Splay.ar(Formlet.ar(Blip.ar(a.ar(1/(1..9))*400+99,50),(11,22..66)++50++88*10,a.ar(3).abs,a.ar(pi).abs).clip)}// #SuperCollider

//--tweet0209
play{a=Blip;HPF.ar(Normalizer.ar(Splay.ar(Pluck.ar(a.ar(99*b=LFTri.ar(1/c=(1..9))>0+c,1).abs,a.ar(1/b,2).abs)),1,2e-3),12)}// #SuperCollider

//--tweet0210
a=SinOsc;play{a.ar(0,a.ar(5/3)%1+a.ar(Duty.ar(b=0.15,0,Dseq(a.ar(a.ar(b)/3+0.3).max+1*[[261,440],220,261,349,99,0],inf))))}// #SuperCollider

//--tweet0211
a=LFCub;play{RecordBuf.ar(InFeedback.ar+a.ar(99),b=Buffer.alloc(s,8e4));TGrains.ar(2,a ar:c=[3,2],b,a.ar(1/c)>0/2+1.5,0,3)}// #SuperCollider

//--tweet0212
play{{|i|RecordBuf.ar(Limiter.ar(HPF.ar(Warp1.ar(1,b=LocalBuf(9e3).clear,c=LFSaw.ar(d=1.0009,i).max,1/d)+(c>0/3),9)),b)}!2}// #SuperCollider

//--tweet0213
a=LFPar;play{Splay.ar(GrainFM.ar(1,a.ar(9),a.ar((3..7))%1/9,a.ar(1/(2..8))%1*99,(1..9)*99,a.ar(0.22/(4..6))/2+0.5*9)).tanh}// #SuperCollider

//--tweet0214
play{a=LFTri;c=a.ar(3**a.ar(1/b=(9..1),b/9));Splay.ar(GrainSin.ar(2,c,a.ar(1/b)%1/9+0.01,2**a.ar(b/99).round*99*b).tanh)/2}// #SuperCollider

//--tweet0215
play{a=LFTri;BufWr.ar(a.ar(1),b=LocalBuf(c=7e4).clear,a.ar(1.005)*c);Splay.ar(HPF.ar(BufRd.ar(1,b,a.ar([5,1,2,4])*c),9))/2}// #SuperCollider

//--tweet0216
play{a=LFSaw;Mix(SinOsc.ar(3**Hasher.ar(round(a.ar(0.1)%1,c=(3..1)/16))*(a.ar(c,c)<0*[6,2,1]+[4,[5,5.05],3]*99))).softclip}// #SuperCollider

//--tweet0217
a=LFSaw;play{Splay.ar(BBandPass.ar(a.ar(3.7*b=1/(1..16),0,a.ar(99+b,0,a.ar(b*c=0.055).max)),4**a.ar(b/8)*99+99,c,20).tanh)}// #SuperCollider

//--tweet0218
play{a=LFTri;Splay.ar(a.ar(99*(b=a.ar(a.ar(c=1/(1..9))*9)>0.5)/2+Demand.ar(Stepper ar:b,0,Dseq(99/c,inf)).lag3+a.ar(c)))/2}// #SuperCollider

//--tweet0219
a=SinOsc;play{Splay ar:a.ar(HPF.ar(Ringz.ar(a.ar(b=1/[3,12,4,1,6,2]).lag3(a.ar(2.67**b).abs)*99,a.ar(1/b/9,b)>0*20+99/b)))}// #SuperCollider

//--tweet0220
a=SinOsc;play{RecordBuf.ar(c=InFeedback.ar,b=Buffer.alloc(s,9e4));HPF.ar(a.ar(99,c*6)/9+TGrains.ar(2,a ar:3,b,c+3,2,12),9)}// #SuperCollider

//--tweet0221
a=SinOsc;play{tanh((c=InFeedback.ar(0,2))+HPF.ar(a.ar(b=1/[5,4],a.ar(a.ar(b*1.1,a.ar(b*2))+a.ar(b*1.4,c,5,4).ceil*99)),9))}// #SuperCollider

//--tweet0222
a=SinOscFB;play{((c=InFeedback.ar(0,2).lag(b=1/67))+DelayL.ar(HPF.ar(a.ar([99,98]*50.666*a.ar(c+b*b,c),c%2),50),b,b)).tanh}// #SuperCollider

//--tweet0223
a=LFSaw;play{Splay.ar(BPF.ar(a.ar(f=Duty.ar(a.ar(a.ar(c=3/d=(2..6)))*a.ar(d)/c,0,Dseq(ceil(a ar:d)+d*99,inf))+a.ar(c)),f))}// #SuperCollider

//--tweet0224
a=SinOsc;play{d=BufRd.ar(2,b=LocalBuf(c=2e5,2).clear,a.ar([2,3]*9)*c,0);BufWr.ar(a.ar(3/[2,3])/3,b,a.ar([99,145]).abs*c);d}// #SuperCollider

//--tweet0225
a=LFSaw;play{b=(1..8)*99;Splay.ar(CombN.ar(Blip.ar(b/2+a.kr(-8/b,1,99),b/4+a.kr(1/b,1,99))*SinOsc.ar(8/b,a.ar(99/b)))).sin}// #SuperCollider

//--tweet0226
play{a=SinOsc;LocalOut.ar(b=a.ar(0.5,Peak.ar(c=LocalIn ar:2,d=a.ar(9/[2,3]))*a.ar(5e-3)*9));HPF.ar(b+a.ar(0,d.max+c*99),9)}// #SuperCollider

//--tweet0227
play{a=LFPulse;f=SinOsc;b=a.ar(a.ar(4/3)*4).lag2(0.01);Splay.ar(f.ar(d=lag(99**b*a.ar(c=2/(6..9))))+f.ar(d*b/c,b*d,1-c))/4}// #SuperCollider

//--tweet0228
play{a=LFSaw;Splay ar:HPF.ar(MoogFF.ar(a.ar(50*b=(0.999..9))-Blip.ar(a.ar(b)+9,b*99,9),a.ar(b/8)+1*999,a.ar(b/9)+1*2),9)/3}// #SuperCollider

//--tweet0229
play{a=LFPulse;b=(1..9);Splay.ar(CombN.ar(a.ar(b*99*a.ar(b)).reduce('&'),2,2/b,2))+BPF.ar(a.ar(4)*4,a.ar(2)+[1,2]*99,0.12)}// #SuperCollider

//--tweet0230
play{Splay.ar(CombC.ar(PinkNoise.ar(Ringz.ar(LFSaw.ar(b=(1..9)/16),b*999,1.25)),1,1/(b*999)*(LFTri.ar(b/120,b*2)%1),3))/99}// #SuperCollider

//--tweet0231
play{a=LFSaw;Splay.ar(Pluck.ar(a.ar(30*c=(5..7))*a.ar(b=1/[25,14]),a.ar([3,2]),0.02,a.ar(c/66)+1/7,9,a.ar(1/c)%1,3).sin)/2}// #SuperCollider

//--tweet0232
a=SinOsc;play{CombC.ar(a.ar(Duty.ar(1/b=[4,3],0,Dseq(9.fib.pyramid*99,inf)))*a.ar(b/9),1.01,a.ar(b/999).abs+0.01,9).tanh/2}// #SuperCollider

//--tweet0233
play{a=LFTri;Splay.ar(a.ar(Duty.ar(b=1/[1,4,6,8,11],c=a.kr(b/98),Dseq(Select.kr(a.kr(b/99)+c*5,1/b+59),inf).midicps)+c)/2)}// #SuperCollider

//--tweet0234
play{a=LFPulse;Splay.ar(a.ar((99*b=[1,4,5,8])*lag(a.ar(a.ar(4/b)+a.ar(9-b/9)*50))+b)/2)+Mix(GrayNoise.ar(a.ar(b,0,0.1))/9)}// #SuperCollider

//--tweet0235
play{a=SinOsc;Splay.ar(a.ar(CompanderD.ar(Duty.ar(c=a.ar(b=(1,3..13),b,b,b),0,Dseq(b,inf)),5,4,3,c)*99,a.ar(b*9)*9,2)).sin}// #SuperCollider

//END OF SCTWITTZZZ
//END OF SCTWITTZZZ
//END OF SCTWITTZZZ
