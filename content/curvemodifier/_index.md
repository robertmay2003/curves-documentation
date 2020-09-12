---
title: "CurveModifier"
date: 2020-09-02T17:21:15-04:00
draft: true
weight: 2
---
#

Curve modifiers are used to apply modifications to the values returned by evaluating a curve. They function similarly to Blender's [F-Curve Modifiers](https://docs.blender.org/manual/en/latest/editors/graph_editor/fcurves/modifiers.html).

## Modifier Class

All modifiers must extend the abstract generic `CurveModifier<T>` class. The type argument `T` of the `CurveModifier` class indicates the type returned by applying the modifier to a curve.\

A modifier can only be applied to a curve that returns the same type as the modifier. For example, an implementation of `CurveModifier<number>` can only be applied to an implementation of `Curve<number>`.

{{< panel title="Flexibility" style="success">}} The `CurveModifier` class is simple to implement. Due to its abstract and generic nature, you can easily define a subclass of the `CurveModifier` class that implements any chosen modification for any chosen type. Curves that return values of custom types can be modified, and any modification can be implemented.{{< /panel >}}

### Constructor

{{< lead >}} `new` CurveModifier\<`T`\> `(` {{< /lead >}}
{{< lead >}} `    rangeStart: number = Number.MIN_VALUE,` {{< /lead >}}
{{< lead >}} `    rangeEnd: number = Number.MAX_VALUE,` {{< /lead >}}
{{< lead >}} `)` {{< /lead >}}

`rangeStart`: The time at which the modifier begins to modify the curve.\
`rangeEnd`: The time at which the modifier no longer modifies the curve.\

The `rangeStart` and `rangeEnd` parameters are relative to the duration of the curve, meaning that a value of `0` references the beginning of the curve and a value of `1` references the end. However, as a curve can be evaluated beyond its start and end times, the `rangeStart` and `rangeEnd` can extend beyond the ends of the curve as well. By default, they are the minimum and maximum number values respectively, meaning that the modifier will be active at any given evaluation time.

{{< panel style="warning" >}} The `CurveModifier<T>` class is abstract, so its constructor cannot be used outside of the constructor of a subclass as a `super` call. Objects of the abstract `CurveModifier<T>` class cannot be instantiated. {{< /panel >}}

## Implementation

The `CurveModifier<T>` class only has one abstract method that must be implemented, and one optional method that can be overwritten.

### Modify
{{< lead >}} `protected abstract` _modify `(value: T, time: number): T` {{< /lead >}}

`value`: The value returned by evaluating the curve.\
`time`: The time at which the curve was evaluated.

The `_modify` method is called on each evaluation. It contains the logic that applies a modification to a curve.

{{< code lang="typescript" >}}
// Implementation of the _modify method in the `Clamp` modifier for numbers
protected _modify(value: number, time: number): number {
    // this.min and this.max refer to values defined in the Clamp modifier's constructor
    return Math.min(Math.max(value, this.min), this.max);
}
{{< /code >}}

### Configure
{{< lead >}} configure `(curve: Curve<T>)` {{< /lead >}}

Some modifiers require configuration based on the curve they modify. The `configure` method is implemented as an empty method; overwriting it is optional.
{{< panel style="info" >}} The `configure` method is only called when the `update` method of the curve to which the keyframe belongs is called. If the modifier applies to multiple curves and `configure` is not called before curve evaluation, unexpected consequences may occur. {{< /panel >}}

## Usage

An implemented subclass of `CurveModifier<T>` is used by adding the modifier to a curve, via either the [Curve.addModifier]({{< ref "/curve#addmodifier" >}} "`Curve.addModifier`") method or directly accessing the curve's [modifiers]({{< ref "/curve#modifiers" >}} "`modifiers`") list. If added to a curve, it will be applied automatically using the `evaluate` method. However, it can also be used independently of a curve with the `modifyExternal` method.

### Evaluate
{{< lead >}} evaluate `(curve: Curve<T>, value: T, time: number): T` {{< /lead >}}

The `evaluate` method determines whether or not the modifier should be applied based on the modifier's `rangeStart` and `rangeEnd` values. If the `time` falls within the range (relative to the duration of the curve), the modifier is applied and the modified value is returned. Otherwise, the unmodified value is returned.

### Modify External
{{< lead >}} modifyExternal `(value: T, time: number): T` {{< /lead >}}

The `modifyExternal` method applies the modifier to the value passed in, regardless of the modifier's `rangeStart` and `rangeEnd` values.

{{< panel style="warning" >}} For modifiers that require configuration, the modification is dependent on the curve being modified, and thus the `modifyExternal` method, which applies the modification with no specified curve, could yield unexpected results. {{< /panel >}}

## Accessing Modifiers

Modifiers are organized by the type to which they apply. To access a modifier, use the following format:\
`Modifiers.`[`Type`]`.`[`Modifier Name`]

{{< code lang="typescript" >}}
import { Modifiers } from 'curves'; // Import Modifiers

const numberClamp = new Modifiers.Number.Clamp(0, 1); // Create a new number clamp modifier
const rgbNoise = new Modifiers.RGB.Noise(); // Create a new color noise modifier

// Use the two previously defined modifiers to define an object aggregate modifier
const objectAggregate = new Modifiers.Object.Aggregate({
    number: [numberClamp],
    color: [rgbNoise],
}); 
{{< /code >}}