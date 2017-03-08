/* Expression to match double syllable pre- and suffixes. */
final disyllabicPrefixSuffix = new RegExp(
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
    caseSensitive: false
);

/* Four expression of occurrences which normally would be
 * counted as one syllable, but should be counted as two. */
final disyllabic1 = new RegExp(
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
        '[aeiouy]sh?e[rsd]' +
        r')$',
    caseSensitive: false);

var disyllabic2 = new RegExp(
    '[^gq]ua[^auieo]|' +
        r'[aeiou]{3}([^aeiou]|$)|' +
        '^(' +
        'ia|' +
        'mc|' +
        'coa[dglx].' +
        ')',
    caseSensitive: false);

var disyllabic3 = new RegExp(
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

var disyllabic4 = new RegExp(r'[^s]ia', caseSensitive: false);
