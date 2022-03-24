/* FisicaGame.pde
 *
 * Copyright 2018-2021 Roland Richter
 *
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

// TOUR-1 This sketch uses fisica, a 2D physics library by Ricard Marxer,
//   and the Sound library, provided by The Processing Foundation.
import fisica.*;
import processing.sound.*;

FWorld world;
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
}


float volume = 1;         // Starts with sound on 
color bgcolor = #dece27;  // Starts with a decent background color

boolean paused = false;
boolean debug = false;


// Draws background, and displays name and version of this game
void drawBackground()
{
    background(debug ? #000000 : bgcolor); // Have black background in debug mode
    
    // Determine font color; see https://stackoverflow.com/a/1855903
    float luminance = (0.299 * red(bgcolor) + 0.587 * green(bgcolor) + 0.114 * blue(bgcolor))/255.0;
    
    if (luminance > 0.5)   // bright background - black font
       fill(color(0,0,0));
    else                   // dark background - white font
       fill(color(255,255,255));
    
    textSize(12);
    textAlign(RIGHT);
    text("FisicaGame\n[lesson: listeners]", 0.99*width, 0.95*height);
}


void draw() 
{
    if (paused)
    {
        return;
    }

    drawBackground();

    // Inform all Ticking objects about the next tick
    ArrayList<FBody> bodies = world.getBodies();

    for (FBody b : bodies) 
    {   
        if (b instanceof Ticking) 
        {
            ((Ticking) b).tick();
        }
    }

    world.step();

    if (debug) 
    {
        world.drawDebug();
    } 
    else 
    {
        world.draw();
    }
}

// TOUR-2 Lets have another look at the keyPressed() method. The documentation
//   at https://processing.org/reference/keyPressed_.html talks about "mouse and
//   keyboard events". An _event_ is some kind of _message_ which is created by
//   the _sender_, transmitted over a _channel_, and received by a _receiver_, or
//   several receivers. This _pattern_ is so common that it has many names, e.g.,
//
//   - event handling: event source, control -> event handler
//   - publish–subscribe: publisher -> subscriber
//   - observer pattern: subject -> observer, listener
//
//   In the sequel, I will use the words "sender", "message", and "receiver".
void keyPressed()
{
    if (key == 'b' || key == 'B') // Change background color
    {
        bgcolor = color(random(255), random(255), random(255));
    }

    if (key == 'n' || key == 'N') // Create a new object
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

        // ... and at random position.
        thing.setPosition(int(random(80, width-80)), 30);
        world.add(thing);
    }
    
    if (key == CODED) 
    {
        if (keyCode == UP) 
        {
            
        }
        // etc.    
    }


    if (key == 'v' || key == 'V') // Switch sound on or off
    {
        volume = 1 - volume;
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

// TOUR-3 Lets examine what happens when the user presses a mouse button:
//   the mouse, as the "sender", generates a new "message", and sends it
//   to anyone who is listening; here, the "receiver" is our FisicaGame 
//   program; it receives a message, which contains information about
//   - whether or not a mouse button is currently pressed (mousePressed)
//   - which mouse button is pressed, if any (mouseButton)
//   - where the mouse is currently located (mouseX, mouseY)
//   
//   Note that the sender often does not know which, or how many, receivers
//   are listening; however, the sender must create messages which each 
//   receiver can understand; in other words, sender and receiver have to 
//   use a common _protocol_.
void mousePressed()
{
    if (mousePressed && (mouseButton == RIGHT)) 
    {
        Nail nail = new Nail();
        nail.setPosition(mouseX, mouseY);
        world.add(nail);
        
        // HOMEWORK-3-a Play a hammering sound whenever a nail is added here.
        // Hint: https://processing.org/reference/libraries/sound/SoundFile.html
    }
}

// TOUR-4 What happenes when two objects of the fisica world, say, a Brick and 
//   a SoccerBall, hit each other? ... they send out a message!
//   Here, the message is an object of type FContact, and the receiver is again
//   our program. An FContact message holds several details about the contact:
//   for instance, which two bodies have contact, where the contact happened,
//   at which velocity, and so on. See all the details at
//   http://www.ricardmarxer.com/fisica/reference/fisica/FContact.html
void contactStarted(FContact contact) 
{   
    FBody b1 = contact.getBody1();
    FBody b2 = contact.getBody2();

    // TOUR-5 Objects should make sounds if they bang against hard things.
    //   I decided, somehow arbitrarily, that Nails, Planks, and Bricks are hard. 
    //   A sound is played if the first object is hard, and the second object can
    //   make a sound. Once again, we find out the type of an object by using
    //   the _instanceof_ keyword.
    boolean isHard1 = b1 instanceof Nail || b1 instanceof Plank || b1 instanceof Brick;

    if (isHard1) 
    {
        if (b2 instanceof Sounding)
        {
            ((Sounding) b2).playSound(volume);
        }
    }

    // TOUR-8 If, say, a Brick and a SoccerBall hit each other, we do not know
    //   in which order they appear in the FContact message: either b1 is the
    //   Brick, and b2 the SoccerBall, or vice versa. Hence, we have to repeat
    //   the code from above, only with b1 and b2 switched.
    boolean isHard2 = b2 instanceof Nail || b2 instanceof Plank || b2 instanceof Brick;

    if (isHard2) 
    {
        if (b1 instanceof Sounding) 
        {
            ((Sounding) b1).playSound(volume);
        }
    }
    
    // HOMEWORK-3-b Remove a soap bubble as soon as it has contact with any other object.
    // Hint: http://www.ricardmarxer.com/fisica/reference/fisica/FWorld.html#remove(fisica.FBody)
    
    // HOMEWORK-3-c+ (bonus homework): Implement the following behaviour:
    //   As soon as a SoccerBall has contact with a Nail, it starts to loose air; that is,
    //   it gets smaller and smaller, probably makes a hissing sound, until it disappears
    //   and is removed from this world ...
}
