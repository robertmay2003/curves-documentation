---
title: "Cycles"
date: 2020-09-02T17:21:15-04:00
draft: true
weight: 5
---
#

The `Cycles` modifier samples a defined portion of the curve and loops it throughout the modifier's range.

### Types
* Any

### Constructor

{{< lead >}} `new` Cycles\<`T`\> `(` {{< /lead >}}
{{< lead >}} `    startTime: number,` {{< /lead >}}
{{< lead >}} `    endTime: number,` {{< /lead >}}
{{< lead >}} `    rangeStart: number | undefined = undefined,` {{< /lead >}}
{{< lead >}} `    rangeEnd: number | undefined = undefined,` {{< /lead >}}
{{< lead >}} `)` {{< /lead >}}

`startTime`: The beginning time of the range from which the curve will be sampled for the loop.\
`endTime`: The ending time of the range from which the curve will be sampled for the loop.\
`rangeStart`: The time at which the modifier begins to modify the curve.\
`rangeEnd`: The time at which the modifier no longer modifies the curve.\

{{< panel style="warning" >}} The `Cycles` modifier requires configuration, since its output depends not only on the evaluation time and value, but on the rest of the curve itself. This configuration occurs automatically whenever the curve to which it belongs is updated. However, if a `Cycles` modifier belongs to multiple curves, it might produce unexpected results. {{< /panel >}}

{{< code lang="typescript" >}}
import { Modifiers, RGBColor } from 'curves'; // Import Modifiers

const numberCycles = new Modifiers.Any.Cycles<number>(0, 1); // Create a new number cycles modifier
const rgbCycles = new Modifiers.Any.Cycles<RGBColor>(2, 6.5); // Create a new color cycles modifier
{{< /code >}}