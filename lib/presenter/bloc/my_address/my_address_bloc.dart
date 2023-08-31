import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter_max_way/core/floor/entity/address.dart';
import 'package:meta/meta.dart';

part 'my_address_event.dart';
part 'my_address_state.dart';

class MyAddressBloc extends Bloc<MyAddressEvent, MyAddressState> {
  MyAddressBloc() : super(const MyAddressState()) {
    on<MyAddressEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
