/* Alien.pde
 * Copyright 2018-2022 Roland Richter
 */

// TOUR-10 An Alien object is, again, a composition of other FBody objects:
//   - the head, of type FCircle
//   - the mouth, of type FLine
//   - left and right eye, of type FCircle
//   - left and right tentacle, of type FLine
public class Alien extends FCompound
{
    public Alien(String name)
    {
        super();
        this.setName(name);
        
        // TOUR-11 In a previous comment (TOUR 2), I claimed that our sketch
        //   must obey the laws of physics, and that only one object can be
        //   at a given position at a given time.
        //   That's not completely true: the Fisica library allows an object 
        //   to be a "sensor body". From the docs:
        //   "Sensor bodies act as normal bodies in the sense that they notify
        //    about contacts, however they do not collide with other bodies 
        //    (they act like ghost bodies)."
        //   The two tentacles of an Alien are, in this sense, "sensor bodies".
        FLine leftTentacle = new FLine(0,0,-30,-30);
        leftTentacle.setStrokeColor(#7CFC00);      // Lawn green, see http://latexcolor.com/
        leftTentacle.setStrokeWeight(2);
        leftTentacle.setSensor(true);
        
        FLine rightTentacle = new FLine(0,0,+30,-30);
        rightTentacle.setStrokeColor(#7CFC00);     // Lawn green
        rightTentacle.setStrokeWeight(2);
        rightTentacle.setSensor(true);
        
        FCircle head = new FCircle(40);
        head.setName(name + "\'s head");
        head.setFillColor(#7CFC00);                // Lawn green
        
        FLine mouth = new FLine(-6,10,6,10);
        mouth.setStrokeColor(#100C08);             // Smoky black
        mouth.setStrokeWeight(1);
        
        FCircle leftEye = new FCircle(12);
        leftEye.setFillColor(#87CEEB);             // Light sky blue
        leftEye.setPosition(-10,-10);
        
        FCircle rightEye = new FCircle(12);
        rightEye.setFillColor(#87CEEB);            // Light sky blue
        rightEye.setPosition(+10,-10);
        
        this.addBody(leftTentacle);
        this.addBody(rightTentacle);
        this.addBody(head);
        this.addBody(mouth);
        this.addBody(leftEye);
        this.addBody(rightEye);
        
        this.setDamping(0.2);
        this.setDensity(2000.0);
        this.setRestitution(0.1);
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
 
