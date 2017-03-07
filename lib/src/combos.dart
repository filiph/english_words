import 'dart:math';

import 'package:english_words/src/syllables.dart';
import 'package:english_words/src/words/adjectives.dart';
import 'package:english_words/src/words/nouns.dart';

final _random = new Random();

/// Randomly generates nice-sounding combinations of words.
///
/// Will only return word combinations that are [maxSyllables] long. This
/// applies to the joined word, so that, for example, `timetime` will not pass
/// when `maxSyllables == 2` because as a single word it would be pronounced
/// something like "time-ee-time", which is 3 syllables.
///
/// By default, this function will generate combinations from all the top
/// words in the database ([adjectives] and [nouns]). You can tighten it by
/// providing [top]. For example, when [top] is `10`, then only the top ten
/// adjectives and nouns will be used for generating the combinations.
Iterable<WordPair> generateCombo({int maxSyllables: 2, int top: 10000}) sync* {
  bool filter(String word) => syllables(word) <= maxSyllables - 1;

  final shortAdjectives = adjectives
      .where(filter)
      .take(top)
      .toList(growable: false)..shuffle(_random);
  final shortNouns = nouns.where(filter).take(top).toList(growable: false)
    ..shuffle(_random);

  int adjectivesIndex = 0;
  int nounIndex = 0;

  // We're in a sync* function, so `while (true)` is okay.
  // ignore: literal_only_boolean_expressions
  while (true) {
    if (adjectivesIndex >= shortAdjectives.length) {
      shortAdjectives.shuffle(_random);
      adjectivesIndex = 0;
    }
    // Rotate nouns when we're one element before the end of the list.
    // `nounIndex` can be incremented by 2 in each iteration.
    if (nounIndex >= shortNouns.length - 1) {
      shortNouns.shuffle(_random);
      nounIndex = 0;
    }
    String prefix;
    if (_random.nextBool()) {
      prefix = shortAdjectives[adjectivesIndex++];
    } else {
      prefix = shortNouns[nounIndex++];
    }
    final suffix = shortNouns[nounIndex++];

    // Skip combinations that clash same letters.
    if (prefix.codeUnits.last == suffix.codeUnits.first) continue;

    final wordPair = new WordPair(prefix, suffix);
    // Skip words that don't make a nicely pronounced 2-syllable word
    // when combined together.
    if (syllables(wordPair.join()) > maxSyllables) continue;
    yield wordPair;
  }
}

/// Representation of a combination of 2 words, [first] and [second].
///
/// For example, 'Skyrim' is a word pair, where 'sky' is the first part
/// and 'rim' is the second.
class WordPair {
  /// The first part of the pair.
  final String first;

  /// The second part of the pair.
  final String second;

  /// Create a [WordPair] from the strings [first] and [second].
  const WordPair(this.first, this.second);

  /// Returns a string representation of the [WordPair] where the two parts
  /// are joined by [separator].
  ///
  /// For example, `new WordPair('mine', 'craft').join()` returns `minecraft`.
  String join([String separator = '']) => '$first$separator$second';

  /// Creates a new [WordPair] with both parts in lower case.
  WordPair toLowerCase() =>
      new WordPair(first.toLowerCase(), second.toLowerCase());

  @override
  String toString() => '$first$second';
}
