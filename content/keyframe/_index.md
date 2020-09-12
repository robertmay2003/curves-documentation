---
title: "Keyframe"
date: 2020-09-02T17:21:15-04:00
draft: true
weight: 1
---
#

The value of a curve at any given `time` value is determined by interpolating between the two keyframes immediately before and after the `time`. A curve is essentially defined by its keyframes.

## Keyframe Class

The `Keyframe<T>` class is generic and abstract. Any non-abstract subclass of the `Keyframe` class can be used in a curve.

{{< panel title="Flexibility" style="success">}} The `Keyframe` class is simple to implement. Due to its abstract and generic nature, you can easily define a subclass of the `Keyframe` class that implements the necessary logic for any chosen type. Even custom classes can be interpolated between, as long as you define an implementation of `Keyframe` for the custom class.{{< /panel >}}

### Constructor

{{< lead >}} `new` Keyframe\<`T`\> `(` {{< /lead >}}
{{< lead >}} `    time: number,` {{< /lead >}}
{{< lead >}} `    value: T,` {{< /lead >}}
{{< lead >}} `    inEasing: Easing = Easing.cubic,` {{< /lead >}}
{{< lead >}} `    outEasing: Easing | undefined = undefined` {{< /lead >}}
{{< lead >}} `)` {{< /lead >}}

`time`: The time of the keyframe.\
`value`: The value of the keyframe.\
`inEasing`: The [easing](https://npmjs.org/package/eaz) function used into the curve (to the right of or after the keyframe).\
`outEasing`: The [easing](https://npmjs.org/package/eaz) function used out of the curve (to the left of or before the keyframe). If left undefined, the `inEasing` value will be used.\

{{< panel style="warning" >}} The `Keyframe<T>` class is abstract, so its constructor cannot be used outside of the constructor of a subclass as a `super` call. Objects of the abstract `Keyframe<T>` class cannot be instantiated. {{< /panel >}}

## Implementation

The `Keyframe<T>` class only has one abstract method that must be implemented, and one optional method that can be overwritten.

### Interpolate
{{< lead >}} `abstract` interpolate `(keyframe: Keyframe<T>, time: number, smoothing: number): T` {{< /lead >}}

`keyframe`: The next keyframe to interpolate to. This method should return the result of interpolating between `this` (the current keyframe) and `keyframe` (the next keyframe).\
`time`: The time value used to interpolate between the two keyframes. The value should be between `0` and `1`: `0` represents the current keyframe and `1` represents the next.\
`smoothing`: The degree to which the two easing methods of the current and next keyframes are smoothly interpolated between. `0` means no interpolation, `1` means the two easing functions will be linearly interpolated between.\

{{< code lang="typescript" >}}
// Implementation of the interpolate method in the NumberKeyframe class
interpolate(keyframe: Keyframe<number>, time: number, smoothing = 0.25): number {
    // Linear interpolation function
    function lerp(a: number, b: number, t: number): number {
        return a + (b - a) * t;
    }

    // Interpolate between two values with eased time
    return lerp(
      this.value,
      keyframe.value,
      Easing.interpolate(this.inEasing, keyframe.outEasing, time, smoothing),
    );
}
{{< /code >}}

### Configure
{{< lead >}} configure `(curve: Curve<T>)` {{< /lead >}}

Some keyframes require configuration based on the curve to which they belong. The `configure` method is implemented as an empty method; overwriting it is optional.
{{< panel style="info" >}} The `configure` method is only called when the `update` method of the curve to which the keyframe belongs is called. If the keyframe belongs to multiple curves and `configure` is not called before curve evaluation, unexpected consequences may occur. {{< /panel >}}

## Usage

An implemented subclass of the `Keyframe<T>` class is used for interpolating between two values in real time.

### Interpolate Realtime
{{< lead >}} interpolateRealtime `(keyframe: Keyframe<T>, time: number, smoothing = 0.25): T` {{< /lead >}}

The `interpolateRealtime` method interpolates between the current keyframe and the next keyframe (passed in through the `keyframe` argument. The `time` value should be between the time of the current and next keyframe.