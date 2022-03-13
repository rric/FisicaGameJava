/* Plank.pde
 * Copyright 2018-2022 Roland Richter
 */

// TOUR-3 Here, a _class_ called Plank is declared.
//   Lets inspect each of the five words in the _declaration_ below:
//
//   - public is a keyword; it means that the following is publicly visible
//   - class is a keyword; it is used to declare a class
//   - Plank is the class name; you can use almost any name here.
//     It's good practice to declare class Plank in a file also called Plank.
//   - extends is a keyword: it means that Plank is _derived from_ another
//     class, namely, FBox. Plank _inherits_ all the data fields and methods
//     of FBox. In short, Plank _is-a_ FBox
//   - FBox is a class which is already declared in the fisica library;
//     see http://www.ricardmarxer.com/fisica/reference/fisica/FBox.html
//
//   Plank is said to be a _subclass_ of FBox; and FBox is said to be the
//   _superclass_ of Plank. Note that a subclass can have only one superclass;
//   but that a superclass can have many different subclasses.
//   As a consequence, Plank and FBox both are part of a _class hierarchy_,
//   or class tree, which you can see here:
//   http://www.ricardmarxer.com/fisica/reference/fisica/package-tree.html

public class Plank extends FBox
{
    // TOUR-5 To create an object of class Plank, one needs a special 
    //   method which is also named Plank -- just like the class itself.
    //   Such a method is called _constructor_.
    // 
    //   The constructor takes three arguments to initialize this object:
    //   `w` is the width, `h` is the height of the plank; both values are 
    //   decimal numbers of type float. `clr` is the color of the plank.
    //
    //   For more information on the types float and color,
    //   see https://www.processing.org/reference/float.html
    //   and https://www.processing.org/reference/color_datatype.html
    public Plank(float w, float h, color clr)
    {
        // TOUR-6
        //   - `super` is a keyword; here it is used to call the constructor of
        //     the superclass of Plank, which is FBox
        //   - `this` is a keyword; here it means "use the current object",
        //     and is redundant; you might as well delete it. (Try it!)
        //     I am used to write `this.` in front of any class method, but I
        //     think it is not very common to do so.
        super(w, h);
        this.setFillColor(clr);
        
        this.setDamping(0.2);
        this.setDensity(7000.0);
        this.setRestitution(0.1);
    }
    
    // TOUR-5-a Here is another constructor to be used if somebody only specifies
    //   `w` (width) and `h` (height) of the plank to be created. In this case,
    //   `w`, `h`, and a default color (namely, #80461B) is passed to the first
    //   constructor above.
    public Plank(float w, float h)
    {
        this(w, h, #80461B); // Russet, see http://latexcolor.com/
    }
    
    // TOUR-5-b Yet another constructor to be used if somebody specifies nothing
    //   at all about the plank to be created; hence, we have to use default 
    //   values for width (350) and height (15) as well.
    //   Such a method is called _default constructor_.
    public Plank()
    {
        this(350, 15);
    }
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
 
