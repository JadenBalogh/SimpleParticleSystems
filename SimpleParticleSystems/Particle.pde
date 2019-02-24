public class Particle implements Comparable<Particle>
{
  private PImage sprite;
  private float positionX, positionY;
  private float velocityX, velocityY;
  private float accelerationX, accelerationY;
  private color tint;
  private float transparency, fade;
  private float scale, growth;
  private float lifetime;
  private float destroyTimer;
  private boolean markedForDeath = false;

  public Particle(PImage sprite, color tint, float scaleOverLifetime, float positionX, float positionY, float velocityX, float velocityY, float accelerationX, float accelerationY, float lifetime)
  {
    this.sprite = sprite;
    this.tint = tint;
    this.positionX = positionX;
    this.positionY = positionY;
    this.velocityX = velocityX;
    this.velocityY = velocityY;
    this.accelerationX = accelerationX;
    this.accelerationY = accelerationY;
    transparency = 255;
    fade = -255 / lifetime;
    scale = 1.0;
    growth = (scaleOverLifetime - 1.0) / lifetime;
    this.lifetime = lifetime;
  }

  public void update()
  {
    destroyTimer += Timer.deltaTime;

    if (destroyTimer > lifetime)
    {
      markedForDeath = true;
      lifetime = -1;
    } 

    positionX += velocityX * Timer.deltaTime;
    positionY += velocityY * Timer.deltaTime;
    velocityX += accelerationX * Timer.deltaTime;
    velocityY += accelerationY * Timer.deltaTime;
    transparency += fade * Timer.deltaTime;
    scale += growth * Timer.deltaTime;

    pushMatrix();
    translate(positionX, positionY);
    scale(scale);
    imageMode(CENTER);
    tint(tint, transparency);
    image(sprite, 0, 0);
    popMatrix();
  }
  
  public boolean markedForDeath()
  {
    return markedForDeath; 
  }

  public int compareTo(Particle other)
  {
    if (destroyTimer > other.destroyTimer)
      return -1;
    else if (destroyTimer < other.destroyTimer)
      return 1;
    return 0;
  }
}
