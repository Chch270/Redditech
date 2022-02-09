class Pair {
  Pair(this.left, this.right);

  dynamic left;
  dynamic right;

  @override
  String toString() => 'Pair[$left, $right]';
  void clear() {
    left.clear();
    right = "";
  }
}

String getPathImg(String img) {
  List<String> suffix = ['.png', '.jpg', '.gif'];

  for (String it in suffix) {
    if (img.contains(it)) {
      return img.split(it)[0] + it;
    }
  }
  return ('');
}
