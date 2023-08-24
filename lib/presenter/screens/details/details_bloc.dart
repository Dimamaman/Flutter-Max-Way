import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../core/hive/hive.dart';
import '../../../core/model/model.dart';
import '../../../core/model/product_data.dart';

part 'details_event.dart';

part 'details_state.dart';

class DetailsBloc extends Bloc<DetailsEvent, DetailsState> {
  final HiveHelper _hiveHelper;
  final _stateController = StreamController<DetailsState>();

  DetailsBloc(this._hiveHelper) : super(DetailsState()) {
    on<DetailsEvent>((event, emit) async {
      switch (event) {
        case LoadProducts():
          await _onLoadProducts(event, emit);
        case AddProduct():
          _onAddProduct(event, emit, event.product);
        case DeleteProduct():
          await _onLoadProducts(event, emit);
      }
    });
  }

  Future<void> _onLoadProducts(
      DetailsEvent event, Emitter<DetailsState> emit) async {
    if (state.state == UIState.loading) return;
    emit(state.copyWith(state: UIState.loading));

    var result = <ProductData>[];
    var temp = await _hiveHelper.getAllProducts();
    print("KKKKKKKKKKK $temp");

    for (ProductData product in temp) {
      result.add(product);
    }

    try {
      emit(state.copyWith(
        state: UIState.success,
        products: result,
      ));
    } catch (e) {
      emit(state.copyWith(state: UIState.error, errorMessage: "$e"));
    }
  }

  Future<void> _onAddProduct(DetailsEvent event, Emitter<DetailsState> emit, ProductData product) async {
    if (state.state == UIState.loading) return;
    emit(state.copyWith(state: UIState.loading));

    try{
      await _hiveHelper.addProduct(product);
    }catch(e) {
      emit(state.copyWith(state: UIState.error, errorMessage: "$e"));
    }
  }
}
