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
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
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
                    style: const TextStyle(fontSize: 16),
                  ),
                  pointLock == null
                      ? Text(
                          secondValue,
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.blue,
                            fontWeight: FontWeight.w600,
                          ),
                        )
                      : ValueListenableBuilder(
                          valueListenable: pointLock as ValueNotifier<int>,
                          builder: (_, value, __) {
                            return Text(
                              value.toString(),
                              style: const TextStyle(
                                fontSize: 16,
                                color: Colors.green,
                                fontWeight: FontWeight.w600,
                              ),
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
                    style: const TextStyle(fontSize: 16),
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
