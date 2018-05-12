import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import ddf.minim.*; 
import ddf.minim.analysis.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class build extends PApplet {

int bgC       = 0xff2F2F2F;
String dataPATH = "../../data/";

// ================================================================




// ================================================================

Minim minim;
AudioPlayer audio;
FFT audioFFT;

// ================================================================

int audioRange 	= 256;
float audioAmp = 25.0f;

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

public void settings(){ 
	size(stageW, stageH);
}

// ================================================================

public void setup() {
	background(bgC);

	minim = new Minim(this);
	audio = minim.loadFile( dataPATH + "elephant.wav");
	audio.loop();

	audioFFT = new FFT(audio.bufferSize(), audio.sampleRate());
	audioFFT.linAverages(audioRange);

}	

// ================================================================
public void draw() {
	background(bgC);

	// stroke(#0066AA); noFill();
	// line(0, stageM, width, stageM);
	// line(stageM, 0, stageM, height);
	// line(width - stageM, 0, width - stageM, height);

	audioFFT.forward(audio.mix);

	for (int i = 0; i < audioRange; ++i) {
		float indexAvg = audioFFT.getAvg(i) * audioAmp;

		stroke(0); fill(255);
		rect(xStart + (i * xSpace), yStart, rectS, indexAvg);
	}

	stroke(0xffDD6600); noFill();
	line(0, stageM + 100, width, stageM + 100);
	stroke(0xffDD0066); noFill();
	bezier(stageM, stageM + 100, stageM, stageM, width - stageM, stageM, width - stageM, stageM);
}

// ================================================================

public void stop() {
	audio.close();
	minim.stop();
	super.stop();
}

// ================================================================

  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "build" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
