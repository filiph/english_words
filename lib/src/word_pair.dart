import 'dart:math';

import 'package:english_words/src/syllables.dart';
import 'package:english_words/src/words/adjectives.dart';
import 'package:english_words/src/words/adjectives_monosyllabic_safe.dart';
import 'package:english_words/src/words/nouns.dart';
import 'package:english_words/src/words/nouns_monosyllabic_safe.dart';
import 'package:english_words/src/words/unsafe.dart';

/// The default value of the `maxSyllables` parameter of the [generateWordPairs]
/// function.
const int maxSyllablesDefault = 2;

/// The default value of the `safeOnly` parameter of the [generateWordPairs]
/// function.
const bool safeOnlyDefault = true;

/// The default value of the `top` parameter of the [generateWordPairs]
/// function.
const int topDefault = 10000;

final _random = Random();

/// Randomly generates nice-sounding combinations of words (compounds).
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
///
/// By default, the generator will not output possibly offensive compounds,
/// such as 'ballsack' or anything containing 'Jew'. You can turn this behavior
/// off by setting [safeOnly] to `false`.
///
/// You can inject [Random] using the [random] parameter.
Iterable<WordPair> generateWordPairs(
    {int maxSyllables = maxSyllablesDefault,
    int top = topDefault,
    bool safeOnly = safeOnlyDefault,
    Random random}) sync* {
  random ??= _random;

  bool filterWord(String word) {
    if (safeOnly && unsafe.contains(word)) return false;
    return syllables(word) <= maxSyllables - 1;
  }

  List<String> shortAdjectives;
  List<String> shortNouns;
  if (maxSyllables == maxSyllablesDefault &&
      top == topDefault &&
      safeOnly == safeOnlyDefault) {
    // The most common, precomputed case.
    shortAdjectives = adjectivesMonosyllabicSafe;
    shortNouns = nounsMonosyllabicSafe;
  } else {
    shortAdjectives =
        adjectives.where(filterWord).take(top).toList(growable: false);
    shortNouns = nouns.where(filterWord).take(top).toList(growable: false);
  }

  String pickRandom(List<String> list) => list[random.nextInt(list.length)];

  // We're in a sync* function, so `while (true)` is okay.
  // ignore: literal_only_boolean_expressions
  while (true) {
    String prefix;
    if (random.nextBool()) {
      prefix = pickRandom(shortAdjectives);
    } else {
      prefix = pickRandom(shortNouns);
    }
    final suffix = pickRandom(shortNouns);

    // Skip combinations that clash same letters.
    if (prefix.codeUnits.last == suffix.codeUnits.first) continue;

    // Skip combinations that create an unsafe combinations.
    if (safeOnly && unsafePairs.contains("$prefix$suffix")) continue;

    final wordPair = WordPair(prefix, suffix);
    // Skip words that don't make a nicely pronounced 2-syllable word
    // when combined together.
    if (syllables(wordPair.join()) > maxSyllables) continue;
    yield wordPair;
  }
}

/// Representation of a combination of 2 words, [first] and [second].
///
/// This is can be also described as a two-part compound (in the linguistic
/// sense of the word). https://en.wikipedia.org/wiki/Compound_(linguistics)
///
/// For example, 'Skyrim' is a word pair, where 'sky' is the first part
/// and 'rim' is the second.
class WordPair {
  /// The first part of the pair.
  final String first;

  /// The second part of the pair.
  final String second;

  String _asPascalCase;

  String _asCamelCase;

  String _asLowerCase;

  String _asUpperCase;

  String _asString;

  /// Create a [WordPair] from the strings [first] and [second].
  WordPair(this.first, this.second) {
    if (first == null || second == null) {
      throw ArgumentError("Words of WordPair cannot be null. "
          "Received: '$first', '$second'");
    }
    if (first.isEmpty || second.isEmpty) {
      throw ArgumentError("Words of WordPair cannot be empty. "
          "Received: '$first', '$second'");
    }
  }

  /// Creates a single [WordPair] randomly. Takes the same parameters as
  /// [generateWordPairs].
  ///
  /// If you need more than one word pair, this constructor will be inefficient.
  /// Get an iterable of random word pairs instead by calling
  /// [generateWordPairs].
  factory WordPair.random(
      {int maxSyllables = maxSyllablesDefault,
      int top = topDefault,
      bool safeOnly = safeOnlyDefault,
      Random random}) {
    random ??= _random;
    final pairsIterable = generateWordPairs(
        maxSyllables: maxSyllables,
        top: top,
        safeOnly: safeOnly,
        random: random);
    return pairsIterable.first;
  }

  /// Returns the word pair as a simple string, with second word capitalized,
  /// like `"keyFrame"` or `"franceLand"`. This is informally called
  /// "camel case".
  String get asCamelCase => _asCamelCase ??= _createCamelCase();

  /// Returns the word pair as a simple string, in lower case,
  /// like `"keyframe"` or `"franceland"`.
  String get asLowerCase => _asLowerCase ??= asString.toLowerCase();

  /// Returns the word pair as a simple string, with each word capitalized,
  /// like `"KeyFrame"` or `"BigUsa"`. This is informally called "pascal case".
  String get asPascalCase => _asPascalCase ??= _createPascalCase();

  /// Returns the word pair as a simple string, like `"keyframe"`
  /// or `"bigFrance"`.
  String get asString => _asString ??= '$first$second';

  /// Returns the word pair as a simple string, in upper case,
  /// like `"KEYFRAME"` or `"FRANCELAND"`.
  String get asUpperCase => _asUpperCase ??= asString.toUpperCase();

  @override
  int get hashCode => asString.hashCode;

  @override
  bool operator ==(Object other) {
    if (other is WordPair) {
      return first == other.first && second == other.second;
    } else {
      return false;
    }
  }

  /// Returns a string representation of the [WordPair] where the two parts
  /// are joined by [separator].
  ///
  /// For example, `new WordPair('mine', 'craft').join()` returns `minecraft`.
  String join([String separator = '']) => '$first$separator$second';

  /// Creates a new [WordPair] with both parts in lower case.
  WordPair toLowerCase() => WordPair(first.toLowerCase(), second.toLowerCase());

  @override
  String toString() => asString;

  String _capitalize(String word) {
    return "${word[0].toUpperCase()}${word.substring(1).toLowerCase()}";
  }

  String _createCamelCase() => "${first.toLowerCase()}${_capitalize(second)}";

  String _createPascalCase() => "${_capitalize(first)}${_capitalize(second)}";
}
