import 'dart:math';

List<Map<String, dynamic>> getRandom(List<Map<String, dynamic>> items,
    {int count = 5}) {
  var random = Random();
  List<Map<String, dynamic>> result = [];
  List<int> usedIndex = [];

  while (result.length != count) {
    int value = random.nextInt(items.length);

    if (!usedIndex.contains(value)) {
      result.add(items[value]);
      usedIndex.add(value);
    }
  }

  return result;
}
