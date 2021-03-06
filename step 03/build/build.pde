color bgC       = #2F2F2F;
String dataPATH = "../../data/";

// ================================================================

import ddf.minim.*;
import ddf.minim.analysis.*;

// ================================================================

Minim minim;
AudioPlayer audio;
FFT audioFFT;

// ================================================================

int audioRange 	= 256;

// ================================================================

int stageM			= 100;
int stageW      = (audioRange*2) + (stageM*2);
int stageH      = 300;

// ================================================================

int rectS 			= 2;

int xStart 			= stageM;
int yStart 			= stageM;
int xSpace			= rectS;

// ================================================================

void settings(){ 
	size(stageW, stageH);
}

// ================================================================

void setup() {
	background(bgC);

	minim = new Minim(this);
	audio = minim.loadFile( dataPATH + "sorry_dave.wav");
	audio.loop();

	audioFFT = new FFT(audio.bufferSize(), audio.sampleRate());
	audioFFT.linAverages(audioRange);

}	

// ================================================================
void draw() {
	background(bgC);

	// stroke(#0066AA); noFill();
	// line(0, stageM, width, stageM);
	// line(stageM, 0, stageM, height);
	// line(width - stageM, 0, width - stageM, height);

	audioFFT.forward(audio.mix);

	
	stroke(#DD6600); noFill();
	line(0, stageM + 100, width, stageM + 100);

	for (int i = 0; i < audioRange; ++i) {
		float indexAvg = audioFFT.getAvg(i);

		stroke(0); fill(255);
		rect(xStart + (i * xSpace), yStart, rectS, indexAvg);
	}
}

// ================================================================

void stop() {
	audio.close();
	minim.stop();
	super.stop();
}

// ================================================================

