
//Server.default = s = Server.local;
//s.options.outDevice = "Forte";
//s.options.inDevice = "Forte";

//s.options.outDevice = "Built-in Output";
//s.options.inDevice = "Built-in Microph";
Server.default.latency = 0.001;
s.options.blockSize = 128;
s.options.sampleRate = 44100;
s.options.memSize_(pow(2, 18));
s.options.numOutputBusChannels = 2;
s.options.numInputBusChannels = 2;
Server.local.options.memSize = pow(2, 18);
s.options.numWireBufs = 256;


MIDIIn.connectAll;


(
s.boot;
s.waitForBoot({
	"/Users/EmanTnuocca/Documents/SC CODES/defs/initials.scd".load;
	"/Users/EmanTnuocca/Documents/SC CODES/defs/THE WITCH PLANE.scd".load;
	"/Users/EmanTnuocca/Documents/SC CODES/defs/Lumbricost.scd".load;
	"/Users/EmanTnuocca/Documents/SC CODES/defs/Appajax-2000.scd".load;
	"/Users/EmanTnuocca/Documents/SC CODES/defs/Massaka.scd".load;
	"/Users/EmanTnuocca/Documents/SC CODES/defs/SumanGuru.scd".load;
	"/Users/EmanTnuocca/Documents/SC CODES/defs/acid.scd".load;
	"/Users/EmanTnuocca/Documents/SC CODES/defs/p5pwm.scd".load;
	"/Users/EmanTnuocca/Documents/SC CODES/defs/DrumSmpl.scd".load;
	"/Users/EmanTnuocca/Documents/SC CODES/defs/SOSkick.scd".load;
	"/Users/EmanTnuocca/Documents/SC CODES/defs/SOSsnare.scd".load;
	"/Users/EmanTnuocca/Documents/SC CODES/defs/SOStom.scd".load;
	"/Users/EmanTnuocca/Documents/SC CODES/defs/SOShats.scd".load;
	"/Users/EmanTnuocca/Documents/SC CODES/defs/Etna.scd".load;
	"e".speak;	// //Welcome to the system #QA402.O66. Marshal Aziz Eggeh. Server is waiting for your command.".speak;

});
)


// // Get the local server's options
//
// o = Server.local.options;
//
// // Post the number of output channels
//
// o.numOutputBusChannels.postln;
//
// // Set them to a new number
//
// o.numOutputBusChannels = 24; // The next time it boots, this will take effect


