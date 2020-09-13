---
title: "Ranges"
date: 2020-09-02T17:21:15-04:00
draft: true
---
#

The `Ranges` modifier allows only values within the given ranges of characters. Each range is represented by a minimum character code and a maximum character code.

### Types
* String

### Constructor

{{< lead >}} `new` Ranges `(` {{< /lead >}}
{{< lead >}} `    ranges: { min: number, max: number }[] = Ranges.AlphaNumeric,` {{< /lead >}}
{{< lead >}} `    clamp = true,` {{< /lead >}}
{{< lead >}} `    allowKeyframeValues = true,` {{< /lead >}}
{{< lead >}} `    rangeStart: number | undefined = undefined,` {{< /lead >}}
{{< lead >}} `    rangeEnd: number | undefined = undefined,` {{< /lead >}}
{{< lead >}} `)` {{< /lead >}}

`ranges`: The list of ranges within which characters are allowed.\
`clamp`: Whether non-whitelisted characters should be clamped to the nearest allowed character or removed from the string.\
`allowKeyframeValues`: Whether or not characters in the values of each keyframe should be whitelisted.\
`rangeStart`: The time at which the modifier begins to modify the curve.\
`rangeEnd`: The time at which the modifier no longer modifies the curve.\

{{< code lang="typescript" >}}
import { Modifiers } from 'curves'; // Import Modifiers

const ranges = new Modifiers.String.Ranges(); // Create a new ranges modifier
{{< /code >}}

---

The `Ranges` class contains a static method to facilitate the creation of a range from a minimum character and a maximum character. It also contains predefined ranges for ease of use.

### Create Range
{{< lead >}} `static` createRange `(min: number | string, max: number | string): { min: number, max: number }` {{< /lead >}}

`min`: The minimum character or character code of the range.\
`max`: The maximum character or character code of the range.\

{{< code lang="typescript" >}}
import { Modifiers } from 'curves'; // Import Modifiers

const lowercaseAlpha = Modifiers.String.Ranges.createRange('a', 'z'); // Create a range containing only lowercase letters
{{< /code >}}

### Predefined Ranges

| Accessor | Code | Definition |
| :--- | :--- | :---: |
| `Ranges`.CapitalAlpha | `Ranges`.createRange`('A', 'Z')` | A range that contains only capital letters. |
| `Ranges`.LowercaseAlpha | `Ranges`.createRange`('a', 'z')` | A range that contains only lowercase letters. |
| `Ranges`.Numeric | `Ranges`.createRange`('0', '9')` | A range that contains numeric characters. |
| `Ranges`.AlphaAccent | `Ranges`.createRange`('À', 'ÿ')` | A range that contains most of the accented letters. |
| `Ranges`.NonControl | `Ranges`.createRange`(32, 255)` | A range that every common non-control character. |
| `Ranges`.Alpha | [ `Ranges`.CapitalAlpha,<br/> `Ranges`.LowercaseAlpha ] | A list of ranges containing all letters. |
| `Ranges`.AlphaNumeric | [ `Ranges`.CapitalAlpha,<br/> `Ranges`.LowercaseAlpha,<br/> `Ranges`.Numeric ] | A list of ranges containing all letters and numbers. |

