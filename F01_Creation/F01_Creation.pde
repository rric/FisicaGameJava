/* F01_Creation.pde
 * Copyright 2018-2022 Roland Richter
 */

import fisica.*;

// TOUR-1 This sketch uses fisica, a 2D physics library by Ricard Marxer.
//   The documentation of fisica is at http://www.ricardmarxer.com/fisica/,
//   and the source code is at https://github.com/rikrd/fisica
//
//   fisica provides a world where all objects exist in. I will use the term 
//   _object_; in the online documentation, an object is often called a _body_.

FWorld world;


void setup() 
{
    size(800, 550);

    Fisica.init(this);
    Fisica.setScale(150); // scale: 150 pixel = 1 m

    world = new FWorld();
    
    world.setGravity(0, 300);
    world.setGrabbable(true);
    world.setEdges();

    // TOUR-2 Lets create some objects, and add them to the world. In the tabs
    //   above, you see which kind of objects there are: Brick, Nail, PingPongBall,
    //   Plank, and SoccerBall. First, some nails ...
    
    for (int i = 1; i < 6; ++i)
    {
        Nail nail = new Nail();
        nail.setPosition(i * width/6, 200);
        world.add(nail);
    }

    for (int i = 2; i < 5; ++i)
    {
        Nail nail = new Nail();
        nail.setPosition(i * width/6, 350);
        world.add(nail);
    }

    // TOUR-4 Here, an object called `plank` of class `Plank` is created.
    //   Note the subtle difference: `Plank` (with uppercase P) is the name 
    //   of the class, `plank` (with lowercase p) is one object of class Plank.
    //   By convention, class names start with uppercase letters, whereas 
    //   object names start with lowercase letters.  
    
    Plank plank = new Plank(350, 15);
    
    // TOUR-7 Now that the object plank has been created, we can set some
    //   further properties of it; e.g., its position, and its name.
    //   Classes typically have many methods called getXYZ() and setXYZ()
    plank.setPosition(width/2, 300);
    plank.setName("Wooden plank");
    world.add(plank);

    SoccerBall redBall = new SoccerBall(50, color(#FF2800)); // Creates a "Ferrari red" ball ... //<>//
    redBall.setPosition(120, 40);                            // ... somewhere at top left ...
    redBall.setVelocity(int(random(-80, 80)), 0);            // ... with random velocity.
    redBall.setName("Red soccer ball");
    world.add(redBall);

    SoccerBall greenBall = new SoccerBall(50, color(#39FF14)); // Create a "Neon green" ball ...
    greenBall.setPosition(width/2, 40);                        // ... somewhere at top centered ...
    greenBall.setVelocity(int(random(-80, 80)), 0);            // ... with random velocity.
    greenBall.setName("Green soccer ball");
    world.add(greenBall);

    SoccerBall whiteBall = new SoccerBall();                   // Create a standard colored ball ... //<>//
    whiteBall.setPosition(width-120, 40);                      // ... somewhere at top right ...
    whiteBall.setVelocity(int(random(-80, 80)), 0);            // ... with random velocity.
    whiteBall.setName("Standard soccer ball");
    world.add(whiteBall);

    PingPongBall leftPingPong = new PingPongBall();      // Creates a ping pong ball ...
    leftPingPong.setPosition(width/3, 40);               // ... at top left ...
    leftPingPong.setVelocity(int(random(-80, 80)), 0);   // ... with random velocity.
    leftPingPong.setName("Ping pong ball #1");
    world.add(leftPingPong);

    PingPongBall rightPingPong = new PingPongBall();      // Creates a ping pong ball ...
    rightPingPong.setPosition(2*width/3, 40);             // ... at top right ...
    rightPingPong.setVelocity(int(random(-80, 80)), 0);   // ... with random velocity.
    rightPingPong.setName("Ping pong ball #2");
    world.add(rightPingPong);
    
    // HOMEWORK-1-b The world as populated above -- with eight nails, a plank, and some
    //   soccer and ping pong balls -- is not very creative; it's not really a "game".
    //   Think of some other world, and populate it with a number of objects.
}


color bgcolor = #EFDECD;  // Starts with a decent background color, "Almond"

boolean paused = false;
boolean debug = false;


// Draws background, and displays name and version of this game
void drawBackground()
{
    background(debug ? #000000 : bgcolor); // Have black background in debug mode
    
    // Determine font color; see https://stackoverflow.com/a/1855903
    float luminance = (0.299 * red(bgcolor) + 0.587 * green(bgcolor) + 0.114 * blue(bgcolor))/255.0;
    
    if (luminance > 0.5)   // bright background - black font
       fill(color(0, 0, 0));
    else                   // dark background - white font
       fill(color(255, 255, 255));
    
    textSize(12);
    textAlign(RIGHT);
    text("FisicaGame\n[lesson: creation]", 0.99*width, 0.95*height);
}


void draw() 
{
    if (paused)
        return;

    drawBackground();
   
    world.step();

    if (debug) 
        world.drawDebug();
    else 
        world.draw();
}


// TOUR-9 `keyPressed()` is called whenever a key is pressed -- you might have
//   guessed ... Since I do not care whether the key is lower- or uppercase,
//   my code always tests whether the lowercase or uppercase key was pressed.
//   Just try what happens if you press 'b' or 'D' or 'N' ...
//   
// You are now finished with the TOUR. Go and start to look for HOMEWORK-1!
//
void keyPressed()
{
    if (key == 'b' || key == 'B') // Change background color
    {
        bgcolor = color(random(255), random(255), random(255));
    }

    if (key == 'n' || key == 'N') // Create a new object
    {    
        // HOMEWORK-1-a Write a new class TennisBall, and create a tennis ball
        //   instead of a brick here.
        // Hint: start by copying SoccerBall. Wait a minute ...
        //   Are you allowed to copy SoccerBall, or even modify it?! 
        //   Read on at TOUR-10.
        
        FBody thing = new Brick();

        thing.setPosition(int(random(80, width-80)), 30);
        world.add(thing);
    }

    if (key == 'd' || key == 'D') // Switch debug mode on or off
    {
        debug = !debug;
    }

    if (key == 'p' || key == 'P') // Switch between paused and not paused
    {
        paused = !paused;
    }
}


// TOUR-8 You already found out what happens if you right-click with the mouse,
//   didn't you? If not, just try it ...
void mousePressed()
{
    if (mousePressed && (mouseButton == RIGHT)) 
    {
        Nail nail = new Nail();
        nail.setPosition(mouseX, mouseY);
        world.add(nail);
    }
}

/* ----------------------------------------------------------------------
 * This file is part of FisicaGame.
 *
 * FisicaGame is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty
 * of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
 * See the GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program. If not, see <http://www.gnu.org/licenses/>.
 */
 
