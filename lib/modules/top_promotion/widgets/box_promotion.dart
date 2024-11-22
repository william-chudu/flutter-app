part of '../index.dart';

final class BoxPromotion extends StatelessWidget {
  const BoxPromotion({
    super.key,
    required this.sale,
    required this.label,
  });

  final DataHangMuc sale;
  final LanguageLabel label;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      padding: const EdgeInsets.only(left: 10, top: 10, bottom: 10),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(5),
      ),
      child: Row(
        children: [
          ImageBuilder(
            sale.linkImage,
            width: 150,
            height: double.infinity,
            fit: BoxFit.cover,
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  sale.tieuDe,
                  style: context.text.titleMedium?.copyWith(color: Colors.green),
                ),
                const SizedBox(height: 10),
                Text(sale.tomTat),
                const SizedBox(height: 10),
                Row(
                  children: [
                    const Spacer(),
                    GestureDetector(
                      onTap: () {
                        if (sale.idLoaiHangMuc == 1) {
                          ModalDetailPromotion.showModal(
                            context,
                            ParamDetailPromotion(
                              idDanhMuc: sale.idDanhMuc,
                              idHotel: sale.hotel.idint,
                              idRoomType: sale.roomIdInt,
                            ),
                            sale.tieuDe,
                          );
                        } else {
                          Navigator.of(context).pushNamed(
                            Webview.routeName,
                            arguments: {'link': sale.linkImage},
                          );
                        }
                      },
                      child: Text(
                        label.viewDetail,
                        style: context.text.headlineSmall,
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
          const SizedBox(width: 10),
        ],
      ),
    );
  }
}
