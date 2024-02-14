part of 'iam_bloc.dart';

enum IamStateValue {
  initial,
  loading,
  success,
  failure,
}

final class IamState extends Equatable {
  final IamStateValue state;
  final String message;
  final String? navigateTo;
  final Map<String, dynamic>? queryParameters;

  const IamState(
      {this.navigateTo,
      this.queryParameters,
      required this.state,
      required this.message});

  @override
  List<Object> get props =>
      [state, message, navigateTo ?? "", queryParameters ?? ""];

  IamState copyWith({
    IamStateValue? state,
    String? message,
    String? navigateTo,
    Map<String, dynamic>? queryParameters,
  }) {
    return IamState(
        state: state ?? this.state,
        message: message ?? "",
        navigateTo: navigateTo,
        queryParameters: queryParameters ?? this.queryParameters);
  }
}
