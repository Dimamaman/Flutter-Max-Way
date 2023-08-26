import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/floor/dao/dao.dart';
import '../../../core/model/model.dart';
import '../../../core/floor/entity/product_data.dart';

part 'details_event.dart';

part 'details_state.dart';

class DetailsBloc extends Bloc<DetailsEvent, DetailsState> {
  final ProductDao _productDao;

  DetailsBloc(this._productDao) : super(const DetailsState()) {
    on<DetailsEvent>((event, emit) async {
      switch (event) {
        case AddProduct():
          _onAddProduct(event, emit, event.product, event.context);
        case ProductIncrement():
          _onProductIncrement(event, emit);

        case ProductDecrement():
          _onProductDecrement(event, emit, event.context);
      }
    });
  }

  Future<void> _onAddProduct(DetailsEvent event, Emitter<DetailsState> emit, ProductData product, BuildContext context) async {
    if (state.state == UIState.loading) return;
    emit(state.copyWith(state: UIState.loading));

    try{
      _productDao.insertProduct(product);
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Product added to Cart')));
    }catch(e) {
      emit(state.copyWith(state: UIState.error, errorMessage: "$e"));
    }
  }

  void _onProductIncrement(ProductIncrement event, Emitter<DetailsState> emit) {
    var tempt = state.productCount;
    tempt++;
    emit(state.copyWith(productCount: tempt));
  }

  void _onProductDecrement(ProductDecrement event, Emitter<DetailsState> emit, BuildContext context) {
    var temp = state.productCount;
    temp--;
    if(temp < 1) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Product kamida 1 ta bo'lishi kk")));
    }

    if(state.productCount > 1) {
      var tempt = state.productCount;
      tempt--;
      emit(state.copyWith(productCount: tempt));
    }
  }
}
