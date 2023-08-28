import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_max_way/presenter/utils/toast.dart';
import 'package:fluttertoast/fluttertoast.dart';

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
          break;

        case ProductIncrement():
          _onProductIncrement(event, emit, event.mustIncrement);
          break;

        case ProductDecrement():
          _onProductDecrement(event, emit, event.context);
          break;

        case LoadProduct():
          await _onLoadProduct(event, emit, event.product, event.alreadyHave);
          break;
        // case UpdateProduct():
        //   await _onUpDateProduct(event, emit, event.product, event.context);
        //   break;
      }
    });
  }

  Future<void> _onAddProduct(DetailsEvent event, Emitter<DetailsState> emit, ProductData product, BuildContext context) async {
    if (state.state == UIState.loading) return;
    emit(state.copyWith(state: UIState.loading));

    try {
      _productDao.insertProduct(product);
      // ScaffoldMessenger.of(context).showSnackBar(const SnackBar(duration: Duration(milliseconds: 500),content: Text('Product added to Cart')));
      emit(state.copyWith(state: UIState.success, buttonMessage: "To Cart"));
    } catch (e) {
      emit(state.copyWith(state: UIState.error, errorMessage: "$e"));
    }
  }

  // Future<void> _onUpDateProduct(UpdateProduct event, Emitter<DetailsState> emit, ProductData product, BuildContext context) async {
  //   if (state.state == UIState.loading) return;
  //   emit(state.copyWith(state: UIState.loading));
  //   try {
  //     _productDao.insertProduct(product);
  //     ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Product updated')));
  //     emit(state.copyWith(state: UIState.success, buttonMessage: "To Cart"));
  //   } catch (e) {
  //     emit(state.copyWith(state: UIState.error, errorMessage: "$e"));
  //   }
  //
  // }

  void _onProductIncrement(ProductIncrement event, Emitter<DetailsState> emit, bool mustIncrement) {
    if (mustIncrement) {
      var temp = state.productCount;
      print("VVVVVVVV $temp");
      temp++;
      print("VVVVVVVV $temp");
      emit(state.copyWith(productCount: temp, buttonMessage: "Add"));
    } else {
      var tempt = state.productCount;
      tempt++;
      emit(state.copyWith(productCount: tempt, buttonMessage: "Add"));
    }
  }

  void _onProductDecrement(ProductDecrement event, Emitter<DetailsState> emit, BuildContext context) {
    var temp = state.productCount;
    temp--;
    if (temp < 1) {
      showToast(["Product kamida 1 ta bo'lishi kk"], context,gravity: ToastGravity.TOP);
      // ScaffoldMessenger.of(context).showSnackBar(const SnackBar(duration: Duration(milliseconds: 500),content: Text("Product kamida 1 ta bo'lishi kk")));
    }

    if (state.productCount > 1) {
      var tempt = state.productCount;
      tempt--;
      emit(state.copyWith(productCount: tempt, buttonMessage: "Add"));
    }
  }

  Future<void> _onLoadProduct(LoadProduct event, Emitter<DetailsState> emit, Product product, bool alreadyHave) async {
    var isAdded = alreadyHave;
    late ProductData productData1;

    for (ProductData productData in await _productDao.getAllProducts()) {
      if (productData.title == product.title.uz) {
        isAdded = true;
        productData1 = productData;
        break;
      }
    }
    if (isAdded) {
      emit(state.copyWith(isAdded: isAdded, productData: productData1, productCount: productData1.amount, buttonMessage: "To Cart"));
    } else {
      emit(state.copyWith(isAdded: isAdded));
    }
  }
}
