int stageW      = 600;
int stageH      = 600;
color bgC       = #2e2e2e;
String dataPATH = "../../data";

// ================================================================

boolean letsRender = false;
int     renderNum  = 0;
String  renderPATH = "../render/";

// ================================================================

import hype.*;
import hype.extended.behavior.*;
import hype.extended.colorist.*;
import hype.extended.layout.*;
import hype.interfaces.*;

import peasy.*;
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

void settings(){ 
	size(stageW,stageH,P3D);
}

// ================================================================

void setup() {
	colors_1 = new HColorPool(#ed6b5a, #f4f1bc, #9bc1bb, #5aa3a8, #e5eade);
	colors_2 = new HColorPool(#bad7f2, #ffafce, #ff9f7c, #ffe299, #aad19c);
	
	H.init(this).background(bgC).use3D(true);
	smooth();

	int rects = 4;

	for (int i = 1; i < rects; ++i) {
		for (int j = 1; j < rects; ++j) {
			for (int k = 1; k < rects; ++k) {
				
				d = new HSphere();

				selector = ((k + j + i) % 2 == 1);

				_r = 50.0;
				bounce = 25;
				dist = 25.0;
				grid = dist + _r;
				area = (_r + grid) * rects;

				x = map(i * _r, 0, rects * _r, -area, area);
				y = map(j * _r, 0, rects * _r, -area, area);
				z = map(k * _r, 0, rects * _r, -area, area);
				
				alpha = 255;
				color fgC = selector ? color(colors_1.getColor(), alpha) : color(colors_2.getColor(), alpha);
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
					.speedY(random(-.5, .5));

				new HOscillator()
					.target(d)
					.property(H.SIZE)
					.relativeVal(_r)
					.range( _r - bounce, _r + bounce)
					.speed(random(0, .2))
					.freq(10);

				H.add(d);
				
			}
		}
	}

cam = new PeasyCam(this, 600);
}

// ================================================================
void draw() {
	// lights();

	H.drawStage();

	if (letsRender) {
		letsRender = false;
		save(renderPATH + renderNum + ".png");
		renderNum++;
	}
}


void keyPressed() {
	switch (key) {
		case 'p':
			letsRender = true;
		break;
	}
}
