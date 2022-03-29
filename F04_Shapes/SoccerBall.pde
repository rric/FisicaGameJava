/* SoccerBall.pde
 * Copyright 2018-2022 Roland Richter
 */


public class SoccerBall extends FCircle implements Sounding
{
    public SoccerBall()
    {
        this(50);   
    }
    
    
    public SoccerBall(float diam)
    {
        this(diam, #F2F3F4); // Anti-flash white, see http://latexcolor.com/
    }
    
    
    public SoccerBall(float diam, color clr)
    {
        super(diam);
        this.setFillColor(clr);
        
        this.setDamping(0.2);
        this.setDensity(3000.0);
        this.setRestitution(0.5);
        
        // soccer ball hit ground 01.wav by volivieri, used under CC BY 3.0
        // https://freesound.org/s/37154/
        this.sound = new SoundFile(Fisica.parent(), "37154__volivieri__soccer-ball-hit-ground-01.wav");
    }
    
    
    public void playSound(float amplitude)
    {
        this.sound.amp(amplitude);
        this.sound.play();
    }
    
    protected SoundFile sound;
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
