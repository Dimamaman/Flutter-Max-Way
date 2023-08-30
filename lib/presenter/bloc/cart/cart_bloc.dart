import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutter_max_way/core/floor/entity/product_data.dart';
import 'package:meta/meta.dart';

import '../../../core/floor/dao/product_dao.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  final ProductDao _productDao;

  CartBloc(this._productDao) : super(const CartState()) {
    on<CartEvent>((event, emit) async {
      switch(event) {
        case FetchProducts():
          await _onFetchProducts(event, emit);
      }
    });
  }


  Future<void>_onFetchProducts(FetchProducts event, Emitter<CartState> emit) async {
    if (state.state == UIState.loading) return;
    emit(state.copyWith(state: UIState.loading));

    try{
      var list = await _productDao.getAllProducts();
      print("EEEE from Database ${list.length}");
      state.copyWith(state: UIState.success,list: list);
    }catch(e) {
      state.copyWith(state: UIState.error,message: "$e");
    }
  }
}


