# Shader Demo
This is the demo for pixelated/band limited light.
It is a very simple shader!

Light is band limited by choosing an amount of levels of grey in the final shader color. Here you see the result on a grey gradient from black to white.
![](https://github.com/laverneth/ShaderDemo/blob/main/01_bands.gif)

The contrast is then adjusted, notice how it change the importance of certain nuances of grey in the gradient.
![](https://github.com/laverneth/ShaderDemo/blob/main/02_contrast.gif)

The brightness can be adjusted too, shifting the leveled values to the left or to the right.
![](https://github.com/laverneth/ShaderDemo/blob/main/03_brightness.gif)

The number of pixels (from 1 to 8) merging can be also picked. It reflects how many pixels in the rendered image will be merged into a single pixel in the final image (for a single direction. For example choosing  means that the final pixel will represent a block of 4-by-4 pixels).
![](https://github.com/laverneth/ShaderDemo/blob/main/04_pixels.gif)

That's all folks!
Enjoy!
Thomas
