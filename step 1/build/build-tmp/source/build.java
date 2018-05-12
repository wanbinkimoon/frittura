import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import hype.*; 
import hype.extended.behavior.*; 
import hype.extended.colorist.*; 
import hype.extended.layout.*; 
import hype.interfaces.*; 
import peasy.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class build extends PApplet {

int stageW      = 600;
int stageH      = 600;
int bgC       = 0xff2e2e2e;
String dataPATH = "../../data";

// ================================================================

boolean letsRender = false;
int     renderNum  = 0;
String  renderPATH = "../render/";

// ================================================================








PeasyCam cam;
HDrawable3D d;
HColorPool colors_1;
HColorPool colors_2;
HRotate r;

float x;
float y;
float z;
float _r;
int bounce;

int alpha;
float dist;
float grid;
float area;
boolean selector;

int changes;
float target;

// ================================================================

public void settings(){ 
	size(stageW,stageH,P3D);
}

// ================================================================

public void setup() {
	colors_1 = new HColorPool(0xffed6b5a, 0xfff4f1bc, 0xff9bc1bb, 0xff5aa3a8, 0xffe5eade);
	colors_2 = new HColorPool(0xffbad7f2, 0xffffafce, 0xffff9f7c, 0xffffe299, 0xffaad19c);
	
	H.init(this).background(bgC).use3D(true);
	

	int rects = 4;

	for (int i = 1; i < rects; ++i) {
		for (int j = 1; j < rects; ++j) {
			for (int k = 1; k < rects; ++k) {
				
				d = new HSphere();

				selector = ((k + j + i) % 2 == 1);

				_r = 50.0f;
				bounce = 25;
				dist = 25.0f;
				grid = dist + _r;
				area = (_r + grid) * rects;

				x = map(i * _r, 0, rects * _r, -area, area);
				y = map(j * _r, 0, rects * _r, -area, area);
				z = map(k * _r, 0, rects * _r, -area, area);
				
				alpha = 255;
				int fgC = selector ? color(colors_1.getColor(), alpha) : color(colors_2.getColor(), alpha);
				changes = selector ? H.Z : H.Y;
				target = selector ? z: y;

				d
					.size(_r)
					.loc(x,y,z)
					.anchorAt(H.CENTER)
					// .fill(fgC)
					.stroke(fgC)
					.noFill();

				new HRotate()
					.target(d)
					.speedY(random(-.5f, .5f));

				new HOscillator()
					.target(d)
					.property(H.SIZE)
					.relativeVal(_r)
					.range( _r - bounce, _r + bounce)
					.speed(random(0, .2f))
					.freq(10);

				H.add(d);
				
			}
		}
	}

cam = new PeasyCam(this, 600);
}

// ================================================================
public void draw() {
	// lights();

	H.drawStage();

	if (letsRender) {
		letsRender = false;
		save(renderPATH + renderNum + ".png");
		renderNum++;
	}
}


public void keyPressed() {
	switch (key) {
		case 'p':
			letsRender = true;
		break;
	}
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
