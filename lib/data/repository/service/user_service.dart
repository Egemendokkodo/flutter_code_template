import 'package:flutter_code_template/data/models/common/common_api_response.dart';
import 'package:flutter_code_template/data/models/user/user_model.dart';

abstract class UserService {
  Future<CommonApiResponse<List<UserModel>>> getUsers();
  Future<CommonApiResponse<UserModel>> getUserById(int id);
}
