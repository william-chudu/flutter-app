final class HeaderListItems<T> {
  final int id;
  final String title;
  final List<T> items;

  const HeaderListItems({required this.id, required this.title, required this.items});
}
