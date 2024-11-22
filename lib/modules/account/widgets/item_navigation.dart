part of '../index.dart';

final class ItemNavigation extends StatelessWidget {
  const ItemNavigation({
    super.key,
    required this.title,
    this.onTap,
  });

  final String title;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      shape: const Border(bottom: BorderSide(color: Colors.grey)),
      contentPadding: EdgeInsets.zero,
      title: Text(
        title,
        style: context.text.bodyLarge,
      ),
      trailing: const Icon(
        Icons.chevron_right,
        color: AppConstants.accent,
        size: 25,
      ),
    );
  }
}
