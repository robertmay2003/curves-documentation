---
title: "Step"
date: 2020-09-02T17:21:15-04:00
draft: true
weight: 4
---
#

The `Step` modifier transforms the curve into a step function.

### Types
* Number
* List
* RGBColor
* HSVColor
* Vector3

### Constructor

{{< lead >}} `new` Step `(` {{< /lead >}}
{{< lead >}} `    stepLength: number,` {{< /lead >}}
{{< lead >}} `    rangeStart: number | undefined = undefined,` {{< /lead >}}
{{< lead >}} `    rangeEnd: number | undefined = undefined,` {{< /lead >}}
{{< lead >}} `)` {{< /lead >}}

`stepLength`: The vertical distance between each step.\
`rangeStart`: The time at which the modifier begins to modify the curve.\
`rangeEnd`: The time at which the modifier no longer modifies the curve.\

{{< code lang="typescript" >}}
import { Modifiers } from 'curves'; // Import Modifiers

const numberStep = new Modifiers.Number.Step(1); // Create a new number step modifier
const rgbStep = new Modifiers.RGB.Step(25); // Create a new color step modifier
{{< /code >}}