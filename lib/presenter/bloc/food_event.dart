part of 'food_bloc.dart';

@immutable
abstract class FoodEvent {}

class LoadFoodEvent extends FoodEvent {
  String? searchValue;

  LoadFoodEvent(this.searchValue);

}

