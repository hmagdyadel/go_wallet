import 'package:freezed_annotation/freezed_annotation.dart';

part 'expenses_states.freezed.dart';

@freezed
class ExpensesStates<T> with _$ExpensesStates<T> {
  const factory ExpensesStates.initial() = _Initial;

  const factory ExpensesStates.loading() = Loading;

  const factory ExpensesStates.loaded() = Loaded;
  const factory ExpensesStates.empty() = Empty;

  const factory ExpensesStates.success(T data) = Success<T>;

  const factory ExpensesStates.error({required String message}) = Error;
}
