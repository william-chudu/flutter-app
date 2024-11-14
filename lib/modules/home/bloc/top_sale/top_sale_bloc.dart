import 'dart:convert';

import 'package:chudu24/constants/url_path.dart';
import 'package:chudu24/enum/index.dart';
import 'package:chudu24/extensions/exception.dart';
import 'package:chudu24/modules/home/models/top_sale.dart';
import 'package:chudu24/request/index.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'top_sale_event.dart';
part 'top_sale_state.dart';

class TopSaleBloc extends Bloc<TopSaleEvent, TopSaleState> {
  TopSaleBloc() : super(const TopSaleInitial()) {
    on<GetTopSale>((GetTopSale event, Emitter<TopSaleState> emit) async {
      try {
        emit(const TopSaleLoading());
        await Future.delayed(const Duration(seconds: 0));
        final data = await ApiClient.shared.mPost(
          UrlPath.shared.topSale,
          {'typeKey': 'home'},
        );
        final json = jsonDecode(data.body);
        if (json['data'] == null ||
            json['data'][0] == null ||
            json['data'][0]['dataHangMuc'] == null) {
          emit(const TopSaleError());
          return;
        }
        final topSales = List<DataHangMuc>.from(
          json['data'][0]['dataHangMuc'].map((x) => DataHangMuc.fromJson(x)),
        );
        emit(TopSaleLoaded(data: topSales));
      } on Exception catch (e) {
        e.pError();
        emit(const TopSaleError());
      }
    });
  }
}
