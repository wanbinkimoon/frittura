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

int audioRange 	= 10;
int audioMax = 100;

float audioAmp = 240.0;
float audioIndex = 0.035;
float audioIndexAmp = audioIndex;
float audioIndexStep = 0.25;

int rectS 			= 50;

// ================================================================

int stageM			= 100;
int stageW      = (audioRange * rectS) + (stageM * 2);
int stageH      = 700;

// ================================================================



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
	audio = minim.loadFile( dataPATH + "beat_3.wav");
	// audio.loop();
	audio.play();

	audioFFT = new FFT(audio.bufferSize(), audio.sampleRate());
	audioFFT.linAverages(audioRange);

	audioFFT.window(FFT.NONE);
}	

// ================================================================
void draw() {
	// background(bgC);

	// stroke(#0066FF); noFill();
	// line(0, stageM, width, stageM);
	// line(stageM, 0, stageM, height);
	// line(width - stageM, 0, width - stageM, height);

	audioFFT.forward(audio.mix);

	for (int i = 0; i < audioRange; ++i) {
		float indexAvg = (audioFFT.getAvg(i) * audioAmp) * audioIndexAmp;
		float indexCon = constrain(indexAvg, 0, audioMax);

		stroke(0); fill(255, 5);
		rect(xStart + (i * xSpace), yStart, rectS, indexAvg);

		audioIndexAmp += audioIndexStep;			
	}

	audioIndexAmp = audioIndex;

	stroke(#DD6600); noFill();
	line(0, stageM + 100, width, stageM + 100);
}

// ================================================================

void stop() {
	audio.close();
	minim.stop();
	super.stop();
}

// ================================================================

