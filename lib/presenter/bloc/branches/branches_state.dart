part of 'branches_bloc.dart';

class BranchesState {
  final List<Branch> list;
  final UIStatus status;
  final String message;

  const BranchesState({this.list = const [], this.status = UIStatus.initial, this.message = ''});

  BranchesState copyWith({List<Branch>? list, UIStatus? status, String? message}) {
    return BranchesState(list: list ?? this.list, status: status ?? this.status, message: message ?? this.message);
  }
}

enum UIStatus { initial, loading, success, error }
