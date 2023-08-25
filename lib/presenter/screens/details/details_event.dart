part of 'details_bloc.dart';

@immutable
abstract class DetailsEvent {}

class LoadProducts extends DetailsEvent { }

class AddProduct extends DetailsEvent {
  final ProductData product;
  final BuildContext context;

  AddProduct({required this.product, required this.context});

}

class DeleteProduct extends DetailsEvent {
  Product product;

  DeleteProduct({required this.product});
}
