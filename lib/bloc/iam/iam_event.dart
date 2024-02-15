part of 'iam_bloc.dart';

sealed class IamEvent extends Equatable {
  const IamEvent();

  @override
  List<Object> get props => [];
}

class IamLoginEvent extends IamEvent {
  final String phoneNumber;

  const IamLoginEvent({required this.phoneNumber});
}

class IamVerifyOtpEvent extends IamEvent {
  final String otp;
  final String phoneNumber;

  const IamVerifyOtpEvent({required this.phoneNumber, required this.otp});
}

class IamResendOtpEvent extends IamEvent {}

class IamSignOutEvent extends IamEvent {}
