part of 'food_bloc.dart';

@immutable
class FoodState {
  final List<Category> list;
  final EnumStatus status;
  final String message;

  const FoodState({
    this.list = const[],
    this.status = EnumStatus.initial,
    this.message = ""
  });

  FoodState copyWith({
    List<Category>? list,
    EnumStatus? status,
    String? message,
}) {
      return FoodState(
        list: list ?? this.list,
        status: status ?? this.status,
        message: message ?? this.message
      );
  }
}


enum EnumStatus { initial, loading, success, error }
