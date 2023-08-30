part of 'cart_bloc.dart';

@immutable
class CartState {
  final UIState state;
  final String message;
  final List<ProductData> list;

  const CartState({
    this.state = UIState.init,
    this.message = '',
    this.list = const []
});

  CartState copyWith({
    UIState? state,
    String?  message,
    List<ProductData>? list,
}) {
    return CartState(
      state: state ?? this.state,
      message: message ?? this.message,
      list: list ?? this.list
    );
  }
}




enum UIState { init, success, loading, error }