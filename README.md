# english_words

[![Build status](https://travis-ci.org/filiph/english_words.svg)](https://travis-ci.org/filiph/english_words)

A package containing the most ~5000 used English words and some utility
functions.

## Usage

Printing the top 50 most used nouns in the English language:

    import 'package:english_words/english_words.dart';

    main() {
      nouns.take(50).forEach(print);
    }

Computing number of syllables in a word:

    syllables('beautiful');  // 3
    syllables('abatement');  // 3
    syllables('zoology');  // 4

Generating 5 interesting 2-syllable word combinations:

    generateWordPairs().take(5).forEach(print);

## Features and bugs

Please file feature requests and bugs at the [issue tracker][tracker].

[tracker]: https://github.com/filiph/english_words/issues
