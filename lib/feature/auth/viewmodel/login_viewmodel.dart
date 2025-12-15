import 'package:flutter/material.dart';
import 'package:flutter_code_template/core/network/api_state.dart';
import 'package:flutter_code_template/data/models/user/user_model.dart';
import 'package:flutter_code_template/data/repository/service/user_service.dart';
import 'package:flutter_code_template/data/viewmodel/base_viewmodel.dart';

class LoginViewModel extends BaseViewModel {
  final UserService _userService;

  LoginViewModel(this._userService);

  ApiState<List<UserModel>> usersState = const ApiState.idle();
  ApiState<UserModel> userDetailState = const ApiState.idle();

  Future<void> fetchUsers() async {
    await runApi<List<UserModel>>(
      (state) => usersState = state,
      () => _userService.getUsers(),
    );
  }

  Future<void> fetchUserById(int id) async {
    await runApi<UserModel>(
      (state) => userDetailState = state,
      () => _userService.getUserById(id),
    );
  }
}
