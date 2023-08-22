part of 'food_bloc.dart';

@immutable
class FoodState {
  final List<Category> list;
  final List<String> categoryTitle;
  final EnumStatus status;
  final String message;

  const FoodState({
    this.list = const[],
    this.categoryTitle = const[],
    this.status = EnumStatus.initial,
    this.message = ""
  });

  FoodState copyWith({
    List<Category>? list,
    List<String>? categoryTitle,
    EnumStatus? status,
    String? message,
}) {
      return FoodState(
        list: list ?? this.list,
        categoryTitle: categoryTitle ?? this.categoryTitle,
        status: status ?? this.status,
        message: message ?? this.message
      );
  }
}


enum EnumStatus { initial, loading, success, error }
