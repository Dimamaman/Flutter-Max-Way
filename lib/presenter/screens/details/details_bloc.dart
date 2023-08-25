import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/hive/hive.dart';
import '../../../core/model/model.dart';
import '../../../core/model/product_data.dart';

part 'details_event.dart';

part 'details_state.dart';

class DetailsBloc extends Bloc<DetailsEvent, DetailsState> {
  final HiveHelper _hiveHelper;
  final _stateController = StreamController<DetailsState>();

  DetailsBloc(this._hiveHelper) : super(const DetailsState()) {
    on<DetailsEvent>((event, emit) async {
      switch (event) {
        case LoadProducts():
          await _onLoadProducts(event, emit);
        case AddProduct():
          _onAddProduct(event, emit, event.product, event.context);
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

  Future<void> _onAddProduct(DetailsEvent event, Emitter<DetailsState> emit, ProductData product, BuildContext context) async {
    if (state.state == UIState.loading) return;
    emit(state.copyWith(state: UIState.loading));

    try{
      print("HHHHHHH qosildima?");
      await _hiveHelper.addProduct(product);
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Product added to Cart')));
      print("HHHHHHH qosildima awwwwwaaa");
    }catch(e) {
      print("HHHHHHH qosildima YAQ");
      emit(state.copyWith(state: UIState.error, errorMessage: "$e"));
    }
  }
}
