part of 'food_bloc.dart';

@immutable
abstract class FoodEvent {}

class LoadFoodEvent extends FoodEvent {

}

class SearchFoodEvent extends FoodEvent {
  String? searchValue;

  SearchFoodEvent(this.searchValue);

}

class SearchByTitleEvent extends FoodEvent {
  List<String>? searchCategories;
  SearchByTitleEvent(this.searchCategories);
}

