import java.util.PriorityQueue;
import java.util.Iterator;

public class PointParticleSystem
{
  private PriorityQueue<Particle> particles;
  private PImage sprite;
  private boolean active;
  private float emissionRate, spawnDelay, spawnTimer;
  private int particleSize;
  private float scaleOverLifetime;
  private float spawnOriginX, spawnOriginY;
  private float minLifetime, maxLifetime;
  private color tint;

  public PointParticleSystem(String spriteFilepath)
  {
    this(spriteFilepath, true, 10,
        10, 1, 0, 0,
        1, 2, 255);
  }
  
  public PointParticleSystem(String spriteFilepath, boolean active, float emissionRate, 
      int particleSize, float scaleOverLifetime, float spawnOriginX, float spawnOriginY, 
      float minLifetime, float maxLifetime, color tint)
  {
    particles = new PriorityQueue<Particle>();
    setActive(active);
    setEmissionRate(emissionRate);
    setParticleSize(particleSize);
    setScaleOverLifetime(scaleOverLifetime);
    setSpawnOrigin(spawnOriginX, spawnOriginY);
    setLifetimeRange(minLifetime, maxLifetime);
    setTint(tint);
    setSprite(spriteFilepath);
  }

  public void spawnParticle()
  {
    float lifetime = random(minLifetime, maxLifetime);
    particles.offer(new Particle(sprite, tint, scaleOverLifetime, spawnOriginX, spawnOriginY, 0, 0, 0, 0, lifetime));
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
    
    //update each particle in any order
    Iterator it = particles.iterator();
    while (it.hasNext())
    {
      Particle p = (Particle)it.next();
      p.update();
    }
    
    Particle p = (Particle) particles.peek();
    //destroy any particles which were marked for death during this frame
    while (p != null && p.markedForDeath())
    {
      particles.poll();
      p = particles.peek();
      //println(particles.size());
    }
  }
  
  public PImage getSprite()
  {
    return sprite;
  }

  public void setSprite(String spriteFilepath)
  {
    PImage sprite = loadImage(spriteFilepath); 
    setSprite(sprite);
  }

  public void setSprite(PImage sprite)
  {
    sprite.resize(particleSize, particleSize);
    this.sprite = sprite;
  }

  public boolean isActive()
  {
    return active;
  }

  public void setActive(boolean active)
  {
    this.active = active;
  }

  public float getEmissionRate()
  {
    return emissionRate;
  }

  public void setEmissionRate(float emissionRate)
  {
    this.emissionRate = emissionRate; 
    spawnDelay = 1.0 / emissionRate;
  }

  public int getParticleSize()
  {
    return particleSize;
  }

  public void setParticleSize(int particleSize)
  {
    this.particleSize = particleSize;
    //setSprite(getSprite());
  }

  public float getScaleOverLifetime()
  {
    return scaleOverLifetime;
  }

  public void setScaleOverLifetime(float scaleOverLifetime)
  {
    this.scaleOverLifetime = scaleOverLifetime;
  }

  public float getSpawnOriginX()
  {
    return spawnOriginX;
  }

  public float getSpawnOriginY()
  {
    return spawnOriginY;
  }

  public void setSpawnOrigin(float spawnOriginX, float spawnOriginY)
  {
    this.spawnOriginX = spawnOriginX;
    this.spawnOriginY = spawnOriginY;
  }

  public float getMinLifetime()
  {
    return minLifetime;
  }

  public float getMaxLifetime()
  {
    return maxLifetime;
  }

  public void setLifetimeRange(float minLifetime, float maxLifetime)
  {
    this.minLifetime = minLifetime;
    this.maxLifetime = maxLifetime;
  }

  public color getTint()
  {
    return tint;
  }

  public void setTint(color tint)
  {
    this.tint = tint;
  }
}
