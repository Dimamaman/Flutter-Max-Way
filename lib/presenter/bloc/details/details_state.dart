part of 'details_bloc.dart';

@immutable
class DetailsState {
  final UIState state;
  final String errorMessage;
  final int productCount;
  final bool isAdded;
  final ProductData productData;
  final String buttonMessage;

  const DetailsState({
      this.state = UIState.init,
      this.errorMessage = '',
      this.productCount = 1,
      this.isAdded = false,
      this.productData = const ProductData(productId: '',price: 0,currency: '',image: '',title: '',description: '',amount: 0),
      this.buttonMessage = "Add"
      });

  DetailsState copyWith({
    UIState? state,
    String? errorMessage,
    int? productCount,
    bool? isAdded,
    ProductData? productData,
    String? buttonMessage
  }) {
    return DetailsState(
        state: state ?? this.state,
        errorMessage: errorMessage ?? this.errorMessage,
        productCount: productCount ?? this.productCount,
        isAdded: isAdded ?? this.isAdded,
        productData: productData ?? this.productData,
        buttonMessage: buttonMessage ?? this.buttonMessage
    );
  }
}

enum UIState { init, success, loading, error }
