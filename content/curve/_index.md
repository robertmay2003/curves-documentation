---
title: "Curve"
date: 2020-09-02T17:21:15-04:00
draft: true
weight: 1
---
#

A `Curve` is a collection of keyframes and modifiers for the purpose of creating any simple or complex curve that can be evaluated at any time. It also contains static methods that facilitate the creation of simple curves. 

{{< panel title="Generic Class" style="info" >}} The `Curve` class is generic, meaning it takes a type argument (when using TypeScript) that will declare the type of the value returned by evaluating the curve at any time. Throughout the documentation, this type will be referred to as `T`. {{< /panel >}}

## Constructor
{{< lead >}} `new` Curve\<`T`\> `(` {{< /lead >}}
{{< lead >}} `    keys: Keyframe<T>[] = [],` {{< /lead >}}
{{< lead >}} `    modifiers: CurveModifier<T>[] = [],` {{< /lead >}}
{{< lead >}} `    endBehavior: EndBehavior = EndBehavior.Clamp,` {{< /lead >}}
{{< lead >}} `    smoothing = 0.25` {{< /lead >}}
{{< lead >}} `)` {{< /lead >}}

`keys`: The list of [Keyframe]({{< ref "/keyframe" >}} "`Keyframes`") used to define the curve.\
`modifiers`: The list of [CurveModifier]({{< ref "/curvemodifier" >}} "`CurveModifiers`") that will be applied to the curve.\
`endBehavior`: The [EndBehavior]({{< ref "/curve/endbehavior" >}} "`EndBehavior`") used to define the curve's behavior beyond its first and last keyframes.\
`smoothing`: The degree to which different easing functions are smoothly transitioned into each other between keyframes.\

---

## Properties

#### `startTime`

The time of the first keyframe of the curve.

#### `endTime`

The time of the last keyframe of the curve.

#### `duration`

The difference in time between the first and last keyframes of the curve.

#### `smoothing`

The degree to which different easing functions are smoothly transitioned into each other between keyframes. This value is initally set in the constructor but can be modified at any time.

#### `endBehavior`

The [EndBehavior]({{< ref "/curve/endbehavior" >}} "`EndBehavior`") used to define the curve's behavior beyond its first and last keyframes. This value is initally set in the constructor but can be modified at any time.

---

## Evaluating the curve
{{< lead >}} evaluate `(time: number, modifierStop = -1): T` {{< /lead >}}

The `evaluate` method returns the value of the curve at any given time. This value is calculated by interpolating between the two keyframes before and after the `time` value.

The `modifierStop` parameter is optional and defaults to `-1`. It indicates how many modifiers to apply to the curve. A negative `modifierStop` value indicates that each modifier should be applied. The `modifierStop` parameter is mainly for use in curve modifiers that need to evaluate the curve in order to prevent endless recursive evaluation loops.

{{< code lang="typescript" >}}
import { Curve, NumberKeyframe } from 'curves';

const curve: Curve<number> = new Curve<number>(
    [
        new NumberKeyframe(0, 0),
        new NumberKeyframe(1, 2),
        new NumberKeyframe(5, 1),
    ], // Keyframes
);

// Expected output: 
//    time: 0, value: 0
//    time: 1, value: 2
//    time: 2, value: 1.9375
//    time: 3, value: 1.5
//    time: 4, value: 1.0625
//    time: 5, value: 1
for (let i = 0; i < 5; i += 1) {
    console.log(`time: ${i}, value: ${curve.evaluate(i)}`)
}
{{< /code >}}

---

## Adding & Removing Keyframes

There are multiple methods available for adding and removing keyframes from a curve. There are also some protocols that must be observed if you choose to manually add or remove keyframes.

### Curve.keys

The `keys` property of a `Curve` object is an array that stores the keyframes of the curve. Each keyframe must extend the [Keyframe]({{< ref "/keyframe" >}} "`Keyframe`") class, with the same generic type argument as the `Curve`. For example, a `Curve<number>` must have keyframes that extend `Keyframe<number>`.

{{< code lang="typescript" >}}
import { Curve, NumberKeyframe } from 'curves';

// Define the curve
const curve: Curve<number> = new Curve<number>(
    [
        new NumberKeyframe(0, 0),
        new NumberKeyframe(1, 2),
        new NumberKeyframe(2, 1),
    ], // Keyframes
);

// Expected output: 
//    time: 0, value: 0
//    time: 1, value: 2
//    time: 2, value: 1
curve.keys.forEach((key) => console.log(`time: ${key.time}, value: ${key.value}`));
{{< /code >}}

{{< panel style="warning" >}} If you modify the keyframe list directly rather than using the `addKeyframe` and `removeKeyframe` methods, [Update]({{< ref "/curve#curveupdate" >}} "`update`") must be called before the next `evaluate` for the curve to function properly. The same is true if any of the keyframes stored in the array are directly modified. {{< /panel >}}

### addKeyframe
{{< lead >}} addKeyframe `(keyframe: Keyframe<T>): void` {{< /lead >}}

The `addKeyframe` method  adds a keyframe to `Curve.keys` and updates the curve.

{{< code lang="typescript" >}}
import { Curve, NumberKeyframe } from 'curves';

// Define the curve
const curve: Curve<number> = new Curve<number>(
    [
        new NumberKeyframe(0, 0),
        new NumberKeyframe(1, 1),
    ], // Keyframes
);

// Add a keyframe
curve.addKeyframe(new NumberKeyframe(0.5, 2));

// Expected output: 
//    time: 0, value: 0
//    time: 0.5, value: 2
//    time: 1, value: 1
curve.keys.forEach((key) => console.log(`time: ${key.time}, value: ${key.value}`));
{{< /code >}}

### removeKeyframe
{{< lead >}} removeKeyframe `(keyframe: Keyframe<T> | { time: number, value: T }): void` {{< /lead >}}

The `removeKeyframe` method takes a keyframe or any value with a `time` property and a `value` property as its only argument. It finds the index of a keyframe with a matching time and value and removes it from `Curve.keys` and updates the curve.

{{< code lang="typescript" >}}
import { Curve, NumberKeyframe } from 'curves';

// Define the curve
const curve: Curve<number> = new Curve<number>(
    [
        new NumberKeyframe(0, 0),
        new NumberKeyframe(1, 2),
        new NumberKeyframe(2, 1),
    ], // Keyframes
);

// Remove a keyframe
curve.removeKeyframe({time: 2, value: 1});

// Expected output: 
//    time: 0, value: 0
//    time: 1, value: 2
curve.keys.forEach((key) => console.log(`time: ${key.time}, value: ${key.value}`));
{{< /code >}}

### removeKeyframeByTime
{{< lead >}} removeKeyframeByTime `(time: number): void` {{< /lead >}}

The `removeKeyframe` method takes a number representing the time of the keyframe to remove as its only argument. It finds the index of a keyframe with a matching time and removes it from `Curve.keys` and updates the curve.

{{< code lang="typescript" >}}
import { Curve, NumberKeyframe } from 'curves';

// Define the curve
const curve: Curve<number> = new Curve<number>(
    [
        new NumberKeyframe(0, 0),
        new NumberKeyframe(1, 2),
        new NumberKeyframe(2, 1),
    ], // Keyframes
);

// Remove a keyframe
curve.removeKeyframeByTime(2);

// Expected output: 
//    time: 0, value: 0
//    time: 1, value: 2
curve.keys.forEach((key) => console.log(`time: ${key.time}, value: ${key.value}`));
{{< /code >}}

### removeKeyframeByIndex
{{< lead >}} removeKeyframeByIndex `(index: number): void` {{< /lead >}}

The `removeKeyframe` method takes a number representing the index of the keyframe in `Curve.keys` as its only argument. It finds the index of a keyframe with a matching time and value and removes it from `Curve.keys` and updates the curve. Each time the curve updates, the keyframes are sorted in order of their time.

{{< code lang="typescript" >}}
import { Curve, NumberKeyframe } from 'curves';

// Define the curve
const curve: Curve<number> = new Curve<number>(
    [
        new NumberKeyframe(0, 0),
        new NumberKeyframe(1, 2),
        new NumberKeyframe(2, 1),
    ], // Keyframes
);

// Remove a keyframe
curve.removeKeyframeByIndex(0);

// Expected output: 
//    time: 1, value: 2
//    time: 2, value: 1
curve.keys.forEach((key) => console.log(`time: ${key.time}, value: ${key.value}`));
{{< /code >}}

---

## Managing Modifiers

Modifiers are used to apply transformations and effects to a curve after it is evaluated. The modifiers are applied in the order of the list that stores them.

### modifiers

The `modifiers` property of a `Curve` object is an array that stores the modifiers of the curve. Each modifier must extend the [CurveModifier]({{< ref "/curvemodifier" >}} "`CurveModifier`") class, with the same generic type argument as the `Curve`. For example, a `Curve<number>` must have modifiers that extend `CurveModifier<number>`.

{{< code lang="typescript" >}}
import { Curve, Modifiers } from 'curves';

// Define the curve
const curve: Curve<number> = new Curve<number>(
    [
        new NumberKeyframe(0, 0),
        new NumberKeyframe(5, 2)
    ], // Keyframes
    [
        new Modifiers.Number.Noise(0.1, 0.5),
        new Modifiers.Number.Noise(0.025, 2)   // Layered noise
    ] // Modifiers
);

// Expected output: [ Noise, Noise ]
console.log(curve.modifiers);
{{< /code >}}

{{< panel style="warning" >}} If you modify the modifier list directly rather than using the `addModifier`, [Update]({{< ref "/curve#curveupdate" >}} "`update`") must be called before the next `evaluate` for the curve to function properly. The same is true if any of the modifiers stored in the array are directly modified. {{< /panel >}}

### addModifier
{{< lead >}} addModifier `(modifier: CurveModifier<T>): void` {{< /lead >}}

The `addModifier` method adds a modifier to the end of the modifier list and subsequently updates the list.

{{< code lang="typescript" >}}
import { Curve, Modifiers } from 'curves';

// Define the curve
const curve: Curve<number> = new Curve<number>(
    [
        new NumberKeyframe(0, 0),
        new NumberKeyframe(5, 2)
    ], // Keyframes
    [
        new Modifiers.Number.Noise(0.1, 0.5),
        new Modifiers.Number.Noise(0.025, 2)   // Layered noise
    ] // Modifiers
);

// Add a modifier
curve.addModifier(new Modifiers.Number.Clamp(0, 5));

// Expected output: [ Noise, Noise, Clamp ]
console.log(curve.modifiers);
{{< /code >}}

{{< panel style="warning" >}} There is no removal method for modifiers. Removal must be performed manually and the curve must be manually updated afterwards. {{< /panel >}}

---

## Updating the curve
{{ < lead > }} update `(): void` {{ < /lead > }}

After manually modifying `Curve.keys` or `Curve.modifiers` manually, call `update` before evaluating the curve. It is used to calculate `Curve.startTime`, `Curve.endTIme`, and `Curve.duration`, as well as configuring keyframes and modifiers.

{{< code lang="typescript" >}}
import { Curve, NumberKeyframe } from 'curves';

// Define the curve
const curve: Curve<number> = new Curve<number>(
    [
        new NumberKeyframe(0, 0),
        new NumberKeyframe(1, 1),
    ], // Keyframes
);

// Add a keyframe
curve.keyframes.push(new NumberKeyframe(5, 2));

// Expected output: 1
console.log(curve.endTime);

// Update curve
curve.update();

// Expected output: 5
console.log(curve.endTime);

{{< /code >}}