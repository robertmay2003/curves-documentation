---
title: "Sine"
date: 2020-09-02T17:21:15-04:00
draft: true
weight: 3
---
#

The `Sine` modifier uses a sine wave to modify the output of the curve.

### Types
* Number
* List
* RGBColor
* HSVColor
* Vector3
* Boolean

### Constructor

{{< lead >}} `new` Sine `(` {{< /lead >}}
{{< lead >}} `    blendMode: SineModifierBlendMode,` {{< /lead >}}
{{< lead >}} `    amplitude: number,` {{< /lead >}}
{{< lead >}} `    wavelength: number,` {{< /lead >}}
{{< lead >}} `    phaseOffset: number,` {{< /lead >}}
{{< lead >}} `    rangeStart: number | undefined = undefined,` {{< /lead >}}
{{< lead >}} `    rangeEnd: number | undefined = undefined,` {{< /lead >}}
{{< lead >}} `)` {{< /lead >}}

`blendMode`: The manner in which the sine wave will modify the curve.\
`amplitude`: The amplitude of the sine wave.\
`wavelength`: The wavelength of the sine wave.\
`phaseOffset`: The phase offset (transformation on the x-axis) of the sine wave.\
`rangeStart`: The time at which the modifier begins to modify the curve.\
`rangeEnd`: The time at which the modifier no longer modifies the curve.\

### Blend Mode

The `SineModifierBlendMode` enum contains 5 values, each representing a method that can be used to blend the sine wave with the curve.

* *Replace* - Adds the raw wave value to the curve.
* *Add* - Adds the positive wave value to the curve (a wave value of `-1` is treated as `0`).
* *Subtract* - Adds the negative wave value to the curve (a wave value of `1` is treated as `0`).
* *Multiply* - Multiplies the raw wave value by the curve.
* *MultiplyPositive* - Multiplies half the positive wave value by the curve (a wave value of `-1` is treated as `0` and a wave value of `1` is treated as `1`).
 
{{< code lang="typescript" >}}
import { Modifiers, SineModifierBlendMode } from 'curves'; // Import Modifiers

const numberSine = new Modifiers.Number.Sine(); // Create a new number sine modifier
const rgbSine = new Modifiers.RGB.Sine(
    SineModifierBlendMode.MultiplyPositive,
    2,
    3
); // Create a new color sine modifier
{{< /code >}}