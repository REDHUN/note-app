import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebaseauthclean/features/domain/entities/user_entities.dart';
import 'package:firebaseauthclean/features/domain/usecases/is_authenticated_usecase.dart';
import 'package:firebaseauthclean/features/domain/usecases/signin_usecase.dart';
import 'package:firebaseauthclean/features/domain/usecases/signout_usecase.dart';
import 'package:firebaseauthclean/features/domain/usecases/signup_usecase.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  AuthBloc() : super(AuthInitial()) {
    on<CheckLoginStatusEvent>((event, emit) async {
      emit(AuthLoading());
      User? user;
      try {
        await Future.delayed(
          const Duration(seconds: 3),
        );
        if (await IsAuthenticateUseCase().isAuthenticated()) {
          emit(Authenticated(user));
        } else {
          emit(UnAuthenticated());
        }
      } catch (e) {
        emit(AuthenticatedError(errMsg: e.toString()));
      }
    });

    on<SignUpEvent>((event, emit) async {
      emit(AuthLoading());

      try {
        await SignUpUseCase().signUp(event.user);

        emit(Authenticated(FirebaseAuth.instance.currentUser));
      } catch (e) {
        emit(AuthenticatedError(errMsg: e.toString()));
      }
    });
    on<LoginEvent>((event, emit) async {
      emit(AuthLoading());
      try {
        await SingInUseCase()
            .signIn(event.email.toString(), event.password.toString());

        final User? user = FirebaseAuth.instance.currentUser;

        emit(Authenticated(user));
      } catch (e) {
        emit(AuthenticatedError(errMsg: e.toString()));
      }
    });

    on<LogoutEvent>((event, emit) async {
      try {
        await SingOutUseCase().signOut();
        emit(UnAuthenticated());
      } catch (e) {
        emit(AuthenticatedError(errMsg: e.toString()));
      }
    });
  }
}
