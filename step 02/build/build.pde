color bgC       = #2F2F2F;
String dataPATH = "../../data/";

// ================================================================

import ddf.minim.*;

// ================================================================

Minim minim;
AudioPlayer audio;

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
}	

// ================================================================
void draw() {
	background(bgC);

	// stroke(#0066AA); noFill();
	// line(0, stageM, width, stageM);
	// line(stageM, 0, stageM, height);
	// line(width - stageM, 0, width - stageM, height);
	
	stroke(#DD6600); noFill();
	line(0, stageM + 100, width, stageM + 100);

	for (int i = 0; i < audioRange; ++i) {
		stroke(0); fill(255);
		rect(xStart + (i * xSpace), yStart, rectS, rectS);
	}
}

// ================================================================

void stop() {
	audio.close();
	minim.stop();
	super.stop();
}

// ================================================================

