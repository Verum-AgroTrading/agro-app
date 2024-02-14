import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:verum_agro_trading/domain/iam_repository.dart';
import 'package:verum_agro_trading/domain/remote_db_repository.dart';
import 'package:verum_agro_trading/routing/routes.dart';
import 'package:verum_agro_trading/utils/constants.dart';

part 'iam_event.dart';
part 'iam_state.dart';

class IamBloc extends Bloc<IamEvent, IamState> {
  final IamRepository iamRepository;
  final FirebaseAuth firebaseAuth;
  final RemoteDbRepository remoteDbRepository;
  late String _phoneNumber;

  User? get user => FirebaseAuth.instance.currentUser;

  bool get isLoggedIn => FirebaseAuth.instance.currentUser != null;

  String get phoneNumber => _phoneNumber;

  IamBloc(this.iamRepository, this.firebaseAuth, this.remoteDbRepository)
      : super(const IamState(state: IamStateValue.initial, message: "")) {
    /// [IamLoginEvent] initializes the call to firebase and initiates the login
    /// process by sending the OTP
    /// also sends the user to the OTP verification page
    on<IamLoginEvent>((event, emit) async {
      emit(state.copyWith(
          state: IamStateValue.loading,
          navigateTo: null,
          message: "",
          queryParameters: null));
      try {
        _phoneNumber = event.phoneNumber;
        await iamRepository
            .loginViaPhoneNumber(phoneNumber: event.phoneNumber.trim())
            .then((value) => emit(state.copyWith(
                state: IamStateValue.success,
                navigateTo: RoutingPaths.verifyOtp,
                queryParameters: {'phoneNumber': phoneNumber},
                message: null)));
      } catch (err) {
        if (err is FirebaseAuthException) {
          emit(state.copyWith(
              state: IamStateValue.failure, message: err.message));
        } else {
          emit(state.copyWith(
              state: IamStateValue.failure,
              message: Constants.genericErrorMessage));
        }
      }
    });

    /// [IamVerifyOtpEvent] verifies OTP, if the OTP is correct,
    /// searches for the user in the database, if the user is not present,
    /// registers the user, then
    /// takes the user to the HomePage
    on<IamVerifyOtpEvent>((event, emit) async {
      emit(state.copyWith(
          state: IamStateValue.loading,
          navigateTo: null,
          message: "",
          queryParameters: null));
      try {
        await iamRepository.verifyOTP(otp: event.otp).then((result) async {
          if (result) {
            final userRegistered =
                await remoteDbRepository.isUserRegistered(userId: user!.uid);
            if (!userRegistered) {
              await remoteDbRepository.registerUser(
                  userId: user!.uid, phoneNumber: event.phoneNumber);
            }

            emit(state.copyWith(
                state: IamStateValue.success,
                navigateTo: RoutingPaths.home,
                queryParameters: null,
                message: ""));
          } else {
            emit(state.copyWith(
                state: IamStateValue.failure,
                message: Constants.genericErrorMessage));
          }
        });
      } catch (err) {
        if (err is FirebaseAuthException) {
          emit(state.copyWith(
              state: IamStateValue.failure, message: err.message));
        } else {
          emit(state.copyWith(
              state: IamStateValue.failure,
              message: Constants.genericErrorMessage));
        }
      }
    });

    /// [IamResendOtpEvent] helps re-send the OTP by reinitializing the OTP
    /// process as given in
    /// https://firebase.google.com/docs/auth/flutter/phone-auth#codesent
    on<IamResendOtpEvent>((event, emit) {
      add(IamLoginEvent(phoneNumber: _phoneNumber));
    });

    /// [IamSignOutEvent] for user sign out
    /// should navigate the user to login screen
    on<IamSignOutEvent>((event, emit) async {
      try {
        emit(state.copyWith(
            state: IamStateValue.loading,
            navigateTo: null,
            message: "",
            queryParameters: null));
        // we won't wait for the signout call to complete
        iamRepository.signOut();
        emit(state.copyWith(
          state: IamStateValue.success,
          navigateTo: RoutingPaths.login,
          queryParameters: null,
          message: "",
        ));
      } catch (err) {
        if (err is FirebaseAuthException) {
          emit(state.copyWith(
              state: IamStateValue.failure, message: err.message));
        } else {
          emit(state.copyWith(
              state: IamStateValue.failure,
              message: Constants.genericErrorMessage));
        }
      }
    });
  }
}
