part of 'my_address_bloc.dart';

@immutable
abstract class MyAddressEvent {}

class LoadAddress extends MyAddressEvent {

}

class DeleteAddress extends MyAddressEvent {
  Address address;

  DeleteAddress({required this.address});

}
