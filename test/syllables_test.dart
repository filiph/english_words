// Copyright (c) 2017, filiph. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

import 'package:english_words/english_words.dart';
import 'package:test/test.dart';

import 'syllables/bulk_test_data.dart';

void main() {
  group('Syllables', () {
    group('in a simple world: ', () {
      test('hi', () {
        expect(syllables('hi'), 1);
      });
      test('hey', () {
        expect(syllables('hey'), 1);
      });
      test('neigh', () {
        expect(syllables('neigh'), 1);
      });
      test('apple', () {
        expect(syllables('apple'), 2);
      });
      test('mode', () {
        expect(syllables('mode'), 1);
      });
      test('hello', () {
        expect(syllables('hello'), 2);
      });
      test('greetings', () {
        expect(syllables('greetings'), 2);
      });
    });

    group('in capitalized {2,3}-letter abbreviation: ', () {
      test('TV', () {
        expect(syllables('TV'), 2);
      });
      test('PC', () {
        expect(syllables('PC'), 2);
      });
      test('USA', () {
        expect(syllables('USA'), 3);
      });
    });

    group('in an exception word: ', () {
      test('beautiful', () {
        expect(syllables('beautiful'), 3);
      });
      test('abeyance', () {
        expect(syllables('abeyance'), 3);
      });
      test('aisle', () {
        expect(syllables('aisle'), 1);
      });
      test('aboveboard', () {
        expect(syllables('aboveboard'), 3);
      });
      test('biology', () {
        expect(syllables('biology'), 4);
      });
      test('monologue', () {
        expect(syllables('monologue'), 3);
      });
      test('dying', () {
        expect(syllables('dying'), 2);
      });
      test('flying', () {
        expect(syllables('flying'), 2);
      });
      test('poet', () {
        expect(syllables('poet'), 2);
      });
      test('conscious', () {
        expect(syllables('conscious'), 2);
      });
      test('precious', () {
        expect(syllables('precious'), 2);
      });
      test('cruel', () {
        expect(syllables('cruel'), 2);
      });
    });

    group("todo: ", () {
      test('aborigines', () {
        expect(syllables('aborigines'), 5);
      });
      test('cafes', () {
        expect(syllables('cafes'), 2);
      });
      test('sciascia', () {
        expect(syllables('sciascia'), 2);
      });
    }, skip: "TODO (fix these and add to bulk)");

    test('bulk test', () {
      _expectSyllables(syllableTestData);
    });
  });
}

void _expectSyllables(Map<String, int> expectations) {
  final failures = Map<String, int>();
  for (var word in expectations.keys) {
    if (syllables(word) != expectations[word]) {
      failures[word] = syllables(word);
    }
  }
  if (failures.isNotEmpty) {
    final String failuresList = failures.keys
        .map<String>((word) =>
            word.padLeft(20) +
            ' counted as ${failures[word]} '
            'instead of ${expectations[word]}')
        .join('\n');
    fail("Failed on ${failures.length} of the ${expectations.length} words:\n"
        "$failuresList");
  }
}
