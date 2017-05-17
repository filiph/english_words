# Changelog

## 2.0.4

- Make `generateWordPairs` 10-20x faster for the most common use case 
  (i.e. running the function with all named parameters at default values).

## 2.0.3

- Add 'rape' to unsafe words

## 2.0.2

- Add 'AIDS' to unsafe words

## 2.0.1

- Update README with refactor to `generateWordPairs`

## 2.0.0

- The `generateCombo()` function has been renamed to `generateWordPairs()`
- `generateWordPairs()` takes a `safeOnly` named argument. If set to `true` (default), it will avoid wordpairs like "ballsack" or anything containing "ass", "shit", "fucking", etc.
- Add benchmark for `GenerateWordPair()`
- Add exception for "cruel"

## 1.1.2

- Fix exceptions like "poet" and "conscious"

## 1.1.1

- Fix words like "dying" and "flying" to be disyllabic

## 1.1.0

- Use `string_scanner` instead of RegExp replace for most syllable counting
- 400% faster syllable counting

## 1.0.0

- Make the `syllables()` function work on 99+% cases
- semver guarantee

## 0.0.1

- Initial version

