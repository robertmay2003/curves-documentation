---
title: "String Modifiers"
date: 2020-09-02T17:21:15-04:00
draft: true
weight: 99
---
#

Strings have their own special modifiers to make string interpolation more readable and humanly understandable. 

A `string` can be easily converted to a `number[]`, in which each number is the character code of each character in the string. However, using `number[]` modifiers on a `string` curve can produce unexpected results, especially given that many character codes represent special control characters.

The `string` modifiers restrict the characters that can be returned by `string` interpolation in order to remove occurrences of these special characters and make the returned value more legible.