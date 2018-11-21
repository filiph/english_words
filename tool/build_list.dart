import 'dart:io';

/// Gets a subset of the input CSV.
///
/// * n (child, world)
/// * j (good, new, old)
/// * r (how, more, then, really)
/// * p (we, she)
/// * m (first, million)
/// * d (this, that, another, same)
/// * c (so)
void main() {
  final inputCsv = File("data/word-freq-top5000.csv");
  final allow = ['j']; //, 'j', 'm'];

  for (var line in inputCsv.readAsLinesSync()) {
    if (!line.startsWith(RegExp(r'\d+'))) continue;
    final parts = line.split(',');
    if (allow.contains(parts[2])) {
      final word = parts[1];
      if (!RegExp(r'^\w+$').hasMatch(word)) {
        // Skip words like "n't" and "o'clock".
        continue;
      }
      print("'$word',");
    }
  }
}
