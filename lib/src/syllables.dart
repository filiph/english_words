// Copyright (c) 2017, filiph. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

import 'package:english_words/src/syllables/disyllabic.dart';
import 'package:english_words/src/syllables/monosyllabic.dart';
import 'package:english_words/src/syllables/problematic.dart';
import 'package:english_words/src/syllables/trisyllabic.dart';
import 'package:string_scanner/string_scanner.dart';

final RegExp _allCaps = RegExp(r'^[A-Z]+$');

final RegExp _alpha = RegExp(r"\w");

final RegExp _vowel = RegExp(r"[aeiouy]", caseSensitive: false);

/// Count syllables in [word].
///
/// Heavily inspired by https://github.com/wooorm/syllable.
int syllables(String word) {
  assert(
      RegExp(r'^\w+$').hasMatch(word),
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
  // TODO: if this is plural, make it singular and try again with problematic

  int count = 0;

  /// Adjusts [count] and returns string without the pattern.
  String adjust(String string, Pattern pattern, int adjustment) {
    return string.replaceAllMapped(pattern, (_) {
      count += adjustment;
      return '';
    });
  }

  // We have to chop off prefixes (like 'afore' or 'hyper') and suffixes
  // (like 'ment' or 'ology') so that we can than scan only the "root"
  // of the word. For example, "abatement" becomes "abate" (-ment), which
  // ends with "-ate", which looks like 2 syllables but actualy is just one
  // (which is covered by [monosyllabic2] below).
  String wordRoot = adjust(word, trisyllabicPrefixSuffix, 3);
  wordRoot = adjust(wordRoot, disyllabicPrefixSuffix, 2);
  wordRoot = adjust(wordRoot, monosyllabicPrefixSuffix, 1);

  final scanner = StringScanner(wordRoot);

  bool precedingVowel = false;

  while (!scanner.isDone) {
    if (scanner.matches(monosyllabic1) || scanner.matches(monosyllabic2)) {
      // The following should count for one less than what it looks like
      // from vowels and consonants alone.
      count -= 1;
    }

    if (scanner.matches(disyllabic1) ||
        scanner.matches(disyllabic2) ||
        scanner.matches(disyllabic3) ||
        scanner.matches(disyllabic4)) {
      // The following should count for one more than what it looks like
      // from vowels and consonants alone.
      count += 1;
    }

    if (scanner.scan(_vowel)) {
      if (!precedingVowel) {
        count += 1;
      }
      precedingVowel = true;
      continue;
    }

    scanner.expect(_alpha);
    precedingVowel = false;
  }

  if (count == 0) return 1;
  return count;
}
