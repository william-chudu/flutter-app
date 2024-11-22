part of '../index.dart';

final class BoxSummary extends StatelessWidget {
  const BoxSummary({
    super.key,
    this.pointLock,
    required this.first,
    required this.second,
    required this.secondValue,
    required this.third,
    required this.thirdValue,
  });

  final ValueNotifier<int>? pointLock;
  final String first;
  final String second;
  final String secondValue;
  final String third;
  final Widget thirdValue;

  @override
  Widget build(BuildContext context) {
    const radius = 5.0;
    return Column(
      children: [
        Container(
          width: double.infinity,
          margin: const EdgeInsets.symmetric(horizontal: 5),
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.blue),
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(radius),
              topRight: Radius.circular(radius),
            ),
          ),
          child: Text(
            first,
            style: context.text.labelLarge,
          ),
        ),
        Container(
          width: double.infinity,
          margin: const EdgeInsets.symmetric(horizontal: 5),
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          decoration: const BoxDecoration(
            border: Border(
              left: BorderSide(color: Colors.blue),
              right: BorderSide(color: Colors.blue),
              bottom: BorderSide(color: Colors.blue),
            ),
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(radius),
              bottomRight: Radius.circular(radius),
            ),
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    second,
                    style: context.text.labelMedium,
                  ),
                  pointLock == null
                      ? Text(
                          secondValue,
                          style: context.text.titleMedium?.copyWith(color: Colors.blue),
                        )
                      : ValueListenableBuilder(
                          valueListenable: pointLock as ValueNotifier<int>,
                          builder: (_, value, __) {
                            return Text(
                              value.toString(),
                              style: context.text.titleMedium?.copyWith(color: Colors.green),
                            );
                          },
                        ),
                ],
              ),
              const SizedBox(height: 5),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    third,
                    style: context.text.labelMedium,
                  ),
                  thirdValue,
                ],
              ),
              const SizedBox(height: 10),
            ],
          ),
        ),
      ],
    );
  }
}
