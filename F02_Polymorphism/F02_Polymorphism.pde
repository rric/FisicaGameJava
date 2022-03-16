/* F02_Polymorphism.pde
 * Copyright 2018-2022 Roland Richter
 */

import fisica.*;
import processing.sound.*;

// TOUR-1 This sketch uses fisica, and, additionally, the Sound library which 
//   is provided by _The Processing Foundation_, the organization behind the
//   development of Processing, p5.js, etc. To learn more, visit their site
//   https://processingfoundation.org/
//   If you don't have the Sound library installed yet, do so now.

FWorld world;

// TOUR-15 These three balls are now declared here, outside the setup() function;
//   this makes them _global variables_, which can be accessed not only from
//   within setup(), but also from within keyPressed(), etc.
//
// Why? Have a look at HOMEWORK-2-b ... (You are now finished with the TOUR.)
SoccerBall redBall, greenBall, whiteBall;

void setup() 
{
    size(800, 550);

    Fisica.init(this);
    Fisica.setScale(150); // scale: 150 pixel = 1 m

    world = new FWorld();
    world.setGravity(0, 300);
    world.setGrabbable(true);
    world.setEdges();

    // Lets create some objects, and add them to the world
    
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

    Plank plank = new Plank(350, 15);
    plank.setPosition(width/2, 300);
    plank.setName("Wooden plank");
    world.add(plank);

    redBall = new SoccerBall(50, color(#FF2800)); // Creates a "Ferrari red" ball ...
    redBall.setPosition(120, 40);                     // ... somewhere at top left ...
    redBall.setVelocity(int(random(-80, 80)), 0);     // ... with random velocity.
    redBall.setName("Red soccer ball");
    world.add(redBall);

    greenBall = new SoccerBall(50, color(#39FF14)); // Create a "Neon green" ball ...
    greenBall.setPosition(width/2, 40);               // ... somewhere at top centered ...
    greenBall.setVelocity(int(random(-80, 80)), 0);   // ... with random velocity.
    greenBall.setName("Green soccer ball");
    world.add(greenBall);

    whiteBall = new SoccerBall();                   // Create a standard colored ball ...
    whiteBall.setPosition(width-120, 40);                      // ... somewhere at top right ...
    whiteBall.setVelocity(int(random(-80, 80)), 0);   // ... with random velocity.
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
}


color bgcolor = #EFDECD;  // Starts with a decent background color, "Almond"

int paused = 0;
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
    text("FisicaGame\n[lesson: polymorphism]", 0.99*width, 0.95*height);
}


void draw() 
{
    if (paused > 0)
    {
        paused -= 1;
        return;
    }

    drawBackground();

    // TOUR-9 Processing, in combination with fisica, works likes a flip book:
    //   it draws an image, then moves all objects a little bit, then draws an 
    //   image again, then moves the objects a little bit, then draws an image
    //   again ... and so on, for many times per second. This draw-update loop
    //   gives the impression of smooth motion; the drawing frequency is called
    //   frame rate. Processing provides a variable to inspect this value, see
    //   https://processing.org/reference/frameRate.html
    //   At my computer, I get about 50 to 60 frames per second. 
    //
    //   As already mentioned, our world holds a list of all objects. Here, we
    //   get those objects implementing the Ticking interface, and inform them
    //   about the next tick.
    //   For instance, each BurstBall is "ticked()" 50 to 60 times per second; 
    //   with each tick, its lifespan is reduced, until it finally bursts.
    ArrayList<FBody> bodies = world.getBodies();

    for (FBody b : bodies) 
    {   
        if (b instanceof Ticking) 
            ((Ticking) b).tick();
    }

    world.step();

    if (debug) 
        world.drawDebug();
    else 
        world.draw();
}


void keyPressed()
{
    // b/B - change background color
    if (key == 'b' || key == 'B')
    {
        bgcolor = color(random(255), random(255), random(255));
    }

    // n/N - create a new object
    if (key == 'n' || key == 'N')
    {
        // TOUR-2 Here, a new object is created at random. It might be a new 
        //   Brick, or PingPongBall, or SoccerBall, ... we do not know yet.
        //   What we *do* know, however, is this: 
        //     - Brick is-a FBox, and FBox is-a FBody
        //     - PingPongBall is-a FCircle, and FCircle is-a FBody
        //     - and so on ...
        //   Going up the class hierarchy, we find FBody to be the common
        //   ancestor of all things which could be created here. Hence, the
        //   new object is declared to be an FBody here; later on, it is 
        //   allowed to be "many things"; this is called _polymorphism_.
        //   How is the common ancestor of *all* classes in Java called?
        
        FBody thing;
        int wurfel = int(random(6)) + 1;

        if (wurfel == 1)
            thing = new Brick(); 
        else if (wurfel == 2)
            thing = new PingPongBall(); 
        else if (wurfel == 3) 
            thing = new SoccerBall();
        else if (wurfel == 4)
            thing = new BurstBall();
        else
            thing = new SoapBubble();

        thing.setPosition(int(random(80, width-80)), 30);
        world.add(thing);
    }
    
    // TOUR-3 New as well: some objects are resizable now. Try it out first!
    //   ... funny, isn't it? Lets have a look how it works.
    
    // r/R - resize all objects which are resizable    
    if (key == 'r' || key == 'R')
    {
        // Resize all objects by the same random factor, between 66.67 % and 150 %
        float factor = random(0.6667, 1.5);
        
        // TOUR-7 A central idea of object oriented programming is _polymorphism_
        //   (from the Greek words "poly" = many, "morph" = form, figure, shape).
        //   
        //   Our world holds a list of all objects which were created and added 
        //   so far. An item in that list might be a Brick, or PingPongBall, 
        //   or SoccerBall, ... we do not know yet.
        //   What we *do* know, however, is this: 
        //     - Brick is-a FBox, and FBox is-a FBody
        //     - PingPongBall is-a FCircle, and FCircle is-a FBody
        //     - and so on ...
        //   Sounds familiar? Yes, that's polymorphism, as mentioned in TOUR-2.
        //
        //   Going up the class hierarchy, we find FBody to be the common
        //   ancestor of all things which were added to the world. Hence, the
        //   list of all objects is declared to be a list of FBodys here;
        //   any list item is allowed to be one of "many forms".
        //   
        //   Here, we want to resize all those objects which are Resizable; so,
        //   we have to ask whether an object is Resizable or not. We can do so
        //   by using the keyword _instanceof_.
        ArrayList<FBody> bodies = world.getBodies();

        for (FBody b : bodies) 
        {
            if (b instanceof Resizable) 
            {
                ((Resizable) b).resize(factor);
            }
        }
    }
    
    // HOMEWORK-2-a Add an interface ChameleonLike for objects which can change
    //   their color. Let SoccerBall be ChameleonLike: if somebody presses 'c' or 'C'
    //   here, SoccerBalls, and all other ChameleonLikes, should change their color.
    //   Hint: this might be quite similar to Resizable ...
    
    // HOMEWORK-2-b Give the user some control over the red, green, and white ball:
    //   * Down here you see how to use special keys, such as the UP, DOWN, LEFT,
    //     and RIGHT keys; see also https://processing.org/reference/keyCode.html
    //   * redBall, greenBall, and whiteBall are now global variables which can be 
    //     accessed here; see TOUR-15
    //   * Have a second look at SoapBubble's tick() funtion to see how to add an
    //     impluse to an object; or scroll back to setup() on how to set its velocity 
    if (key == CODED) 
    {
        if (keyCode == UP) 
        {
            
        }
        // etc.    
    }

    // d/D - switch debug mode on or off
    if (key == 'd' || key == 'D')
    {
        debug = !debug;
    }

     // p/P - pause for approx. 24 hours (at 60 fps), or re-start
    if (key == 'p' || key == 'P')
    {
        paused = (paused > 0 ? 0 : 24*60*60*60);
    }
    
    // s/S - save the current frame, and pause for approx. 0.5 sec
    if (key == 's' || key == 'S')
    {
        saveFrame("fisica-###.jpg");
        paused = 30;
    }
}


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
