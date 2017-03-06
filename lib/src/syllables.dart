// Copyright (c) 2017, filiph. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

import 'package:string_scanner/string_scanner.dart';

/// Count syllables in [word].
int syllables(String word) {
  final scanner = new StringScanner(word);

  int count = 0;
  bool continuousVowel = false;

  assert(
      scanner.matches(_alpha),
      "Word '$word' doesn't start with an alphabetic character. "
      "Have you trimmed the word of whitespace?");

  while (!scanner.isDone) {
    if (scanner.scan(_vowel)) {
      if (!continuousVowel) {
        count += 1;
      }
      continuousVowel = true;
    } else {
      scanner.expect(_alpha);
      continuousVowel = false;
    }
  }

  if (scanner.lastMatch.group(0).toLowerCase() == 'e') {
    count -= 1;
  }

  if (count == 0) return 1;
  return count;
}

final RegExp _alpha = new RegExp(r"\w");

final RegExp _vowel = new RegExp(r"[aeiouy]", caseSensitive: false);

/* Two expressions of occurrences which normally would
 * be counted as two syllables, but should be counted
 * as one. */
var _monosyllabics = new RegExp(
    r'cia(l|$)|' +
        'tia|' +
        'cius|' +
        'cious|' +
        '[^aeiou]giu|' +
        '[aeiouy][^aeiouy]ion|' +
        'iou|' +
        r'sia$|' +
        r'eous$|' +
        r'[oa]gue$|' +
        r'.[^aeiuoycgltdb]{2,}ed$|' +
        r'.ely$|' +
        '^jua|' +
        'uai|' +
        'eau|' +
        r'^busi$|' +
        '(' +
        '[aeiouy]' +
        '(' +
        'b|' +
        'c|' +
        'ch|' +
        'dg|' +
        'f|' +
        'g|' +
        'gh|' +
        'gn|' +
        'k|' +
        'l|' +
        'lch|' +
        'll|' +
        'lv|' +
        'm|' +
        'mm|' +
        'n|' +
        'nc|' +
        'ng|' +
        'nch|' +
        'nn|' +
        'p|' +
        'r|' +
        'rc|' +
        'rn|' +
        'rs|' +
        'rv|' +
        's|' +
        'sc|' +
        'sk|' +
        'sl|' +
        'squ|' +
        'ss|' +
        'th|' +
        'v|' +
        'y|' +
        'z' +
        ')' +
        r'ed$' +
        ')|' +
        '(' +
        '[aeiouy]' +
        '(' +
        'b|' +
        'ch|' +
        'd|' +
        'f|' +
        'gh|' +
        'gn|' +
        'k|' +
        'l|' +
        'lch|' +
        'll|' +
        'lv|' +
        'm|' +
        'mm|' +
        'n|' +
        'nch|' +
        'nn|' +
        'p|' +
        'r|' +
        'rn|' +
        'rs|' +
        'rv|' +
        's|' +
        'sc|' +
        'sk|' +
        'sl|' +
        'squ|' +
        'ss|' +
        'st|' +
        't|' +
        'th|' +
        'v|' +
        'y' +
        ')' +
        r'es$' +
        ')',
    caseSensitive: false);

//var EXPRESSION_MONOSYLLABIC_TWO = new RegExp(
//    '[aeiouy]' +
//        '(' +
//        'b|' +
//        'c|' +
//        'ch|' +
//        'd|' +
//        'dg|' +
//        'f|' +
//        'g|' +
//        'gh|' +
//        'gn|' +
//        'k|' +
//        'l|' +
//        'll|' +
//        'lv|' +
//        'm|' +
//        'mm|' +
//        'n|' +
//        'nc|' +
//        'ng|' +
//        'nn|' +
//        'p|' +
//        'r|' +
//        'rc|' +
//        'rn|' +
//        'rs|' +
//        'rv|' +
//        's|' +
//        'sc|' +
//        'sk|' +
//        'sl|' +
//        'squ|' +
//        'ss|' +
//        'st|' +
//        't|' +
//        'th|' +
//        'v|' +
//        'y|' +
//        'z' +
//        ')' +
//        'e$',
//    'g'
//);
//
///* Four expression of occurrences which normally would be
// * counted as one syllable, but should be counted as two. */
//var EXPRESSION_DOUBLE_SYLLABIC_ONE = new RegExp(
//    '(' +
//        '(' +
//        '[^aeiouy]' +
//        ')\\2l|' +
//        '[^aeiouy]ie' +
//        '(' +
//        'r|' +
//        'st|' +
//        't' +
//        ')|' +
//        '[aeiouym]bl|' +
//        'eo|' +
//        'ism|' +
//        'asm|' +
//        'thm|' +
//        'dnt|' +
//        'uity|' +
//        'dea|' +
//        'gean|' +
//        'oa|' +
//        'ua|' +
//        'eings?|' +
//        '[aeiouy]sh?e[rsd]' +
//        ')$',
//    'g'
//);
