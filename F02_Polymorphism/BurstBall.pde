/* BurstBall.pde
 * Copyright 2018-2022 Roland Richter
 */


public class BurstBall extends SoccerBall implements Ticking
{   
    public BurstBall()
    {
        this(40, color(#0892D0), 300);   // Size 40, color Rich electric blue, maxAge 300
    }


    public BurstBall(float diam, color clr, int maxAge)
    {
        super(diam, clr);

        // TOUR-12 Freesound is a collaborative database of audio snippets, 
        //   samples, recordings, etc., all released under some permisive 
        //   Creative Commons license. 
        //   "CC 0" here is short for "Creative Commons Zero", and basically
        //   means "public domain"; that is, I am free to re-use this sound 
        //   without mentioning the author. I do mention her/him, anyway: 
        //
        // video game >> burst2.wav by ReadeOnly, used under CC 0, from
        // https://freesound.org/s/186927/
        this.bang = new SoundFile(Fisica.parent(), "186927__readeonly__burst2.wav");

        this.lifespan = maxAge;
    }


    // TOUR-10 Another tick reduces a BurstBalls life span by 1. When its life
    //   span reaches 0, it bursts ...
    public void tick()
    {
        // BurstBall bursts when it reaches the end of its lifespan
        --lifespan;

        if (lifespan <= 0)
        {
            this.burst();
        }    
    }
    
    // TOUR-11 ... it bursts with a loud bang, and is removed from our world.
    //   Note that this method is _protected_; it can be called only from
    //   within methods of BurstBall, or its descendants (if there were any).
    //   
    //   Each and every FBody contains a reference to the world it was added, called 
    //   m_world. By convention, an "m_" prefix indicates a protected member field.
    //   This is kind of a hack, since m_world is not mentioned in the documentation.
    protected void burst()
    {
        this.bang.play();
        this.m_world.remove(this);
    }

    protected SoundFile bang;
    protected int lifespan;
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
 
