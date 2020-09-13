---
title: "Typed Keyframes"
date: 2020-09-06T04:45:10-04:00
draft: true
---
#

There are a number of built in subclasses of the [Keyframe]({{< ref "/keyframe" >}} "`Keyframe<T>`") class for primitive types and data structures.

---

### Number Keyframe
{{< lead >}} `new` NumberKeyframe `(time: number, value: number, inEasing: Easing = Easing.cubic, outEasing: Easing | undefined = undefined)` {{< /lead >}}
The `NumberKeyframe` class interpolates between number values.

---

### String Keyframe
{{< lead >}} `new` StringKeyframe `(time: number, value: string, inEasing: Easing = Easing.cubic, outEasing: Easing | undefined = undefined)` {{< /lead >}}
The `StringKeyframe` class interpolates between string values.

---

### Boolean Keyframe
{{< lead >}} `new` BooleanKeyframe `(time: number, value: boolean, inEasing: Easing = Easing.cubic, outEasing: Easing | undefined = undefined, solveInterpolation = false, truthThreshold = 0.5)` {{< /lead >}}
The `BooleanKeyframe` class interpolates between boolean values. There are two ways it can interpolate between boolean values: through interpolation with a truth threshold, or through simply returning the boolean value of the current keyframe.\
If `solveInterpolation` is true, the resulting value of the `interpolate` method will be solved by interpolating between the values of the current and next keyframe, where `true = 1` and `false = 0`. Whether the resulting value is `true` or `false` is determined by the condition `value > truthThreshold`.

---

### RGB Color Keyframe
{{< lead >}} `new` RGBColorKeyframe `(time: number, value: RGBColor, inEasing: Easing = Easing.cubic, outEasing: Easing | undefined = undefined)` {{< /lead >}}
The `RGBColorKeyframe` class interpolates between [RGBColor]({{< ref "/interfaces/#RGBColor" >}} "`RGBColor`") values.\
The `RGBColorKeyframe` class contains a single custom method.

#### To Float Keyframe
{{< lead >}} toFloatKeyframe `(): NumberKeyframe[]` {{< /lead >}}
The `toFloatKeyframe` method converts the `RGBColorKeyframe` to a list of `NumberKeyframe` values. The first value of the list corresponds to the `r` value, the second to the `g` value, and the third to the `b` value.

---

### HSV Color Keyframe
{{< lead >}} `new` HSVColorKeyframe `(time: number, value: HSVColor, inEasing: Easing = Easing.cubic, outEasing: Easing | undefined = undefined)` {{< /lead >}}
The `HSVColorKeyframe` class interpolates between [HSVColor]({{< ref "/interfaces/#HSVColor" >}} "`HSVColor`") values.\
The `HSVColorKeyframe` class contains a single custom method.

#### To Float Keyframe
{{< lead >}} toFloatKeyframe `(): NumberKeyframe[]` {{< /lead >}}
The `toFloatKeyframe` method converts the `HSVColorKeyframe` to a list of `NumberKeyframe` values. The first value of the list corresponds to the `h` value, the second to the `s` value, and the third to the `v` value.

---

### Vector3 Keyframe
{{< lead >}} `new` Vector3Keyframe `(time: number, value: Vector3, inEasing: Easing = Easing.cubic, outEasing: Easing | undefined = undefined)` {{< /lead >}}
The `Vector3Keyframe` class interpolates between [Vector3]({{< ref "/interfaces/#Vector3" >}} "`Vector3`") values.\
The `Vector3Keyframe` class contains a single custom method.

#### To Float Keyframe
{{< lead >}} toFloatKeyframe `(): NumberKeyframe[]` {{< /lead >}}
The `toFloatKeyframe` method converts the `Vector3Keyframe` to a list of `NumberKeyframe` values. The first value of the list corresponds to the `x` value, the second to the `y` value, and the third to the `z` value.

---

### List Keyframe
{{< lead >}} `new` ListKeyframe `(time: number, value: number[], inEasing: Easing = Easing.cubic, outEasing: Easing | undefined = undefined, truncate = false)` {{< /lead >}}
The `NumberKeyframe` class interpolates between arrays of numbers.
The `truncate` argument tells the keyframe whether or not to truncate the excess values when interpolating with a list with greater number of values than the other.\
    If `truncate = false`, the excess values will interpolate to `0`.\
    If `truncate = true`, the excess values will not be returned by interpolation.\

The `ListKeyframe` class contains a single custom method.

#### To Float Keyframes
{{< lead >}} toFloatKeyframes `(): NumberKeyframe[]` {{< /lead >}}
The `toFloatKeyframe` method converts the `ListKeyframe` to a list of `NumberKeyframe` values. The list contains one `NumberKeyframe` for each number in the list.

---

### Object Keyframe
{{< lead >}} `new` ObjectKeyframe `(time: number, value: object, inEasing: Easing = Easing.cubic, outEasing: Easing | undefined = undefined)` {{< /lead >}}
The `ObjectKeyframe` can interpolate between any two JSON objects. It constructs keyframes for each value in the object, including an `ObjectKeyframe` for each nested object. It can also detect CSS color strings and interpolate between them as colors.

---

## Bezier Curves

There is also a `Keyframe` type that supports cubic Bezier interpolation.

### Bezier Keyframe
{{< lead >}} `new` BezierKeyframe `(` {{< /lead >}}
{{< lead >}} `    time: number,` {{< /lead >}}
{{< lead >}} `    value: number,` {{< /lead >}}
{{< lead >}} `    inHandle: BezierHandle | undefined = undefined,` {{< /lead >}}
{{< lead >}} `    outHandle: BezierHandle | undefined = new BezierHandle(Math.PI),` {{< /lead >}}
{{< lead >}} `    defaultMagnitude = 1` {{< /lead >}}
{{< lead >}} `)` {{< /lead >}}

`inHandle`: The [BezierHandle]({{< ref "/keyframe/typedkeyframes#bezier-handles" >}} "`BezierHandle`") used to control easing into the curve (to the right of or after the keyframe). If `inHandle` is `undefined`, the keyframe will use automatic handles.\
`outHandle`: The [BezierHandle]({{< ref "/keyframe/typedkeyframes#bezier-handles" >}} "`BezierHandle`") used to control easing out of the curve (to the left of or before the keyframe).\
`defaultMagnitude`: The default magnitude of the keyframe's handles.

The `BezierKeyframe` is an alternative implementation of `Keyframe<number>` that uses bezier handles to ease the curve rather than an `Easing` function from the [eaz](https://npmjs.org/package/eaz) package.

{{< panel title="Handle Restrictions" style="info" >}} If one of the handles has too great a magnitude or an angle outside of a specific range, it could cause the curve to have multiple y values for one x value. In other words, it would fail the vertical line test and fail to be a function. In order to ensure that this is never the case to preserve the functionality of the curve, the handles are automatically restricted to this magnitude and range on `configure`.\
If the handles are changed and `configure` is not called, keyframe could yield an unexpected result or throw an error. {{< /panel >}}

### Bezier Handles
{{< lead >}} `new` BezierHandle `(angle: number, magnitude = 1)` {{< /lead >}}
Each `BezierHandle` contains an angle (in radians) and a magnitude. 

##### To Cartesian
{{< lead >}} toCartesian `(origin: {x: number, y: number}): {x: number, y: number}` {{< /lead >}}
Convert the bezier handle from polar coordinates to cartesian coordinates.

##### From Cartesian
{{< lead >}} fromCartesian `(origin: {x: number, y: number}, coordinates: {x: number, y: number}): void` {{< /lead >}}
Set the angle and magnitude of the `BezierHandle` from its origin and cartesian coordinates.

### Automatic Handles
{{< lead >}} `static` automatic `(time: number, value: number, magnitude = 1): BezierKeyframe` {{< /lead >}}
The `BezierKeyframe` class contains a static method for easily creating bezier keyframes with automatically generated and configured handles. Automatic handles have their angles calculated to make the curve as smooth as possible.

{{< panel style="info" >}} The `automaticHandles` property of a `BezierKeyframe` dictates whether or not the keyframe's handles are automatically generated and configured. This property can be `read` or `written`. {{< /panel >}}
