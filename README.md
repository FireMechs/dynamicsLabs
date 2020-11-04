#		Dynamics of Planar Mechanisms Lab 1

Lab work uses chebyshev's spacing to find 3 and 5 precision points of angles in range
15-165. Using the precision points and the mechanism's output functions 

```equation
	O4 = 65 + 0.43 x O2
```

output angles 'O4' is obtained. With the two, input angles and output angles, link ratios 
are computed using the Freudeinsten's equation. Given the length of the fixed link, the 
other link lengths are calculated from the link ratios. Finally structural errors are
calculated using the link lengths and the ratios.

### Usage

Clone the directory into a matlab path 

```git
	git clone https://www.github.com/FireMechs/dynamicLabs.git
```

Open up the script 'lab1.m' and invoke 'lab1' from the command windows in MatLab

### Info

This is a matlab port of a python implementation of the labwork at 
https://gitlab.com/0x6f736f646f/dynamics-of-planar-mechanism. 
