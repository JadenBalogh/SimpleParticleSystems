public class CircleParticleSystem extends PointParticleSystem
{
  private float spawnRangeMin, spawnRangeMax;
  private float spawnAngleMin, spawnAngleMax;
  private float velocityRangeMin, velocityRangeMax;
  private float accelerationRangeMin, accelerationRangeMax;

  public CircleParticleSystem(String spriteFilepath, boolean active, float emissionRate, 
    int particleSize, float scaleOverLifetime, float spawnOriginX, float spawnOriginY, 
    float spawnRangeMin, float spawnRangeMax, float spawnAngleMin, float spawnAngleMax, 
    float velocityRangeMin, float velocityRangeMax, float accelerationRangeMin, float accelerationRangeMax,
    float minLifetime, float maxLifetime, color tint)
  {
    super(spriteFilepath, active, emissionRate, particleSize, 
      scaleOverLifetime, spawnOriginX, spawnOriginY, 
      minLifetime, maxLifetime, tint);
    
    setSpawnRange(spawnRangeMin, spawnRangeMax);
    setSpawnAngle(spawnAngleMin, spawnAngleMax);
    setVelocityRange(velocityRangeMin, velocityRangeMax);
    setAccelerationRange(accelerationRangeMin, accelerationRangeMax);
  }
  
  public void spawnParticle()
  {
    float lifetime = random(getMinLifetime(), getMaxLifetime());
    float spawnRange = random(getSpawnRangeMin(), getSpawnRangeMax());
    float spawnAngle = random(getSpawnAngleMin(), getSpawnAngleMax());
    float spawnVelocity = random(getVelocityRangeMin(), getVelocityRangeMax());
    float spawnAcceleration = random(getAccelerationRangeMin(), getAccelerationRangeMax());
    float spawnPositionX = getSpawnOriginX() + (spawnRange * cos(spawnAngle));
    float spawnPositionY = getSpawnOriginY() + (spawnRange * sin(spawnAngle));
    float velocityX = spawnVelocity * cos(spawnAngle);
    float velocityY = spawnVelocity * sin(spawnAngle);
    float accelerationX = spawnAcceleration * cos(spawnAngle);
    float accelerationY = spawnAcceleration * sin(spawnAngle);
    super.particles.offer(new Particle(getSprite(), getTint(), getScaleOverLifetime(), spawnPositionX, spawnPositionY, velocityX, velocityY, accelerationX, accelerationY, lifetime));
  }
  
  public float getSpawnRangeMin()
  {
    return spawnRangeMin;
  }
  
  public float getSpawnRangeMax()
  {
    return spawnRangeMax;
  }
  
  public void setSpawnRange(float spawnRangeMin, float spawnRangeMax)
  {
    this.spawnRangeMin = spawnRangeMin;
    this.spawnRangeMax = spawnRangeMax;
  }
  
  public float getSpawnAngleMin()
  {
    return spawnAngleMin;
  }
  
  public float getSpawnAngleMax()
  {
    return spawnAngleMax;
  }
  
  public void setSpawnAngle(float spawnAngleMin, float spawnAngleMax)
  {
    this.spawnAngleMin = spawnAngleMin;
    this.spawnAngleMax = spawnAngleMax;
  }
  
  public float getVelocityRangeMin()
  {
    return velocityRangeMin;
  }
  
  public float getVelocityRangeMax()
  {
    return velocityRangeMax;
  }
  
  public void setVelocityRange(float velocityRangeMin, float velocityRangeMax)
  {
    this.velocityRangeMin = velocityRangeMin;
    this.velocityRangeMax = velocityRangeMax;
  }
  
  public float getAccelerationRangeMin()
  {
    return accelerationRangeMin;
  }
  
  public float getAccelerationRangeMax()
  {
    return accelerationRangeMax;
  }
  
  public void setAccelerationRange(float accelerationRangeMin, float accelerationRangeMax)
  {
    this.accelerationRangeMin = accelerationRangeMin;
    this.accelerationRangeMax = accelerationRangeMax;
  }
}
