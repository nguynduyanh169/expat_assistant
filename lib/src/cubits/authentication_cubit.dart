import 'package:bloc/bloc.dart';
import 'package:expat_assistant/src/configs/constants.dart';
import 'package:expat_assistant/src/models/auth_status.dart';
import 'package:expat_assistant/src/states/authentication_state.dart';
import 'package:expat_assistant/src/utils/hive_utils.dart';

class AuthenticationCubit extends Cubit<AuthenticationState>{
  HiveUtils _hiveUtils = HiveUtils();
  AuthenticationCubit(): super(const AuthenticationState());

  Future<void> checkLoggedIn() async{
    Map<dynamic, dynamic> loginResponse = _hiveUtils.getUserAuth(boxName: HiveBoxName.USER_AUTH);
    if(loginResponse == null){
      emit(state.copyWith(status: AuthenticationStatus.unauthenticated));
    }else{
      emit(state.copyWith(loginResponse: loginResponse, status: AuthenticationStatus.authenticated));
    }
  }

}