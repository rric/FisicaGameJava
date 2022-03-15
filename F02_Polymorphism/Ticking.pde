/* Ticking.pde
 * Copyright 2018-2022 Roland Richter
 */


// TOUR-8 Here is another interface: Ticking. You already know that this is kind
//   of a contract: all classes which implement the Ticking interface must provide 
//   the tick() method.
//   So, lets find out which classes actually do implement the Ticking interface:
//   With your mouse, right-click on the word "Ticking", and select "Show usage..."
//   ... yep, Ticking is implemented by our new classes, BurstBall and SoapBubble.
public interface Ticking
{
    // tick() is called with every call of draw()
    public void tick();
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
 
