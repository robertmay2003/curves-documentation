---
title: "End Behavior"
date: 2020-09-02T17:21:15-04:00
draft: true
---
#

The `EndBehavior` enum is used to define the behavior of a curve beyond its final keyframe. The value returned by `Curve.evaluate` when `time > curve.endTime` or `time < curve.startTime` is determined by the curve's `EndBehavior`.

## Clamp

The `Clamp` behavior is the default `EndBehavior` value for a curve. A curve using the `Clamp` behavior will return the value of the first keyframe when `time < curve.startTime` and the value of the last keyframe when `time > curve.endTime`.

{{< code lang="typescript" >}}
import { Curve, EndBehavior, NumberKeyframe } from 'curves';

// Example
const curve = new Curve<number>(
    [
        new NumberKeyframe(0, 0), 
        new NumberKeyframe(1, 1)
    ],                  // Keyframes
    [],                 // Modifiers
    EndBehavior.Clamp   // EndBehavior
);

// Expected output: 1
curve.evaluate(3)

// Expected output: 0
curve.evaluate(-2)
{{< /code >}} 

## Loop

A curve using the `Loop` behavior will repeat after its end time and before its start time. It essentially evaluates the curve at `time = time % curve.duration` (The actual calculation is slightly more complex).

{{< code lang="typescript" >}}
import { Curve, EndBehavior, NumberKeyframe } from 'curves';

// Example
const curve = new Curve<number>(
    [
        new NumberKeyframe(0, 0), 
        new NumberKeyframe(1, 1)
    ],                  // Keyframes
    [],                 // Modifiers
    EndBehavior.Loop   // EndBehavior
);

// Expected output: 0.5
curve.evaluate(0.5)

// Expected output: 0.5
curve.evaluate(1.5)

// Expected output: 0.5
curve.evaluate(-0.5)
{{< /code >}} 

## PingPong

A curve using the `PingPong` behavior will repeat after its end time and before its start time with a reversed version of the curve, creating a smooth loop effect.

{{< code lang="typescript" >}}
import { Curve, EndBehavior, NumberKeyframe } from 'curves';

// Example
const curve = new Curve<number>(
    [
        new NumberKeyframe(0, 0), 
        new NumberKeyframe(1, 1)
    ],                  // Keyframes
    [],                 // Modifiers
    EndBehavior.PingPong   // EndBehavior
);

// Expected output: 0.9375
curve.evaluate(0.75)

// Expected output: 1
curve.evaluate(1)

// Expected output: 0.9375
curve.evaluate(1.25)
{{< /code >}} 