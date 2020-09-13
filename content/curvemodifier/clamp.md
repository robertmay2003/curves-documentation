---
title: "Clamp"
date: 2020-09-02T17:21:15-04:00
draft: true
weight: 2
---
#

The `Clamp` modifier clamps the evaluated value of the curve between a minimum and maximum value.

### Types
* Number
* List
* RGBColor
* HSVColor
* Vector3

### Constructor

{{< lead >}} `new` Clamp `(` {{< /lead >}}
{{< lead >}} `    min: `[Type]`,` {{< /lead >}}
{{< lead >}} `    max: `[Type]`,` {{< /lead >}}
{{< lead >}} `    rangeStart: number | undefined = undefined,` {{< /lead >}}
{{< lead >}} `    rangeEnd: number | undefined = undefined,` {{< /lead >}}
{{< lead >}} `)` {{< /lead >}}

`min`: The minimum return value of the modifier.\
`max`: The maximum return value of the modifier.\
`rangeStart`: The time at which the modifier begins to modify the curve.\
`rangeEnd`: The time at which the modifier no longer modifies the curve.\

The `min` and `max` values should be the same type as the curve the modifier is being applied to, but for `RGBColor` and `Vector3` clamp modifiers, you can pass in a single number to be used for each property of the minimum and maximum values.

For a `number[]` clamp modifier, use a `number` value for the `min` and `max` values. This value applies to every element in the list.

{{< code lang="typescript" >}}
import { Modifiers } from 'curves'; // Import Modifiers

const numberClamp = new Modifiers.Number.Clamp(0, 1); // Create a new number clamp modifier
const rgbClamp = new Modifiers.RGB.Clamp(
    {r: 0, g: 0, b: 100},
    {r: 100, g: 255, b: 255}
); // Create a new color clamp modifier
{{< /code >}}