/* SoccerBall.pde
 *
 * Copyright 2018, 2019, 2020 Roland Richter
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

// TOUR-12 I am the author of this file, and of all files of FisicaGame; 
//   it says so in the copyright notice above. You are NOT allowed to
//   remove this copyright notice.
//
//   However, I released FisicaGame under the terms of a _free software_ 
//   license, namely, the _General Public License_. It guarantees you
//   _four freedoms_; this means you are free to
//   (0) run the program as you wish, for any purpose;
//   (1) study how the program works, and change it;
//   (2) redistribute copies so you can help others; and
//   (3) distribute copies of your modified versions to others.
//   Colloquially, free software is "free as in speech", but not necessarily
//   "free as in beer"; see also https://www.gnu.org/philosophy/free-sw
//
//   So, you are allowed to run, copy, distribute, study, change and improve
//   FisicaGame, or parts of it, provided that you
//   (1) add a copyright notice of the form "Copyright 2020 Your Name", and
//   (2) stick with the General Public License. That is, you must not distribute
//       FisicaGame under some other license; this rule is called _copyleft_.
//
//    For more details, see https://www.gnu.org/licenses/gpl-howto
//
// Ok ... now you can really start to do HOMEWORK-1-a.

public class SoccerBall extends FCircle
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
}
