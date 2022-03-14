/* SoapBubble.pde
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

// TOUR-13 A class extends one, and only one, other class; it can, however,
//   implement several interfaces. SoapBubble is both Ticking and Resizable.
public class SoapBubble extends FCircle implements Ticking, Resizable
{
    public SoapBubble()
    {
        this(38, color(random(256), random(256), random(256))); // Random color
    }
    
    public SoapBubble(float size, color col)
    {
        super(size);
        this.setFillColor(col); 
        
        this.setDamping(0.2);
        this.setDensity(1.0);
        this.setRestitution(0.0f);
    }
    
    // TOUR-14 With every tick, i.e. every 1/60 sec or so, SoapBubbles gets
    //   a little impulse: random in horizontal dirction, but always upwards.
    //   This lets SoapBubbles float through the air; otherwise, they would
    //   fall downward like anything else! (Try it out ...)
    //   For details on how to generate random numbers, see 
    //   https://processing.org/reference/random_.html
    public void tick()
    {
        this.addImpulse(random(-0.3, 0.3), -0.25);
    }
    
    
    public void resize(float factor)
    {
        float mySize = this.getSize();
        float newSize = factor * mySize;
        this.setSize(newSize);
    }
}
