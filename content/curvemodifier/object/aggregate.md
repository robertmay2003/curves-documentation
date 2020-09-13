---
title: "Aggregate"
date: 2020-09-02T17:21:15-04:00
draft: true
---
#

The `Aggregate` modifier stores a list of modifiers for each type. Each value of each key will have the list of modifiers corresponding to its type applied to it.

### Types
* Object

### Aggregate Elements
{{< lead >}} `type` AggregateElements `= {` {{< /lead >}}
{{< lead >}} `    number?: CurveModifier<number>[],` {{< /lead >}}
{{< lead >}} `    boolean?: CurveModifier<boolean>[],` {{< /lead >}}
{{< lead >}} `    string?: CurveModifier<string>[],` {{< /lead >}}
{{< lead >}} `    list?: CurveModifier<number[]>[],` {{< /lead >}}
{{< lead >}} `    color?: CurveModifier<RGBColor>[]` {{< /lead >}}
{{< lead >}} `}` {{< /lead >}}

An `AggregateElements` object contains a list of modifiers to be applied for each type.

### Constructor

{{< lead >}} `new` Aggregate `(` {{< /lead >}}
{{< lead >}} `    elements AggregateElements,` {{< /lead >}}
{{< lead >}} `    rangeStart: number | undefined = undefined,` {{< /lead >}}
{{< lead >}} `    rangeEnd: number | undefined = undefined,` {{< /lead >}}
{{< lead >}} `)` {{< /lead >}}

`elements`: The `AggregateElements` object that contains each type's modifier list.\
`rangeStart`: The time at which the modifier begins to modify the curve.\
`rangeEnd`: The time at which the modifier no longer modifies the curve.\

Any CSS color strings found in the value being modified will be converted to colors to have the `color` modifier list applied, and will then be converted back to CSS color strings.

{{< code lang="typescript" >}}
import { Modifiers } from 'curves'; // Import Modifiers

const aggregate = Modifiers.Object.Aggregate({
    number: [new Modifiers.Number.Noise(), new Modifiers.Number.Clamp()],
    string: [new Modifiers.String.Ranges()],
}) // Create an aggregate modifier
{{< /code >}}