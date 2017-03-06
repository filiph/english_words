// Copyright (c) 2017, filiph. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

import 'package:english_words/english_words.dart';
import 'package:test/test.dart';

import 'syllables/bulk_test_data.dart';

void main() {
  group('Syllables', () {
    test('bulk test', () {
      _expectSyllables(syllableTestData);
    });
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
        expect(syllables('apple'), 1);
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
//      test('diabetes', () {
//        expect(syllables('diabetes'), 4);
//      });
    });
    group('in an exception word: ', () {
      test('monologue', () {
        expect(syllables('monologue'), 3);
      });
    });
  });
}

void _expectSyllables(Map<String, int> expectations) {
  final failures = new Map<String, int>();
  for (var word in expectations.keys) {
    if (syllables(word) != expectations[word]) {
      failures[word] = syllables(word);
    }
//    expect(syllables(word), expectations[word],
//        reason: 'Word "$word" should have counted as '
//            '${expectations[word]} syllables.');
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
