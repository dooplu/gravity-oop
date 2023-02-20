// Made by Adam Dia  //<>//
// Using what I learned in my 12th grade physics class about gravitation, I have made this simulation using newton's law of universal gravitation
// TODO:
// - make it so that I can use an arbitrary number of bodies, USE CONTINUE IN A FOR LOOP - kindof done
// - be able to grab a body and throw it in a direction, giving it velocity, PMOUSEX and Y, MOUSERELEASED ETC... - grabbing down, throwing not done
// - or angry birds-like launching of planets


//gBody body1, body2, body3;

int nmbOfBodies = 2;

gBody[] bodies = new gBody[nmbOfBodies];

void setup()
{
  size(1280, 720);

  // earth and moon analogue
  bodies[0] = new gBody(width/2, height/2, 100, 5.972e14, color(0, 0, 255));
  bodies[1] = new gBody(width/2 + 300, height/2, 27.3, 7.344e12, color(255, 255, 255));

  // make a new gBody for the amount of bodies set by nmbOfBodies, give them all random sizes, radii, colors and masses
  //for(int i = 0; i < nmbOfBodies; i++)
  //{
  //  bodies[i] = new gBody(random(width), random(height), random(20, 100), random(1e10, 9e14), color(random(255), random(255), random(255)));
  //}
}

void draw()
{
  background(0);

  for (int i = 0; i < nmbOfBodies; i++) // loop through all the bodies and display them
  {
    bodies[i].display();
    for (int j = 0; j < nmbOfBodies; j++) // for each loop, loop through all other bodies and simulate with them...
    {
      if (j == i) // ...but not yourself
      {
        continue;
      }
      bodies[i].simulate(bodies[j]);
    }
  }

  fill(255);
  textSize(25);
  text(frameRate, 40, 40);
}

void mouseClicked()
{
  if (mouseButton == RIGHT)
  {
    bodies[1].pos.set(mouseX, mouseY);
  }
}
