extension StringExtension on String {
  String toCapitalize() {
    return "${this[0].toUpperCase()}${substring(1).toLowerCase()}";
  }

  String toTitleCase({String i = ' ', String o = ' '}) {
    return split(i).map((s) => s.toCapitalize()).join(o);
  }

  String get imgUrl => replaceFirst('http://', 'https://');
}
