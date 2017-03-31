/// Lists nasty and otherwise unsafewords that are contained in `all.dart`.
///
/// The list is sorted alphabetically. Most of the really bad words are already
/// missing from `all`, so this just finishes the job.
///
/// There will be false positives ('gay' can mean 'happy', for example, which is
/// perfectly innocent word, but it will be filtered with [unsafe]). That is
/// preferred to false negatives, where offensive words or word pairs
/// are offered to the user.
const List<String> unsafe = const ['ass', 'fucking', 'gay', 'Jew', 'shit'];

/// Lists combinations of perfectly innocent words that together create
/// a nasty one.
///
/// Partially sourced from:
/// http://onlineslangdictionary.com/lists/most-vulgar-words/
const List<String> unsafePairs = const [
  'babyarm',
  'ballsack',
  'furpie',
  'getbrain',
  'hairpie',
  'nutbutter',
];
