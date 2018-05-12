color bgC       = #2F2F2F;
String dataPATH = "../../data";

// ================================================================

int audioRange 	= 256;

// ================================================================

int stageM			= 100;
int stageW      = (audioRange*2) + (stageM*2);
int stageH      = 300;

// ================================================================

void settings(){ 
	size(stageW, stageH);
}

// ================================================================

void setup() {
	background(bgC);
}

// ================================================================
void draw() {
	background(bgC);

	stroke(#0066AA); noFill();
	line(0, stageM, width, stageM);
	line(stageM, 0, stageM, height);
	line(width - stageM, 0, width - stageM, height);
	
	stroke(#DD6600); noFill();
	line(0, stageM + 100, width, stageM + 100);
}
