import peasy.*;

PeasyCam camera;

PImage imageToProject;
int[] pixels;

void settings() {
  size(900, 900, P3D);
}

void setup() {
  pixels = loadImageToProject();
  camera = new PeasyCam(this, width / 2, height / 2, 0, 300);
}

void draw() {
  background(0);
  lights();

  translate(width / 2, height / 2);

  for(int x = -150; x < 150; x++) {
    for (int y = -150; y < 150; y++) {
      if(sq(x) + sq(y) <= sq(150)) {
        stroke(pixels[(x + 150) + 300 * (y + 150)]);

        float resizedX = lerp(-1, 1, (x + 150.0) / 299.0);
        float resizedY = lerp(-1, 1, (y + 150.0) / 299.0);

        float denominator = sq(resizedX) + sq(resizedY) + 1.0;

        float projectionX = (2.0 * resizedX) / denominator;
        float projectionY = (2.0 * resizedY) / denominator;
        float projectionZ = (1.0 - sq(resizedX) - sq(resizedY)) / denominator;

        point(projectionX * 150, projectionY * 150, projectionZ * 150);
        point(x, y, 350);
      }
    }
  }
}

int[] loadImageToProject() {
  imageToProject = loadImage("./Images/imageToProject_1.jpg");
  imageToProject.resize(300, 0);
  imageToProject.loadPixels();

  return imageToProject.pixels;
}
