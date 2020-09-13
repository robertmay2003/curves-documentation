---
title: "Exclude"
date: 2020-09-02T17:21:15-04:00
draft: true
---
#

The `Exclude` modifier excludes blacklisted characters from the string, or only includes whitelisted characters.

### Types
* String

### Constructor

{{< lead >}} `new` Exclude `(` {{< /lead >}}
{{< lead >}} `    blacklist: string[],` {{< /lead >}}
{{< lead >}} `    useWhitelist = false,` {{< /lead >}}
{{< lead >}} `    clamp = true,` {{< /lead >}}
{{< lead >}} `    rangeStart: number | undefined = undefined,` {{< /lead >}}
{{< lead >}} `    rangeEnd: number | undefined = undefined,` {{< /lead >}}
{{< lead >}} `)` {{< /lead >}}

`blacklist`: The list of characters to be excluded from the returned string.\
`useWhitelist`: Whether or not the blacklist should be treated as a whitelist instead.\
`clamp`: Whether blacklisted characters should be clamped to the nearest allowed character or removed from the string.\
`rangeStart`: The time at which the modifier begins to modify the curve.\
`rangeEnd`: The time at which the modifier no longer modifies the curve.\

{{< code lang="typescript" >}}
import { Modifiers } from 'curves'; // Import Modifiers

const exclude = new Modifiers.String.Exclude(['a', 'b', 'c']); // Create a new exclude modifier
{{< /code >}}