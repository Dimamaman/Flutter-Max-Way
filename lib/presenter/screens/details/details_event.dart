part of 'details_bloc.dart';

@immutable
abstract class DetailsEvent {}

class LoadProducts extends DetailsEvent { }

class AddProduct extends DetailsEvent {
  ProductData product;

  AddProduct({required this.product});

}

class DeleteProduct extends DetailsEvent {
  Product product;

  DeleteProduct({required this.product});
}
