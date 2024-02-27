*
* $Id: uprogcdf.cdf,v 1.2 1997/11/28 17:27:11 mclareni Exp $
*
* $Log: uprogcdf.cdf,v $
* Revision 1.2  1997/11/28 17:27:11  mclareni
* Numerous mods and some new routines to get Control-C working reasonably on NT
*
* Revision 1.1.1.1  1996/03/08 15:33:06  mclareni
* Kuip
*
*   1997/11/28 15:33:06  V.Fine
*
*  To check ctrl-C handling:
*
*    The upper limit for the the max number of the random numbers
*    has been increased (up to 10000) to let user some time to press
*    Ctrl-C keys.
*
*
>Name TESTD

>Menu RANDOM

>Command SEED
>Parameters
+
OPTION 'Option' C D='G' R='G,S'
SEED   'Seed value' I D=123
>Guidance
Get (option='G') or Set (option='S')
the seed for the random number generator
>Action TSEED

>Command NUMBER
>Parameters
N      'How many random numbers ?' I D=1 R=1:10000
+
FORMAT 'FORTRAN format' C D='10F7.3'
>Guidance
Print N random numbers generated by the routine RNDM.
Optionally a FORMAT can be specified.
>Action NUMLET

>Command LETTER
>Parameters
N      'How many random letters ?' I D=1 R=1:10000
+
FORMAT 'FORTRAN format' C D='40(1X,A1)'
>Guidance
Print N random letters (from 'A' to 'Z') using the routine RNDM.
Optionally a FORMAT can be specified.
>Action TSEED
>Action NUMLET

