part of 'my_address_bloc.dart';

@immutable
class MyAddressState {
  final UIState state;
  final String message;
  final List<Address> list;

  const MyAddressState({this.state = UIState.init, this.message = '', this.list = const []});

  MyAddressState copyWith({
    UIState? state,
    String? message,
    List<Address>? list
}) {
    return MyAddressState(
      state: state ?? this.state,
      message: message ?? this.message,
      list: list ?? this.list
    );
  }

}

enum UIState { init, success, loading, error }
