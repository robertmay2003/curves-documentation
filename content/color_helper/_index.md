---
title: "Color Helper"
date: 2020-09-02T17:21:15-04:00
draft: true
weight: 10
---
#

The `ColorHelper` object contains functions to assist with color conversions between colors implementing the `RGBColor` interface and the `HSVColor` interface.

{{< panel style="info" >}} See [Interfaces]({{< ref "/interfaces" >}} "Interfaces") for more information on the `RGBColor` and `HSVColor` interfaces {{< /panel >}}

---

### HSV to RGB
{{< lead >}} HSVtoRGB `(color: HSVColor): RGBColor` {{< /lead >}}

The `HSVtoRGB` function takes an `HSVColor` as its argument and returns its equivalent `RGBColor`.

{{< code lang="typescript" >}}
import { ColorHelper, RGBColor, HSVColor } from 'curves'; // Import

// Example (red)
const color: HSVColor = {
    h: 0,         // Between 0 - 360
    s: 100,       // Between 0 - 100
    v: 100,       // Between 0 - 100
}

// Expected output: { r: 255, g: 0, b: 0 }
const rgbColor: RGBColor = ColorHelper.HSVtoRGB(color);
{{< /code >}}

### HSL to RGB
{{< lead >}} HSLtoRGB `(color: HSVColor): RGBColor` {{< /lead >}}

The `HSLtoRGB` function takes an `HSVColor` as its argument and returns its equivalent `RGBColor`. 

{{< panel style="info" >}} The `v` property of the `HSVColor` object is used as the color's lightness rather than its value. {{< /panel >}}

{{< code lang="typescript" >}}
import { ColorHelper, RGBColor, HSVColor } from 'curves'; // Import

// Example (red)
const color: HSVColor = {
    h: 0,         // Between 0 - 360
    s: 100,       // Between 0 - 100
    v: 50,       // Between 0 - 100
}

// Expected output: { r: 255, g: 0, b: 0 }
const rgbColor: RGBColor = ColorHelper.HSLtoRGB(color);
{{< /code >}}

### HSV to HSL
{{< lead >}} HSVtoHSL `(color: HSVColor): HSVColor`{{< /lead >}}

The `HSVtoHSL` function takes an `HSVColor` as its argument and returns its equivalent `HSVColor`, where the `v` property represents the color's lightness rather than its value.

{{< code lang="typescript" >}}
import { ColorHelper, RGBColor, HSVColor } from 'curves'; // Import

// Example (red)
const color: HSVColor = {
    h: 0,         // Between 0 - 360
    s: 100,       // Between 0 - 100
    v: 100,       // Between 0 - 100
}

// Expected output: { h: 0, s: 100, v: 50 }
const hslColor: HSVColor = ColorHelper.HSVtoHSL(color);
{{< /code >}}

### HSL to HSV
{{< lead >}} HSLtoHSV `(color: HSVColor): HSVColor` {{< /lead >}}

The `HSLtoHSV` function takes an `HSVColor` in which the `v` property represents the color's lightness rather than its value and returns its equivalent `HSVColor`.

{{< code lang="typescript" >}}
import { ColorHelper, RGBColor, HSVColor } from 'curves'; // Import

// Example (red)
const color: HSVColor = {
    h: 0,         // Between 0 - 360
    s: 100,       // Between 0 - 100
    v: 50,       // Between 0 - 100
}

// Expected output: { h: 0, s: 100, v: 100 }
const hsvColor: HSVColor = ColorHelper.HSLtoHSV(color);
{{< /code >}}

## RGB to HSV
{{< lead >}} RGBtoHSV `(color: RGBColor): HSVColor` {{< /lead >}}

The `RGBtoHSV` function takes an `RGBColor` as its argument and returns its equivalent `HSVColor`.

{{< code lang="typescript" >}}
import { ColorHelper, RGBColor, HSVColor } from 'curves'; // Import

// Example (red)
const color: RGBColor = {
    r: 255,       // Between 0 - 255
    g: 0,         // Between 0 - 255
    b: 0,         // Between 0 - 255
}

// Expected output: { h: 0, s: 100, v: 100 }
const hsvColor: HSVColor = ColorHelper.RGBtoHSV(color);
{{< /code >}}

## RGB to HSL
{{< lead >}} RGBtoHSL `(color: RGBColor): HSVColor` {{< /lead >}}

The `RGBtoHSL` function takes an `RGBColor` as its argument and returns its equivalent `HSVColor`, where the `v` property represents the color's lightness rather than its value.

{{< code lang="typescript" >}}
import { ColorHelper, RGBColor, HSVColor } from 'curves'; // Import

// Example (red)
const color: RGBColor = {
    r: 255,       // Between 0 - 255
    g: 0,         // Between 0 - 255
    b: 0,         // Between 0 - 255
}

// Expected output: { h: 0, s: 100, v: 50 }
const hslColor: HSVColor = ColorHelper.RGBtoHSL(color);
{{< /code >}}

---

## Normalize HSV
{{< lead >}} normalizeHSV `(color: HSVColor): HSVColor` {{< /lead >}}

The `normalizeHSV` function takes an `HSVColor` object as its only argument and returns a "normalized" `HSVColor` object. In a "normalized" HSV color, the saturation and value are clamped between 0 and 100 and the hue value is restricted to the range 0 - 360 using modular arithmetic. This makes `HSVColor` objects easier to process and convert.

{{< code lang="typescript" >}}
import { ColorHelper, RGBColor, HSVColor } from 'curves'; // Import

// Example
const color1: HSVColor = {
    h: 415,
    s: 130,
    v: 55,
}

const color2: HSVColor = {
    h: -30,
    s: -10,
    v: 102,
}

// Expected output: { h: 55, s: 100, v: 55 }
const normalizedColor1: HSVColor = ColorHelper.normalizeHSV(color1);

// Expected output: { h: 330, s: 0, v: 100 }
const normalizedColor2: HSVColor = ColorHelper.normalizeHSV(color2);
{{< /code >}}

{{< panel style="info" >}} All conversion functions automatically normalize HSV values. It is not necessary to normalize them before using them in any of the previously listed conversion functions. {{< /panel >}}
