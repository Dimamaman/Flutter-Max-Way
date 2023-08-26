part of 'details_bloc.dart';

@immutable
class DetailsState {
  final UIState state;
  final String errorMessage;
  final int productCount;

  const DetailsState(
      {this.state = UIState.init,
      this.errorMessage = '',
      this.productCount = 1});

  DetailsState copyWith({
    UIState? state,
    String? errorMessage,
    int? productCount,
  }) {
    return DetailsState(
        state: state ?? this.state,
        errorMessage: errorMessage ?? this.errorMessage,
        productCount: productCount ?? this.productCount
    );
  }
}

enum UIState { init, success, loading, error }
