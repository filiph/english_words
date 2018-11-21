import 'package:english_words/english_words.dart';
import 'package:english_words/src/words/unsafe.dart';
import 'package:test/test.dart';

void main() {
  test('WordPair has sane equality', () {
    final a = WordPair("key", "brain");
    final b = WordPair("key", "brain");
    final c = WordPair("key", "Brain");
    expect(a, b);
    expect(a.hashCode, b.hashCode);
    expect(a, isNot(c));
    expect(a.hashCode, isNot(c.hashCode));
  });

  test('WordPair provides PascalCase', () {
    final a = WordPair("clear", "lake");
    final b = WordPair("big", "USA");
    final c = WordPair("better", "PhD");
    final d = WordPair("huge", "a");
    expect(a.asPascalCase, "ClearLake");
    expect(b.asPascalCase, "BigUsa");
    expect(c.asPascalCase, "BetterPhd");
    expect(d.asPascalCase, "HugeA");
  });

  test('WordPair provides camelCase', () {
    final a = WordPair("clear", "lake");
    final b = WordPair("big", "USA");
    final c = WordPair("France", "land");
    final d = WordPair("huge", "a");
    expect(a.asCamelCase, "clearLake");
    expect(b.asCamelCase, "bigUsa");
    expect(c.asCamelCase, "franceLand");
    expect(d.asCamelCase, "hugeA");
  });

  test('WordPair provides lowercase', () {
    final a = WordPair("clear", "lake");
    final b = WordPair("big", "USA");
    final c = WordPair("France", "land");
    final d = WordPair("huge", "a");
    expect(a.asLowerCase, "clearlake");
    expect(b.asLowerCase, "bigusa");
    expect(c.asLowerCase, "franceland");
    expect(d.asLowerCase, "hugea");
  });

  test('WordPair provides UPPERCASE', () {
    final a = WordPair("clear", "lake");
    final b = WordPair("big", "USA");
    final c = WordPair("France", "land");
    final d = WordPair("huge", "a");
    expect(a.asUpperCase, "CLEARLAKE");
    expect(b.asUpperCase, "BIGUSA");
    expect(c.asUpperCase, "FRANCELAND");
    expect(d.asUpperCase, "HUGEA");
  });

  test('WordPair.random returns normally', () {
    expect(() => WordPair.random(), returnsNormally);
  });

  test('WordPair throws on null members', () {
    expect(() => WordPair("clear", null), throwsArgumentError);
    expect(() => WordPair(null, "lake"), throwsArgumentError);
  });

  test('WordPair throws on empty members', () {
    expect(() => WordPair("clear", ""), throwsArgumentError);
    expect(() => WordPair("", "lake"), throwsArgumentError);
  });

  test('generateWordPair avoids unsafe words by default', () {
    // Since this is running a random generator, the test is inherently fuzzy.
    // It won't give you false positives, but it might give you false negatives
    // (i.e. test passes despite problem with the filtering mechanism).
    // There's a 'flaky' tag so that you can skip this test.
    final pairs = generateWordPairs().take(10000);
    for (final pair in pairs) {
      expect(unsafe, isNot(contains(pair.first)));
      expect(unsafe, isNot(contains(pair.second)));
    }
  }, tags: ['flaky']);
}
