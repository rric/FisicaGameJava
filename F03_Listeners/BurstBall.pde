/* BurstBall.pde
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


public class BurstBall extends SoccerBall implements Ticking
{   
    public BurstBall()
    {
        this(40, color(#0892D0), 300);   // Size 40, color Rich electric blue, maxAge 300
    }


    public BurstBall(float size, color col, int maxAge)
    {
        super(size, col);

        // video game >> burst2.wav by ReadeOnly, used under CC 0, from
        // https://freesound.org/s/186927/
        this.bang = new SoundFile(Fisica.parent(), "186927__readeonly__burst2.wav");

        this.lifespan = maxAge;
    }


    public void tick()
    {
        // BurstBall bursts when it reaches the end of its lifespan
        --lifespan;

        if (lifespan <= 0)
        {
            this.burst();
        }    
    }
    
    
    protected void burst()
    {
        this.bang.play();
        this.m_world.remove(this);
    }

    protected SoundFile bang;
    protected int lifespan;
}
