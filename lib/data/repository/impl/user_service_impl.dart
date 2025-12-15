import 'package:flutter_code_template/core/constants/api_url.dart';
import 'package:flutter_code_template/core/network/api_client.dart';
import 'package:flutter_code_template/data/models/common/common_api_response.dart';
import 'package:flutter_code_template/data/models/user/user_model.dart';
import 'package:flutter_code_template/data/repository/service/user_service.dart';

class UserServiceImpl extends UserService {
    final ApiClient apiClient;

  UserServiceImpl(this.apiClient);

  @override
  Future<CommonApiResponse<List<UserModel>>> getUsers() {
  return apiClient.get<List<UserModel>>(
    ApiUrl.GET_USERS,
    fromJson: (json) =>
        (json as List).map((e) => UserModel.fromJson(e)).toList(),
  );
}

  @override
Future<CommonApiResponse<UserModel>> getUserById(int id) {
  return apiClient.get<UserModel>(
    '${ApiUrl.GET_USERS}/$id',
    fromJson: (json) => UserModel.fromJson(json),
  );
}
}
