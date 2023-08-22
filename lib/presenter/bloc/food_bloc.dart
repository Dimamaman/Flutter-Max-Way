import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../core/api/food_api.dart';
import '../../core/model/model.dart';

part 'food_event.dart';
part 'food_state.dart';

class FoodBloc extends Bloc<FoodEvent, FoodState> {

  final FoodApi _api;

  FoodBloc(this._api) : super(FoodState()) {
    on<FoodEvent>((event, emit) async {
      switch(event) {
        case LoadFoodEvent():
          await _onLoadFoodEvent(event, emit, event.searchValue);
          break;
      }
    });
  }

  Future<void> _onLoadFoodEvent(LoadFoodEvent event, Emitter<FoodState> emit, String? searchValue) async {
    if (state.status == EnumStatus.loading) return;

    emit(state.copyWith(status: EnumStatus.loading));

    try {
      if (searchValue != null) {
        emit(state.copyWith(
          status: EnumStatus.success,
          list: await _api.getProducts(),
        ));
      } else {
        emit(state.copyWith(
          status: EnumStatus.success,
          list: await _api.getProducts(),
        ));
      }
    } catch (e) {
      emit(state.copyWith(status: EnumStatus.error, message: "$e"));
    }

  }
}
