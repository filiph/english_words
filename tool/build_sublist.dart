import 'package:english_words/english_words.dart';
import 'package:english_words/src/words/unsafe.dart';

/// Builder for the `lib/src/words/*_monosyllabic_safe` lists.
void main() {
  final bool safeOnly = safeOnlyDefault;
  final int maxSyllables = maxSyllablesDefault;
  final int top = topDefault;

  bool filterWord(String word) {
    if (safeOnly && unsafe.contains(word)) return false;
    return syllables(word) <= maxSyllables - 1;
  }

  final shortAdjectives =
      adjectives.where(filterWord).take(top).toList(growable: false);
  final shortNouns = nouns.where(filterWord).take(top).toList(growable: false);

  print("=== nouns ====");
  for (var word in shortNouns) {
    print("'$word',");
  }

  print("=== adjectives ====");
  for (var word in shortAdjectives) {
    print("'$word',");
  }
}
