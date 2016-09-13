# lampyridae.coffee

#### A simple suite of particle effects written in CoffeeScript

[![GitHub latest](https://img.shields.io/github/tag/siviter-t/lampyridae.coffee.svg?label=latest)](https://github.com/siviter-t/lampyridae.coffee)
[![npm](https://img.shields.io/npm/v/lampyridae.coffee.svg)](https://www.npmjs.com/package/lampyridae.coffee)
[![MIT license](https://img.shields.io/github/license/mashape/apistatus.svg)](http://opensource.org/licenses/MIT)

***

> The _**Lampyridae**_ are a family of insects in the beetle order Coleoptera. They are winged
> beetles, and commonly called *fireflies* or *lightning bugs* for their conspicuous use of
> bioluminescence during twilight to attract mates or prey. Fireflies produce a "cold light",
> with no infrared or ultraviolet frequencies.
> <p align="right">
> — <a href="https://en.wikipedia.org/wiki/Firefly">Wikipedia</a>, the free encyclopedia.
> </p>  

Lampyridae.coffee is a lightweight CoffeeScript library that can be used to produce simple 
two-dimensional particle effects with the canvas DOM element.

Still under active development.

### Quick Install

Simply grab the latest minified library from the [lib](lib) directory and include it in a HTML file using the usual script tags. For example

```<script type="text/javascript" src="path/to/js/lampyridae-*.*.*-min.js"></script>```

where the asterisks should be replaced by the corresponding version of the library you have downloaded and the path should be updated to its actual location for your installation.

You should now be good to go.

### Quick Example in CoffeeScript

Taking the namesake example of this library:

```
# Only the Canvas and base Particle classes are included by default
require 'particle/firefly'

# By default, if there is no existing canvas with the id 'world', this will
# attach '<canvas id="world"></canvas>' under the body element.
canvas = new Lampyridae.Canvas 'world'

total = 25                          # Number of fireflies to spawn
fireflies = []                      # For keeping track of the fireflies

createFireflies = () ->
  for i in [0...total]
    firefly = new Lampyridae.Firefly canvas
    fireflies.push firefly

update = () -> fireflies[i].update() for i in [0...total]

createFireflies()                   # Create the swarm of fireflies
canvas.addUpdate canvas.draw.clear  # If you want the screen to clear between frames
canvas.addUpdate update             # Update all the fireflies every frame
canvas.animate()                    # Animate the canvas screen
```

Compile this to JavaScript and include it like before after the body tags of the document. If all goes well, you should be able to see something like this Pen:

<p data-height="265" data-theme-id="0" data-slug-hash="mAVjzB" data-default-tab="result" data-user="siviter-t" data-embed-version="2" data-preview="true" class="codepen">See the Pen <a href="http://codepen.io/siviter-t/pen/mAVjzB/">Creating Fireflies with lampyridae.coffee</a> by Taylor Siviter (<a href="http://codepen.io/siviter-t">@siviter-t</a>) on <a href="http://codepen.io">CodePen</a>.</p>
<script async src="//assets.codepen.io/assets/embed/ei.js"></script>

### Source Code

There are two main options for obtaining this source code. You could clone a copy of this repository with git

```git clone https://github.com/siviter-t/lampyridae.coffee.git```

or you could use npm if you have it installed locally.

```npm install lampyridae.coffee```

Using npm might be a good idea mind as lampyridae uses a few development dependencies that are freely available on the platform; such as Brunch and Mocha.

### License

MIT License.

Copyright (c) 2016 Taylor Siviter.

See [LICENSE](LICENSE) for full information.