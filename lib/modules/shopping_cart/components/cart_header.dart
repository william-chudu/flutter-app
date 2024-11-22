part of '../index.dart';

final class CartHeader extends StatelessWidget {
  const CartHeader({super.key, required this.label});

  final LanguageLabel label;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.green,
        borderRadius: BorderRadius.circular(5),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Transform.scale(
                scale: 1.25,
                child: BlocBuilder<CheckTemCartCubit, Map<String, bool>>(
                  builder: (context, state) {
                    return Checkbox(
                      checkColor: Colors.white,
                      splashRadius: 8,
                      activeColor: AppConstants.accent,
                      side: const BorderSide(color: Colors.white, width: 2),
                      value: state.values.every((value) => value),
                      onChanged: (value) {
                        context.read<CheckTemCartCubit>().checkAll(value ?? false);
                      },
                    );
                  },
                ),
              ),
              Text(
                label.selectAll,
                style: context.text.titleLarge?.copyWith(color: Colors.white),
              ),
            ],
          ),
          Row(
            children: [
              Text(
                label.delete,
                style: context.text.titleLarge?.copyWith(color: Colors.white),
              ),
              IconButton(
                onPressed: () {
                  //
                },
                icon: const Icon(Icons.delete, color: AppConstants.accent),
              )
            ],
          )
        ],
      ),
    );
  }
}
