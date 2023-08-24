part of 'details_bloc.dart';

@immutable
class DetailsState {
  final List<ProductData> products;
  final UIState state;
  final String errorMessage;

  const DetailsState({
      this.products = const [],
      this.state = UIState.init,
      this.errorMessage = ''
  });

  DetailsState copyWith({
    List<ProductData>? products,
    UIState? state,
    String? errorMessage,
  }) {
    return DetailsState(
        products: products ?? this.products,
        state: state ?? this.state,
        errorMessage: errorMessage ?? this.errorMessage);
  }
}

enum UIState { init, success, loading, error }
