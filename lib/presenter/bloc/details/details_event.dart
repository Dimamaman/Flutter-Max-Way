part of '../../bloc/details/details_bloc.dart';

@immutable
abstract class DetailsEvent {}


class LoadProduct extends DetailsEvent {
  Product product;
  bool alreadyHave;

  LoadProduct({required this.product,required this.alreadyHave});

}

class UpdateProduct extends DetailsEvent{
  final ProductData product;
  final BuildContext context;

  UpdateProduct({required this.product, required this.context});
}

class AddProduct extends DetailsEvent {
  final ProductData product;
  final BuildContext context;

  AddProduct({required this.product, required this.context});

}

class ProductIncrement extends DetailsEvent {
  bool mustIncrement;

  ProductIncrement({required this.mustIncrement});

}

class ProductDecrement extends DetailsEvent{
  final BuildContext context;
  bool mustIncrement;

  ProductDecrement({required this.context,required this.mustIncrement});
}
