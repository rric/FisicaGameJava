/* SoccerBall.pde
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

// TOUR-5 SoccerBall still extends FCircle, that is, it "is-a" FCircle.
//   Additionally, SoccerBall now states to _implement_ the Resizable interface. 
//   That's like signing a contract: SoccerBall is now obliged to provide
//   an implementation of each member function which is declared in Resizable.
public class SoccerBall extends FCircle implements Resizable
{
    public SoccerBall()
    {
        this(50);   
    }
    
    public SoccerBall(float size)
    {
        this(size, #F2F3F4); // Anti-flash white, see http://latexcolor.com/
    }
    
    
    public SoccerBall(float size, color col)
    {
        super(size);
        this.setFillColor(col);
        
        this.setDamping(0.2);
        this.setDensity(3000.0);
        this.setRestitution(0.5);
    }
    
    // TOUR-6 As just said, SoccerBall has to provide an implementation of each
    //   of Resizable's member functions. Resizable has only one member function,
    //   resize(); it is implemented here.
    //   Note that the next line must *exactly* match the corresponding line in
    //   the Resizable interface declaration.
    public void resize(float factor)
    {
        float mySize = this.getSize();
        float newSize = factor * mySize;
        this.setSize(newSize);
    }
}
