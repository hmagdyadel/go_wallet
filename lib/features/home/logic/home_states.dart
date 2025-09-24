import 'package:freezed_annotation/freezed_annotation.dart';

part 'home_states.freezed.dart';

@freezed
class HomeStates<T> with _$HomeStates<T> {
  const factory HomeStates.initial() = _Initial;

  const factory HomeStates.loading() = Loading;

  const factory HomeStates.loaded() = Loaded;
  const factory HomeStates.toggleMethod() = ToggleMethod;

  const factory HomeStates.empty() = Empty;

  const factory HomeStates.success(T data) = Success<T>;

  const factory HomeStates.error({required String message}) = Error;
}
