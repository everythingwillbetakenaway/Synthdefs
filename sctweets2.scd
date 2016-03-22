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
{r=44100;BufRd.ar(1,Buffer.read(s,"s*/*".pathMatch[2]),[r,r+500]*LFNoise0.ar(8,9,9)+(Sweep.ar(t=Impulse.ar(8),r)%TRand.ar(100,r/2,t)))}.play
play{i=Impulse.ar(_);SinOsc.ar(i.(2).lagud(0,0.4)*360,Integrator.ar(Integrator.ar(i.(64).lag(LFNoise1.ar(2!2,2,2))*99,0.9),0.99).fold2(pi))}
play{Splay.ar(Integrator.ar(LFNoise0.ar(5!3,k=Duty.ar(6.4,0,Dseq([0.05,Drand([0.04,0.08],1)],inf))).round(k/10)).sin.sqrt.tanh,0.3)}//#sc...
play{LocalOut.ar(k=LeakDC.ar(Integrator.ar(Pulse.ar(pi/[1,2.57],[0.54,0.46]),(1-LocalIn.ar(2)).fold(0,[0.9,0.85])).wrap2(pi).sin));k.mean!2}
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
