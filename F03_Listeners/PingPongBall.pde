/* PingPongBall.pde
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


public class PingPongBall extends FCircle implements Sounding
{
    public PingPongBall()
    {
        super(16);
        this.setFillColor(#FFFFFF); // white
        
        this.setDamping(0.2);
        this.setDensity(300.0);
        this.setRestitution(0.9);
        
        // Dropping ping pong ball on table by giddster, used under CC 0
        // https://freesound.org/s/414460/
        this.sound = new SoundFile(Fisica.parent(), "414460__giddster__dropping-ping-pong-ball-on-table_cut.wav");
    }
    
    public void playSound(float amplitude)
    {
        this.sound.amp(amplitude);
        this.sound.play();
    }
    
    protected SoundFile sound;
}
