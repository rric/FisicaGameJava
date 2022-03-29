/* F04_Shapes.pde
 * Copyright 2018-2022 Roland Richter
 */

import fisica.*;
import processing.sound.*;

// TOUR-1 This sketch uses fisica, a 2D physics library by Ricard Marxer,
//   and the Sound library, provided by The Processing Foundation.
FWorld world;
SoccerBall redBall, greenBall, whiteBall;
Bucket bucket;
Alien alien;


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
    whiteBall.setPosition(width-120, 40);             // ... somewhere at top right ...
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

    bucket = new Bucket();
    bucket.setPosition(width/2-60, 50);
    bucket.setName("Eimer");
    world.add(bucket);

    // Creates Ellen, a friendly alien
    alien = new Alien("Ellen");

    alien.setPosition(int(random(width/2-30, width/2+30)), 250);
    world.add(alien);
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
    text("FisicaGame\n[lesson: shapes]", 0.99*width, 0.95*height);
}


void draw() 
{
    if (paused > 0)
    {
        paused -= 1;
        return;
    }

    drawBackground();

    // Inform all Ticking objects about the next tick
    ArrayList<FBody> bodies = world.getBodies();

    for (FBody b : bodies) 
    {   
        if (b instanceof Ticking) 
            ((Ticking) b).tick();
    }

    // TOUR-8 It's a bit senseless, but funny anyway: 
    //   Print how many things there are in the world, and how many are in the 
    //   bucket; or, more precisely: how many objects are touching the bucket.
    //
    //   Note that this is not really precise: e.g. if a Plank touches the Bucket,
    //   it's more likely that the Bucket stands on the Plank instead of the 
    //   Plank being in the Bucket, so do not count Planks. Also, counting does
    //   *not* work correctly with compund objects such as Alien.

    if ((frameCount % 60) == 0) 
    {
        print(bodies.size(), "things here are. ");

        ArrayList<FBody> inBucket = bucket.getTouching();
        int count = 0;

        for (FBody e : inBucket)
        {
            if (!e.isStatic() && !(e instanceof Plank)) 
            {
                ++count;
            }
        }

        // TOUR-9 Just a short comment on style: there are many conventions on
        //   how to format Java code, e.g. where to place curly brackets {}.
        //   Below, you see two if-else statements in different styles: the 
        //   first variant only needs 5 lines, whereas the second one needs 8!
        // 
        //   http://astyle.sourceforge.net/astyle.html#_Brace_Style_Options
        //   lists no less than 15 different formatting styles ... let the
        //   flamewar begin over the question which one is best!
        if (count == 1) {
            print("One thing in the bucket is. ");
        } else {
            print(count, "things in the bucket are. ");
        }

        if (count < 3) 
        {
            println("Many things you must collect.");
        } 
        else 
        {
            println("Many things you have collected.");
        }
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
        // Creates a new thing at random, ...
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

        // ... and at a random position.
        thing.setPosition(int(random(80, width-80)), 30);
        world.add(thing);
    }

    // Let the user steer alien by pressing UP, DOWN, LEFT, or RIGHT
    if (key == CODED)
    {
        if (keyCode == UP) 
            alien.addImpulse(0, -3000);

        if (keyCode == DOWN)
            alien.addImpulse(0, +500);

        if (keyCode == LEFT)
            alien.addImpulse(-1500, 0);

        if (keyCode == RIGHT)
            alien.addImpulse(+1500, 0);
    }

    // TOUR-12 In Fisica, there's yet another way to create "compound" objects,
    //   i.e. objects that consist of other objects: it provides a number of
    //   different Joint classes, see
    //   http://www.ricardmarxer.com/fisica/reference/fisica/FJoint.html
    //   A joint establishes some kind of relation between two or more bodies. 
    //
    //   Here, first we create 20 small circles, all positioned along a line.
    //   Then, a FDistanceJoint is used to connect the first circle with the
    //   second circle, the second circle with the third one, and so on.
    //   The result is something like a chain of 20 joint objects. Note that
    //   distance joints are both elastic (to some degree), and not solid: i.e.
    //   other objects may pass through. 
    if (key == 'j' || key == 'J') 
    {
        // Creates 20 chain elements
        FBody[] chain = new FBody[20]; 
        for (int k = 0; k < chain.length; k++) {
            chain[k] = new FCircle(12);
            chain[k].setDensity(10000.0);
            chain[k].setFillColor(#4682B4); // Steel blue, see http://latexcolor.com/
            chain[k].setPosition(lerp(300, width-300, k/20.), 30);
            world.add(chain[k]);
        }

        for (int k = 1; k < chain.length; k++) {
            FDistanceJoint join = new FDistanceJoint(chain[k-1], chain[k]);
            join.setFrequency(10.0);
            join.setDamping(5.0);
            world.add(join);
        }
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
        // TOUR-2 Until now, one could place a new nail *anywhere*, even
        //   if there already was another object at the very same position.
        //   However, our sketch must obey the basic laws of physics: at 
        //   any given time, only *one* object can be at a given position.
        //   
        //   Lets change the behaviour if the right mouse button is pressed:
        //   first, obtain the object at mouse position via the getBody() 
        //   function. If it returns "null", it's Java's way of saying that
        //   there's no object there, and we can add a nail; otherwise, i.e.
        //   if there *is* some object, we change a property of that object ...
        FBody underneath = world.getBody(mouseX, mouseY, true);

        if (underneath == null) {
            Nail nail = new Nail();
            nail.setPosition(mouseX, mouseY);
            world.add(nail);
        } else {            
            // TOUR-3 Go have a look at Fisica's documentation, at
            //   www.ricardmarxer.com/fisica/reference/fisica/FBody.html
            //
            //   There, it says that `setStatic()` sets "whether the body is
            //   static. Static bodies do not move or rotate, unless done
            //   manually [...]"
            //
            //   This means static bodies can still be dragged: press the left
            //   mouse button, and move the object around. If you dislike that,
            //   you have to change the object's "grabbable" property as well.

            underneath.setStatic(true);
            // underneath.setGrabbable(false);

            // TOUR-4 Another property of an object is its name. I use it
            //   sometimes: e.g. all balls get names, but nails do not ... 
            //   It is a tiny feature and makes debugging more convient.
            println("At (", mouseX, ",", mouseY, "), there\'s", underneath.getName());
        }
    }

    // HOMEWORK-4-a Go have a look at Fisica's documentation (again), at
    //   www.ricardmarxer.com/fisica/reference/fisica/FBody.html
    //   and note how many "set<SomeProperty>" functions every object has
    //   (some not documented, unfortunately.)
    //
    //   Turn your mouse into a magic wand: if one right-clicks an object,
    //   change some property of that object.
}


void contactStarted(FContact contact) 
{   
    FBody b1 = contact.getBody1();
    FBody b2 = contact.getBody2();

    // Soap bubbles burst with every contact

    if (b1 instanceof SoapBubble) 
    {
        world.remove(b1);
    }

    if (b2 instanceof SoapBubble)
    {
        world.remove(b2);
    }

    // Objects make sounds if they bang against hard things

    boolean isHard1 = b1 instanceof Nail || b1 instanceof Plank || b1 instanceof Brick || b1 instanceof Bucket;

    if (isHard1)
    {
        if (b2 instanceof Sounding)
        {
            ((Sounding) b2).playSound(1.0);
        }
    }

    boolean isHard2 = b2 instanceof Nail || b2 instanceof Plank || b2 instanceof Brick || b2 instanceof Bucket;

    if (isHard2)
    {
        if (b1 instanceof Sounding) 
        {
            ((Sounding) b1).playSound(1.0);
        }
    }

    // HOMEWORK-4-b Implement the following behaviour:
    // If Ellen, the alien, touches a SoccerBall, the ball changes its color.
    // The contact is not with the alien itself, but only with its head.
    // Hence, determine whether b1 (or b2) is the head of the alien.
    // Hint: use getName()

    // HOMEWORK-4-c+ (bonus homework): create your own compound object.
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
 
