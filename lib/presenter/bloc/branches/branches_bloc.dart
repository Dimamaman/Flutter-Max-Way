import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../core/api/food_api.dart';
import '../../../core/model/branch_model.dart';

part 'branches_event.dart';

part 'branches_state.dart';

class BranchesBloc extends Bloc<BranchesEvent, BranchesState> {
  final FoodApi _api;

  BranchesBloc(this._api) : super(const BranchesState()) {
    on<BranchesEvent>((event, emit) async {
      switch (event) {
        case LoadBranches():
          await _loadBranches(event, emit);
      }
    });
  }

  Future<void> _loadBranches(LoadBranches event, Emitter<BranchesState> emit) async {
    if (state.status == UIStatus.loading) return;
    emit(state.copyWith(status: UIStatus.loading));

    try {
      var list = await _api.getBranches();
      print("HHHHHHHHHHHHHH $list");
      emit(state.copyWith(list: await _api.getBranches(), status: UIStatus.success));
    } catch (e) {
      emit(state.copyWith(status: UIStatus.error, message: "$e"));
    }

  }
}
