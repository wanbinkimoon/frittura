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
	audioSettings();
}	

// ================================================================

void audioSettings(){
	minim = new Minim(this);
  audio = minim.getLineIn(Minim.STEREO);

	audioFFT = new FFT(audio.bufferSize(), audio.sampleRate());
	audioFFT.linAverages(audioRange);

  audioFFT.window(FFT.NONE);
  // audioFFT.window(FFT.BARTLETT);
  // audioFFT.window(FFT.BARTLETTHANN);
  // audioFFT.window(FFT.BLACKMAN);
  // audioFFT.window(FFT.COSINE);
  // audioFFT.window(FFT.GAUSS);
  // audioFFT.window(FFT.HAMMING);
  // audioFFT.window(FFT.HANN);
  // audioFFT.window(FFT.LANCZOS);
  // audioFFT.window(FFT.TRIANGULAR);
}

// ================================================================
void draw() {
	background(bgC);
	audioDataUpdate();
}

// ================================================================

void audioDataUpdate(){
	audioFFT.forward(audio.mix);
	for (int i = 0; i < audioRange; ++i) {

		float indexAvg = (audioFFT.getAvg(i) * audioAmp) * audioIndexAmp;
		float indexCon = constrain(indexAvg, 0, audioMax);

		audioData[i] = indexCon;
		audioIndexAmp += audioIndexStep;
		
	}

		audioIndexAmp = audioIndex;

		println(audioData);
}

// ================================================================

void stop() {
	audio.close();
	minim.stop();
	super.stop();
}

// ================================================================

