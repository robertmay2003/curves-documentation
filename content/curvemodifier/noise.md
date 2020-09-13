---
title: "Noise"
date: 2020-09-02T17:21:15-04:00
draft: true
weight: 1
---
#

The `Noise` modifier randomly modifies the output of the curve by adding simplex noise.

### Types
* Number
* List
* RGBColor
* HSVColor
* Vector3
* Boolean

### Constructor

{{< lead >}} `new` Noise `(` {{< /lead >}}
{{< lead >}} `    amplitude: number,` {{< /lead >}}
{{< lead >}} `    frequency: number,` {{< /lead >}}
{{< lead >}} `    seed: number = 0,` {{< /lead >}}
{{< lead >}} `    rangeStart: number | undefined = undefined,` {{< /lead >}}
{{< lead >}} `    rangeEnd: number | undefined = undefined,` {{< /lead >}}
{{< lead >}} `)` {{< /lead >}}

`amplitude`: The amplitude of the simplex noise.\
`frequency`: The frequency of the simplex noise.\
`seed`: The seed used to generate the simplex noise.\
`rangeStart`: The time at which the modifier begins to modify the curve.\
`rangeEnd`: The time at which the modifier no longer modifies the curve.\

{{< panel style="info" >}} Each value in the constructor has a default value scaled for the type to which they apply. For example, the default amplitude of a `number` noise modifier is 0.1 (for curves from 0 to 1), but the default amplitude of an `RGBColor` noise modifier is 25. Each default amplitude is about a 10th of the scale on which the curve is expected to exist.
 
 The `HSVColor` noise modifier multiplies the amplitude by `3.6` when modifying the `h` value in order to preserve the relative scale of the amplitude (both the `s` and `v` values fall within the range 0 to 100, while the `h` value falls within the range 0 to 360). {{< /panel >}} 

{{< code lang="typescript" >}}
import { Modifiers } from 'curves'; // Import Modifiers

const numberNoise = new Modifiers.Number.Noise(); // Create a new number noise modifier
const rgbNoise = new Modifiers.RGB.Noise(50, 5); // Create a new color noise modifier
{{< /code >}}