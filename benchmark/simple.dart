// Copyright (c) 2017, filiph. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

import 'package:english_words/english_words.dart';

void main() {
  final total = generateWordPairs()
      .take(100000)
      .map((pair) => pair.asString.length)
      .fold<int>(0, (prev, e) => prev + 2 * e);
  print(total);
}
