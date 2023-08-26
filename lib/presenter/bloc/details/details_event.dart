part of '../../bloc/details/details_bloc.dart';

@immutable
abstract class DetailsEvent {}

class AddProduct extends DetailsEvent {
  final ProductData product;
  final BuildContext context;

  AddProduct({required this.product, required this.context});

}

class ProductIncrement extends DetailsEvent {

}

class ProductDecrement extends DetailsEvent{
  final BuildContext context;

  ProductDecrement({required this.context});
}
