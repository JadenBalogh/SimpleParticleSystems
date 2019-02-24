ParticleSystem rain;
PointParticleSystem p;
CircleParticleSystem fireCircle;
int r, g, b;
int e = 10;
float x = 0, y = 0;
float dx = 2;

void setup()
{
  //fullScreen();
  size(1200, 800);
  rain = new ParticleSystem("SoundParticle.png", true, 50, 20, color(0, 155, 155), 10, 0, 0, 0, 0, 0, 0, 0.2, 0.2);
  //PointParticleSystem(String spriteFilepath, boolean active, float emissionRate, 
  //    int particleSize, float scaleOverLifetime, float spawnOriginX, float spawnOriginY, 
  //    float minLifetime, float maxLifetime, color tint)
  p = new PointParticleSystem("Particle.png", true, 100,
      20, 0.5, width/2, height/2,
      2, 3, color(255));
  //CircleParticleSystem(String spriteFilepath, boolean active, float emissionRate, 
  //  int particleSize, float scaleOverLifetime, float spawnOriginX, float spawnOriginY, 
  //  float spawnRangeMin, float spawnRangeMax, float spawnAngleMin, float spawnAngleMax, 
  //  float velocityRangeMin, float velocityRangeMax, float minLifetime, float maxLifetime, 
  //  color tint)
  fireCircle = new CircleParticleSystem("FireParticle.png", true, 300, 
    20, 1, width/2, height/2, 
    100, 100, 0, 2*PI, 
    0, 0, 20, 20,
    5, 8, color(255, 100, 0));
  colorMode(HSB);
}

void draw()
{
  Timer.update(millis());
  background(0);
  //x+=dx; if (x > width) x = 0;
  //y = height*noise(x*0.01);
  fireCircle.update();
  rain.update();
  p.setSpawnOrigin(mouseX, mouseY);
  p.update();
  println(frameRate);
}

void keyPressed()
{
  if (key == ' ')
    fireCircle.setActive(!fireCircle.isActive());
}

void mousePressed()
{
   if (mouseButton == LEFT)
   {
     e += 10;
     fireCircle.setEmissionRate(e);
   }
}
