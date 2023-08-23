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
      switch (event) {
        case LoadFoodEvent():
          await _onLoadFoodEvent(event, emit);
          break;
        case SearchFoodEvent():
          await _onSearchFoodEvent(event, emit, event.searchValue);
          break;
        case SearchByTitleEvent():
          await _onSearchByTitleEvent(event, emit, event.searchCategories);
          break;
      }
    });
  }

  Future<void> _onLoadFoodEvent(
      LoadFoodEvent event, Emitter<FoodState> emit) async {
    if (state.status == EnumStatus.loading) return;

    emit(state.copyWith(status: EnumStatus.loading));

    var categoryName = <String>[];
    var temp = await _api.getProducts();
    for (Category category in temp) {
      categoryName.add(category.title.uz);
    }

    try {
      emit(state.copyWith(
          status: EnumStatus.success,
          list: await _api.getProducts(),
          categoryTitle: categoryName));
    } catch (e) {
      emit(state.copyWith(status: EnumStatus.error, message: "$e"));
    }
  }

  Future<void> _onSearchFoodEvent(SearchFoodEvent event,
      Emitter<FoodState> emit, String? searchValue) async {
    if (state.status == EnumStatus.loading) return;
    emit(state.copyWith(status: EnumStatus.loading));

    try {
      if (searchValue != null) {
        var list = <Product>[];

        for (Category category in await _api.getProducts()) {
          for (Product product in category.products) {
            if (product.title.uz.toLowerCase().contains(searchValue)) {
              list.add(product);
            }
          }
        }

        emit(state.copyWith(
          status: EnumStatus.success,
          list: <Category>[Category.empty(products: list)],
        ));
      }
    } catch (e) {
      emit(state.copyWith(status: EnumStatus.error, message: "$e"));
    }
  }

  Future<void> _onSearchByTitleEvent(SearchByTitleEvent event,
      Emitter<FoodState> emit, List<String>? searchCategories,) async {
    if (state.status == EnumStatus.loading) return;

    emit(state.copyWith(status: EnumStatus.loading));

    var list = <Category>[];
    var allList = await _api.getProducts();
    try {
      if (searchCategories != null) {
        for(Category category in allList) {
          for(int i = 0; i < searchCategories.length;i++) {
            if(searchCategories[i] == category.title.uz) {
              list.add(category);
            }
          }
        }
      }

      emit(state.copyWith(
        status: EnumStatus.success,
        list: list,
      ));
    } catch (e) {
      emit(state.copyWith(status: EnumStatus.error, message: "$e"));
    }
  }
}

/*  for(int i = 0; i < state.list.length; i++) {
          for(int j = 0; j < state.list[i].products.length; j++) {
            if(state.list[i].products[j].title.uz.toLowerCase().contains(searchValue)) {
              if(state.list[i].products.contains(state.list[i].products[j])) {
                print("EEEEEEEEEEE -> -> ${state.list[i].title.uz} -> -> ${state.list[i].products[j].title.uz}");
              }

              list.add(state.list[i].products[j]);
            }
          }
        }*/
