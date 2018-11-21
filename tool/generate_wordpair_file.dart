import 'dart:io';

import 'package:english_words/english_words.dart';

/// This simple tool builds a Dart file that is relatively self-contained
/// (doesn't depend on this package, only on `dart:math` and `dart:ui`).
///
/// It lists 20 word pairs of a given length (in syllables).
///
/// Run with the syllable length as the command line argument:
///
///     dart tool/generate_wordpair_file.dart 3
void main(List<String> args) {
  int count;
  try {
    final countString = args.single;
    count = int.parse(countString);
  } catch (e) {
    print("Syllable count not provided or not an integer. ($e)");
  }

  if (count == null) {
    print("Please provide number of syllables. For example:\n\n"
        "\tdart tool/generate_wordpair_file.dart 3\n");
    exitCode = 1;
    return;
  }

  print(_nameClassCode);

  print('final List<Name> names = [');
  generateWordPairs(maxSyllables: count)
      // generateWordPairs returns _up to_ maxSyllables. Here we need to make
      // sure the syllable count is exactly the required number.
      .where((pair) => syllables(pair.first) + syllables(pair.second) == count)
      .take(20)
      .forEach((pair) {
    print('  Name("${pair.asCamelCase}", "${pair.asPascalCase}", '
        '"${pair.first}", "${pair.second}"),');
  });
  print('];');
}

const _nameClassCode = '''
import 'dart:math';
import 'dart:ui';

class Name {
  final String camelCase;
  final String pascalCase;
  final String first;
  final String second;
  final Color color;

  Name(this.camelCase, this.pascalCase, this.first, this.second)
      : color = _generateColor(camelCase);

  static Color _generateColor(String pascalCase) {
    final random = Random(pascalCase.hashCode);
    return Color(0xFF000000 | random.nextInt(0xFFFFFF));
  }
}


''';
