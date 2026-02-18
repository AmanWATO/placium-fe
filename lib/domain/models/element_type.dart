enum ElementType {
  circle,
  square,
  triangle,
  star,
  person,
  tree,
  house,
  abstractBlock,
}

extension ElementTypeX on ElementType {
  String get key => name;

  static ElementType fromKey(String key) {
    return ElementType.values.firstWhere((element) => element.name == key);
  }
}
