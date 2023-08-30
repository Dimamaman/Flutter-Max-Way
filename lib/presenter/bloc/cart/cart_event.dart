part of 'cart_bloc.dart';

@immutable
abstract class CartEvent {}

class FetchProducts extends CartEvent {

}

class DeleteProduct extends CartEvent{
  final String id;
  DeleteProduct({required this.id});

}

class IncrementProduct extends CartEvent {
  final ProductData productData;
  IncrementProduct({required this.productData});
}

class DecrementProduct extends CartEvent {
  final ProductData productData;
  DecrementProduct({required this.productData});
}