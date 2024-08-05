import 'package:antons_app/use_case/auth_use_case.dart';
import 'package:bloc/bloc.dart';
import 'package:get_it/get_it.dart';

class AuthBloc extends Bloc<AuthBlocEvent, AuthBlocState>{
  final authUseCase = GetIt.instance<AuthUseCase>();

  AuthBloc() : super(UnauthorizedState()){
    on<LoginRequestedEvent>(_onLoginRequestedEvent);
    on<RegistrationRequestedEvent>(_onRegistrationRequestedEvent);
  }

  _onLoginRequestedEvent(LoginRequestedEvent event, Emitter emit) async {
    emit(LoadingAuthState());
    String status = await authUseCase.login(event.login, event.password);
    if(status == 'OK'){
      emit(SuccessfulAuthState());
    }
    else{
      emit(ErrorAuthState(status));
    }
  }

  _onRegistrationRequestedEvent(RegistrationRequestedEvent event, Emitter emit) async {
    emit(LoadingAuthState());
    String status = await authUseCase.register(event.login, event.email, event.password);
    if(status == 'OK'){
      emit(SuccessfulAuthState());
    }
    else{
      emit(ErrorAuthState(status));
    }
  }
}

abstract class AuthBlocEvent{}
class LoginRequestedEvent extends AuthBlocEvent{
  final String login;
  final String password;
  LoginRequestedEvent(this.login, this.password);
}
class RegistrationRequestedEvent extends AuthBlocEvent{
  final String login;
  final String email;
  final String password;
  RegistrationRequestedEvent(this.login, this.email, this.password);
}
class AuthOutdatedEvent extends AuthBlocEvent{}

abstract class AuthBlocState{}
class UnauthorizedState extends AuthBlocState{}
class LoadingAuthState extends AuthBlocState{}
class ErrorAuthState extends AuthBlocState{
  final String errorDescription;
  ErrorAuthState(this.errorDescription);
}
class SuccessfulAuthState extends AuthBlocState{}