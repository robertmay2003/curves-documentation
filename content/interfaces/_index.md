---
title: "Interfaces"
date: 2020-09-02T17:21:15-04:00
draft: true
weight: 4
---
#

The `RGBColor`, `HSVColor`, and `Vector3` interfaces are used throughout the [curves](https://npmjs.org/package/curves) module to work with colors and three-dimensional vector quantities.

### RGBColor

The `RGBColor` interface is used in `RGBColor` keyframes, curves, and modifiers. It refers to any object with an `r` value, a `g` value, and a `b` value, used to reference a color's RGB code.
{{< code lang="typescript" >}}
import { RGBColor } from 'curves'; // Import

// Example
const color: RGBColor = {
    r: 32,       // Between 0 - 255
    g: 240,      // Between 0 - 255
    b: 120,      // Between 0 - 255
}
{{< /code >}}

### HSVColor

The `HSVColor` interface is used in `HSVColor` keyframes, curves, and modifiers. It refers to any object with an `h` value, a `s` value, and a `v` value, used to reference a color's HSV code.

{{< panel style="info" >}} You can convert HSV values to HSL values and vice versa using the [ColorHelper]({{< ref "/color_helper" >}} "ColorHelper"). {{< /panel >}}

{{< code lang="typescript" >}}
import { HSVColor } from 'curves'; // Import

// Example
const color: HSVColor = {
    h: 280,      // Between 0 - 360
    s: 40,       // Between 0 - 100
    v: 100,      // Between 0 - 100
}
{{< /code >}}

### Vector3

The `Vector3` interface is used in `Vector3` keyframes, curves, and modifiers. It refers to any object with an `x` value, a `y` value, and a `z` value, used to reference a position, rotation, scale, or any other 3-dimensional vector quantities.

{{< code lang="typescript" >}}
import { Vector3 } from 'curves'; // Import

// Example
const position: Vector3 = {
    x: 10,
    y: 32,
    z: 100,
}
{{< /code >}}