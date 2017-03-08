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

void main() {
  // Run TemplateBenchmark
  SyllableBenchmark.main();
}