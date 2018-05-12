import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

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
String dataPATH = "../../data";

// ================================================================

int audioRange 	= 256;

// ================================================================

int stageM			= 100;
int stageW      = (audioRange*2) + (stageM*2);
int stageH      = 300;

// ================================================================

public void settings(){ 
	size(stageW, stageH);
}

// ================================================================

public void setup() {
	background(bgC);
}

// ================================================================
public void draw() {
	background(bgC);

	stroke(0xff0066AA); noFill();
	line(0, stageM, width, stageM);
	line(stageM, 0, stageM, height);
	line(width - stageM, 0, width - stageM, height);
	
	stroke(0xffDD6600); noFill();
	line(0, stageM + 100, width, stageM + 100);
}
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "build" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
