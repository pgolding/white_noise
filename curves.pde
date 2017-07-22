PImage img;  // Declare variable "a" of type PImage
int image = 1;
String file;
Wave myWave;
float w;
float h;
int pt = 3200;
int[] X = new int[pt];
int[] Y = new int[pt];
int max = 10;
int[] st = new int[max*2];
int ww = 0;
String FOLDER = "./source_images/";

void setup() {
  //size(1920, 1080);
  size(600,800);
  //size(960,540);
  background(0);
  // The image file must be in the data folder of the current sketch 
  // to load successfully
  if(image == 1) file = FOLDER + "mlk_layers.jpg";
  if(image == 2) file = FOLDER + "trump.png"; 
  if(image == 3) file = FOLDER + "meme.png";
  if(image == 4) file = FOLDER + "jk.png";
  if(image == 5) file = FOLDER + "mlk.jpg";
  
   img = loadImage(file);  // Load the image into the program  
   //img.loadPixels();
   //w = random(img.width);
   //h = random(img.width);
   
  //frameRate(10);
  
  //slide();
  float freq = 5;
  float amplitude = 10;
  float step = 2;
  int shift = 1;
  float rotate = 0;
  //ptz(freq,amplitude,step,shift, rotate);
  //saveFrame("joker_f=" + freq + "_a=" + amplitude + "_s=" + step + "_shift=" + shift + "_r=" + rotate + ".png");
  rand_points(img,-1,-1,-1,-1);
  //rand_points(img,100,100,450,500);
  sawtooth();
}




void draw() {
  image(img, 0, 0);
  float r = (random(1))-(random(1.5));
  float rot = random(0.5);
  ptz(5,2*st[ww],r,3,rot,false);
  ww++;
  //print(st[ww]);
  if (ww==st.length-1){
    ww = 0;}
}

void sawtooth(){
  for(int i = 0; i<max; i++){
    st[i] = i+1;
  }
  for(int i = max; i<2*max; i++){
    st[i] = 2*max-i;
  }
  //print(st);
}

void rand_points(PImage img, int xl, int yl, int xr, int yr) {
  //img.loadPixels();
  for (int i=0; i<pt; i++) {
    if(xl==-1 && xr==-1){
      X[i] = int(random(img.width));
    } else {
      X[i] = int(random(xl,xr));
    }
    if(yl==-1 && yr==-1) {
      Y[i] = int(random(img.height));
    } else {
      Y[i] = int(random(yl,yr));
    }
  }
}

void ptz(float f, float a, float s, int shift, float rotate, boolean bg, boolean shape) {
  
  
  if (bg) background(0);
  //smooth();
  //img.loadPixels();
    
  for(int i=0; i<pt; i++) {
    
  // Pick a random point
  //int x = int(random(img.width));
  int x = X[i];
  //int y = int(random(img.height));
  int y = Y[i];
  int loc = x + y*img.width;
  
  // Look up the RGB color in the source image
  //img.loadPixels();
  float r = red(img.pixels[loc]);
  float g = green(img.pixels[loc]);
  float b = blue(img.pixels[loc]);
  
  noStroke();
  
  // Optionally - draw an ellipse at that location with that color
  if (shape) {
    int pointillize = int(random(3,35));
    fill(r,g,b,100);
    ellipse(x,y,pointillize,pointillize);
  }
  
  // draw a wave at that position
   if(r>0) { 
     float rd = 10;//random(1,50);
     float edge = 5;
     if(rd < edge) {    
       int sh = 4;
       if(rd < edge/2) sh = -4;
      myWave = new Wave(x,y,r,g,b,f/2,a/rd,s,shift-sh,rotate,20*TWO_PI);}
     else {
       myWave = new Wave(x,y,r,g,b,f,a,s,0,rotate,TWO_PI);
     }
      myWave.display();
     
   
 
 }
  }
  
}

class Pair<T> {
  private final T X;
  private final T Y;
  public Pair(T first, T second) {
    X = first;
    Y = second;
  }
  public T X() {
    return X;
  }
  public T Y() {
    return Y;
}
}

class Wave {

  int x;
  int y;
  float r;
  float g;
  float b;
  float freq;
  float amplitude;
  float step;
  int shift = 1;
  float rotate = 0;
  float period = TWO_PI;
  
  Wave(int _x, int _y, float _r, float _g, float _b, float _f, float _a, float _s, int _shift, float _rotate, float _period) {
    x = _x; y = _y; r = _r; g = _g; b = _b; 
    freq = _f; amplitude = _a; step = _s;
    shift = _shift; rotate = _rotate; period = _period;
    
  }
  
  void display() {
    noFill();
    stroke(color(r,g,b));
    pushMatrix();
    float x_s = x - shift*(TWO_PI/0.2)*step;
    translate(x_s,y);
    rotate(rotate);
    //scale(2.0);
    beginShape();
    /*
    curveVertex(20, 20); // the first control point
    curveVertex(20, 20); // is also the start point of curve
    curveVertex(40, 30);
    curveVertex(50, 50);
    curveVertex(30, 60);
    curveVertex(25, 75); // the last point of curve
    curveVertex(25, 75); // is also the last control point
    */
    float x = 0;
    for (float a = 0; a < period; a += 0.1) {
      vertex(x,amplitude*sin(freq*a));
      x+=step;
    }
    endShape();
    popMatrix();

  }
}