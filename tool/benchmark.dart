import 'package:benchmark_harness/benchmark_harness.dart';
import 'package:english_words/english_words.dart';

/// A benchmark for counting syllables.
class SyllableBenchmark extends BenchmarkBase {
  /// Create the benchmark.
  SyllableBenchmark() : super("Syllable");

  /// Run and report on the benchmark.
  static void main() {
    new SyllableBenchmark().report();
  }

  final List<String> _words = all.take(1000).toList(growable: false);

  /// Count cumulative number of syllables in [_words].
  @override
  void run() {
    int count = 0;
    for (var word in _words) {
      count += syllables(word);
    }
  }
}

/// A benchmark for counting syllables.
class GenerateWordPairBenchmark extends BenchmarkBase {
  /// Create the benchmark.
  GenerateWordPairBenchmark() : super("GenerateWordPair");

  /// Run and report on the benchmark.
  static void main() {
    new GenerateWordPairBenchmark().report();
  }

  /// Generate 100 random [WordPair]s and count cumulative length.
  @override
  void run() {
    int length = 0;
    for (var pair in generateWordPairs().take(100)) {
      length += pair.first.length + pair.second.length;
    }
  }
}

void main() {
  SyllableBenchmark.main();
  GenerateWordPairBenchmark.main();
}