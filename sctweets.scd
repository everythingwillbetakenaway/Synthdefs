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

[ [ 256, 144 ], [ 128, 72 ], [ 256, 144 ], [ 128, 162 ], [ 256, 144 ], [ 128, 450 ], [ 256, 144 ], [ 128, 648 ], [ 256, 144 ], [ 216, 72 ], [ 256, 144 ], ...etc....

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






mathk

// Original tweet by mathk
// http://swiki.hfbk-hamburg.de:8888/MusicTechnology/899

{k=LFNoise1.kr(8.0.rand+2,0.5,0.5);SinOsc.ar([[333,444],[222,555]]*(k+(rrand(1.0,5.0))),0,k).sum.cubed * 0.1}.play
// #supercollider #babies

mutantsounds

// Original tweet by mutantsounds
// http://swiki.hfbk-hamburg.de:8888/MusicTechnology/899

{x=Array.fill(5,{[0.00001,0.03].asSpec.map(LFNoise2.kr(3))});Splay.ar(Friction.ar(LFTri.ar(50),friction:x,mass:x*30000))}.play
