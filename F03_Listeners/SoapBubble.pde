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


public class SoapBubble extends FCircle implements Ticking
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
    
    public void tick()
    {
        this.addImpulse(random(-0.3, 0.3), -0.25);
    }
}
