class gBody
{
  static final float G = 6.673e-11;

  PVector pos, velocity;
  float radius;
  color bodyColor;
  float mass, acceleration;

  gBody(float x, float y, float r, float m, color c)
  {
    pos = new PVector(x, y);
    radius = r;
    bodyColor = c;
    mass = m;

    velocity = new PVector(0f, 0f);
  }

  void display()
  {
    stroke(0);
    fill(bodyColor); 
    circle(pos.x, pos.y, radius * 2);
    stroke(255, 0 , 0);
    
  }

  void simulate(gBody other)
  {

    float R = dist(pos.x, pos.y, other.pos.x, other.pos.y); // Find the distance between both bodies

    float force = G * mass * other.mass / pow(R, 2); // newton's law of universal gravitation
    acceleration = force / mass; // newton's second law

    PVector displacementToOther = new PVector(0f, 0f); 
    displacementToOther = PVector.sub(other.pos, pos); // find where the other body is situated relative to this body
    displacementToOther.normalize(); // normalize it so we just get direction

    // add the product of acceleration and each direction component to velocity each frame

    if (R >= radius + other.radius) // very basic collision detection, stop updating position if the circles collide
    {
      velocity.set(velocity.x + acceleration * displacementToOther.x, velocity.y + acceleration * displacementToOther.y);
      pos.add(velocity); // add velocity to position each frame;
    } else 
    {
      velocity.set(0f, 0f); // We don't want speed to build up when they are touching
      float overlap = (radius + other.radius) - R; // How much theyare intersecting
      pos.add(displacementToOther.mult(overlap/2).mult(-1)); // use half of that overlap as the magnitude for their offset, and then reverse it, then add that to position to make sure they arent inside each other
    }
    //line(pos.x, pos.y, pos.x + velocity.x, pos.y + velocity.y);
    grabAndThrow();
  }

  void grabAndThrow()
  {
    //PVector mouseSpeed = PVector.sub(new PVector(mouseX, mouseY), new PVector(pmouseX, pmouseY)).div(1/frameRate);

    if (PVector.dist(new PVector(mouseX, mouseY), pos) < radius && mousePressed) // if the distance to the mouse from the body is smaller than the radius of the body AND the mouse is held down, grab it
    {
      if (mouseButton == LEFT)
      {
        pos.set(mouseX, mouseY);
        velocity.set(0, 0);
      }
    }
  }
}
