color bgC       = #2F2F2F;
String dataPATH = "../../data/";

// ================================================================

import ddf.minim.*;
import ddf.minim.analysis.*;

// ================================================================

Minim minim;
AudioInput audio;
FFT audioFFT;

// ================================================================

int audioRange 	= 8;
int audioMax = 100;

float audioAmp = 2200.0;
float audioIndex = 0.05;
float audioIndexAmp = audioIndex;
float audioIndexStep = 0.025;

float[] audioData = new float[audioRange];

int rectS 			= 20;

// ================================================================

int stageM			= 100;
int stageW      = 700;
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
	audioLab.audioSettings();
}	

// ================================================================


// ================================================================
void draw() {
	background(bgC);
	audioLab.audioDataUpdate();
}

// ================================================================

void stop() {
	audio.close();
	minim.stop();
	super.stop();
}

// ================================================================

