import 'package:benchmark_harness/benchmark_harness.dart';
import 'package:english_words/english_words.dart';

void main() {
  SyllableBenchmark.main();
  GenerateWordPairBenchmark.main();
}

/// A benchmark for counting syllables.
class GenerateWordPairBenchmark extends BenchmarkBase {
  /// This lives here so that Dart doesn't tree-shake the computation in the
  /// benchmark.
  int length = 0;

  /// Create the benchmark.
  GenerateWordPairBenchmark() : super("GenerateWordPair");

  /// Generate 100 random [WordPair]s and count cumulative length.
  @override
  void run() {
    for (var pair in generateWordPairs().take(100)) {
      length += pair.first.length + pair.second.length;
    }
  }

  /// Run and report on the benchmark.
  static void main() {
    GenerateWordPairBenchmark().report();
  }
}

/// A benchmark for counting syllables.
class SyllableBenchmark extends BenchmarkBase {
  final List<String> _words = all.take(1000).toList(growable: false);

  /// This lives here so that Dart doesn't tree-shake the computation in the
  /// benchmark.
  int count = 0;

  /// Create the benchmark.
  SyllableBenchmark() : super("Syllable");

  /// Count cumulative number of syllables in [_words].
  @override
  void run() {
    for (var word in _words) {
      count += syllables(word);
    }
  }

  /// Run and report on the benchmark.
  static void main() {
    SyllableBenchmark().report();
  }
}
