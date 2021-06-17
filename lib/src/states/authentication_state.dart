import 'package:equatable/equatable.dart';
import 'package:expat_assistant/src/models/auth_status.dart';


class AuthenticationState extends Equatable {
  final AuthenticationStatus status;
  final Map<dynamic, dynamic> loginResponse;

  const AuthenticationState({this.status, this.loginResponse});

  @override
  // TODO: implement props
  List<Object> get props => [status, loginResponse];

  AuthenticationState copyWith({Map<dynamic, dynamic> loginResponse, AuthenticationStatus status}){
    return AuthenticationState(status: status ?? this.status, loginResponse: loginResponse ?? this.loginResponse);
  }
}