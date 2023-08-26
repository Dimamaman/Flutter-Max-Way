import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'branches_event.dart';
part 'branches_state.dart';

class BranchesBloc extends Bloc<BranchesEvent, BranchesState> {
  BranchesBloc() : super(BranchesInitial()) {
    on<BranchesEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
