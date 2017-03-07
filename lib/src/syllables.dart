// Copyright (c) 2017, filiph. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

import 'package:english_words/src/syllables/disyllabic.dart';
import 'package:english_words/src/syllables/monosyllabic.dart';
import 'package:english_words/src/syllables/problematic.dart';
import 'package:english_words/src/syllables/trisyllabic.dart';
import 'package:string_scanner/string_scanner.dart';

final RegExp _allCaps = new RegExp(r'^[A-Z]+$');

final RegExp _alpha = new RegExp(r"\w");

final RegExp _vowels = new RegExp(r"[aeiouy]+", caseSensitive: false);

/// Count syllables in [word].
int syllables(String word) {
  assert(
      new RegExp(r'^\w+$').hasMatch(word),
      "Word '$word' contains non-alphabetic characters. "
      "Have you trimmed the word of whitespace?");

  if (word.length <= 3 && _allCaps.hasMatch(word)) {
    // USA, PC, TV, ...
    return word.length;
  }

  if (word.length < 3) return 1;

  final problematicCount = problematic[word];
  if (problematicCount != null) {
    return problematicCount;
  }
  // TODO: if this is plural, make it singular

  int count = 0;

  /// Adjusts [count] and returns string without the pattern.
  String adjust(String string, Pattern pattern, int adjustment) {
    return string.replaceAllMapped(pattern, (_) {
      count += adjustment;
      return '';
    });
  }

  String unprefixed = adjust(word, trisyllabicPrefixSuffix, 3);
  unprefixed = adjust(unprefixed, disyllabicPrefixSuffix, 2);
  unprefixed = adjust(unprefixed, monosyllabicPrefixSuffix, 1);

  final scanner = new StringScanner(unprefixed);

  while (!scanner.isDone) {
    if (scanner.scan(_vowels)) {
      count += 1;
      continue;
    }

    scanner.expect(_alpha);
  }

  adjust(unprefixed, monosyllabic1, -1);
  adjust(unprefixed, monosyllabic2, -1);

  adjust(unprefixed, disyllabic1, 1);
  adjust(unprefixed, disyllabic2, 1);
  adjust(unprefixed, disyllabic3, 1);
  adjust(unprefixed, disyllabic4, 1);

  if (count == 0) return 1;
  return count;
}
