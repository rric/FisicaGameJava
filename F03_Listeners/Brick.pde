/* Brick.pde
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


public class Brick extends FBox implements Sounding
{  
    private SoundFile sound;
    
    public Brick()
    {
        this(45, 20, #CB4154); // Brick red, see http://latexcolor.com/
    }
    
    
    public Brick(float w, float h, color col)
    {
        super(w, h);
        this.setFillColor(col);
        
        this.setDamping(0.2);
        this.setDensity(20000.0);
        this.setRestitution(0.0);
        
        // Brick dropped on other bricks by jackmurrayofficial used under CC 0
        // https://freesound.org/s/429402/
        this.sound = new SoundFile(Fisica.parent(), "429402__jackmurrayofficial__brick-dropped-on-other-bricks_cut.wav");
    }
    
    
    public void playSound(float amplitude)
    {
        this.sound.amp(amplitude);
        this.sound.play();
    }
}
