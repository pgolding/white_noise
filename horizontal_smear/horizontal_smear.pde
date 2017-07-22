PImage img;  // Declare variable "a" of type PImage

int numIterations = 1;
int step = 20;
int image = 2;
String file;

void setup() {
  size(600, 600);
  // The image file must be in the data folder of the current sketch 
  // to load successfully
  if(image == 1) file = "lines.jpg";
  if(image == 2) file = "trump.png"; 
  if(image == 3) file = "meme.png";
  
   img = loadImage(file);  // Load the image into the program  
  
  numIterations = int(random(1,10));
      background(255);
    for(int iterations = 0; iterations < numIterations; iterations++) {
  int seed = int(30+random(60));
     loadPixels(); 
  // Since we are going to access the image's pixels too  
  img.loadPixels(); 
  for (int y = 0; y < height; y++) {
    for (int x = 0; x < width; x++) {
      int loc = x + y*width;
      
      float r = red(img.pixels[loc]);
      int p = int(random(20,seed));
      int coloff = 100;
      if(r<255.0) {
        pixels[loc+int( (10*(iterations+1))*sin( radians(y) * 2 ) ) ] = color(r+coloff,r+coloff,r+coloff); 
        //pixels[loc-int( (10*(iterations+1))*sin( radians(y) ) ) ] = color(r+coloff,r+coloff,r+coloff); 
        step = step+10;
      }        
    }
  }
  updatePixels();
  //saveFrame("meme_y" + str(iterations) + ".png"); 

    }
  

}

void draw() {

  

}


