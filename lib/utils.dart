import 'dart:math';

class RandomUtils {
  static Random _random = Random();

  static int nextInt(int max) {
    return _random.nextInt(max);
  }
}