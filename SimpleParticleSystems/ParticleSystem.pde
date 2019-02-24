public class ParticleSystem
{
  private ArrayList<Particle> particles;
  private PImage sprite;
  private boolean active;
  private int particleSize;
  private color tint;
  private float maxScale;
  private float spawnDelay;
  private float spawnTimer;
  private float spawnOriginX, spawnOriginY;
  private float spawnRangeX, spawnRangeY;
  private float minVelocity, maxVelocity;
  private float minLifetime, maxLifetime;

  public ParticleSystem(String spriteFilepath)
  {
    this(spriteFilepath, true, 10, 20, 255, 1, 0, 0, 0, 0, 1, 2, 1, 3);
  }

  public ParticleSystem(String spriteFilepath, boolean active, float emissionRate, int particleSize, color tint, float maxScale, float spawnOriginX, float spawnOriginY, 
    float spawnRangeX, float spawnRangeY, float minVelocity, float maxVelocity, 
    float minLifetime, float maxLifetime)
  {
    particles = new ArrayList<Particle>();
    setParticleSize(particleSize);
    setTint(tint);
    setEmissionRate(emissionRate);
    setMaxScale(maxScale);
    setSpawnOrigin(spawnOriginX, spawnOriginY);
    setSpawnRange(spawnRangeX, spawnRangeY);
    setVelocityRange(minVelocity, maxVelocity);
    setLifetimeRange(minLifetime, maxLifetime);
    setSprite(spriteFilepath);
    setActive(active);
  }

  public void spawnParticle()
  {
    float spawnPositionX = spawnOriginX + random(-spawnRangeX, spawnRangeX);
    float spawnPositionY = spawnOriginY + random(-spawnRangeY, spawnRangeY);
    float spawnVelocityX = random(minVelocity, maxVelocity) * cos(random(0, 2*PI));
    float spawnVelocityY = random(minVelocity, maxVelocity) * sin(random(0, 2*PI));
    float lifetime = random(minLifetime, maxLifetime);
    //particles.add(new Particle(this, sprite, tint, maxScale, spawnPositionX, spawnPositionY, spawnVelocityX, spawnVelocityY, lifetime));
  }

  public void update()
  {
    spawnTimer += Timer.deltaTime;
    if (spawnTimer > spawnDelay && active)
    {
      int spawnCount = (int)(spawnTimer/spawnDelay);
      for (int i = 0; i < spawnCount; i++)
        spawnParticle();
        
      spawnTimer = 0;
    }

    for (int i = 0; i < particles.size(); i++)
    {
      particles.get(i).update();
    }
  }

  public void destroy(Particle particle)
  {
    particles.remove(particle);
  }

  public void setSprite(String spriteFilepath)
  {
    PImage sprite = loadImage(spriteFilepath); 
    sprite.resize(particleSize, particleSize);
    this.sprite = sprite;
  }

  public boolean isActive()
  {
    return active;
  }

  public boolean getActive()
  {
    return active;
  }

  public void setActive(boolean active)
  {
    this.active = active;
  }

  public void setParticleSize(int particleSize)
  {
    this.particleSize = particleSize;
  }

  public void setTint(color tint)
  {
    this.tint = tint;
  }
  
  public void setEmissionRate(float emissionRate)
  {
    spawnDelay = 1.0 / emissionRate;
  }

  public void setMaxScale(float maxScale)
  {
    this.maxScale = maxScale;
  }

  public void setSpawnOrigin(float spawnOriginX, float spawnOriginY)
  {
    this.spawnOriginX = spawnOriginX;
    this.spawnOriginY = spawnOriginY;
  }

  public void setSpawnRange(float spawnRangeX, float spawnRangeY)
  {
    this.spawnRangeX = spawnRangeX;
    this.spawnRangeY = spawnRangeY;
  }

  public void setVelocityRange(float minVelocity, float maxVelocity)
  {
    this.minVelocity = minVelocity;
    this.maxVelocity = maxVelocity;
  }

  public void setLifetimeRange(float minLifetime, float maxLifetime)
  {
    this.minLifetime = minLifetime;
    this.maxLifetime = maxLifetime;
  }
}
