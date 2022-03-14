/* Resizable.pde
 *
 * Copyright 2020-2021 Roland Richter
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

// TOUR-4 Resizable is an _interface_, not a full-fledged class; it publishes
//   the names of some methods -- here, it's only one, resize() -- but it
//   does not provide an implementation. This is done later by classes which
//   _implement_ the interface.
public interface Resizable
{
    // Resize this object by factor; e.g.
    // factor = 2.5 -> resize this object to 250 %, i.e. 150 % larger
    // factor = 0.7 -> resize this object to 70 %, i.e. 30 % smaller
    // factor = 1.0 -> resize this object to 100 %, i.e. do not resize at all
    public void resize(float factor);
}
