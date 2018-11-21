/// Expression to match double syllable pre- and suffixes.
final RegExp disyllabicPrefixSuffix = RegExp(
    '^' +
        '(' +
        'above|' +
        'anti|' +
        'ante|' +
        'counter|' +
        'hyper|' +
        'afore|' +
        'agri|' +
        'infra|' +
        'intra|' +
        'inter|' +
        'over|' +
        'semi|' +
        'ultra|' +
        'under|' +
        'extra|' +
        'dia|' +
        'micro|' +
        'mega|' +
        'kilo|' +
        'pico|' +
        'nano|' +
        'macro' +
        ')' +
        '|' +
        '(' +
        'fully|' +
        'berry|' +
        'woman|' +
        'women' +
        ')' +
        r'$',
    caseSensitive: false);

/// Part 1 of occurrences which normally would be counted as one syllable,
/// but should be counted as two.
final RegExp disyllabic1 = RegExp(
    '(' +
        '(' +
        '[^aeiouy]' +
        r')\2l|' +
        '[^aeiouy]ie' +
        '(' +
        'r|' +
        'st|' +
        't' +
        ')|' +
        '[aeiouym]bl|' +
        'eo|' +
        'ism|' +
        'asm|' +
        'thm|' +
        'dnt|' +
        'uity|' +
        'dea|' +
        'gean|' +
        'oa|' +
        'ua|' +
        'eings?|' +
        '[dl]ying|' +
        '[aeiouy]sh?e[rsd]' +
        r')$',
    caseSensitive: false);

/// Part 2 of occurrences which normally would be counted as one syllable,
/// but should be counted as two.
final RegExp disyllabic2 = RegExp(
    '[^gq]ua[^auieo]|' +
        r'[aeiou]{3}([^aeiou]|$)|' +
        '^(' +
        'ia|' +
        'mc|' +
        'coa[dglx].' +
        ')',
    caseSensitive: false);

/// Part 3 of occurrences which normally would be counted as one syllable,
/// but should be counted as two.
final RegExp disyllabic3 = RegExp(
    '[^aeiou]y[ae]|' +
        '[^l]lien|' +
        'riet|' +
        'dien|' +
        'iu|' +
        'io|' +
        'ii|' +
        'uen|' +
        'real|' +
        'iell|' +
        'eo[^aeiou]|' +
        '[aeiou]y[aeiou]',
    caseSensitive: false);

/// Part 4 of occurrences which normally would be counted as one syllable,
/// but should be counted as two.
final RegExp disyllabic4 = RegExp(r'[^s]ia', caseSensitive: false);
