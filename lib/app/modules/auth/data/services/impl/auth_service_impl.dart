import 'dart:convert';

import 'package:dio/dio.dart';

import '../../../../../config/auth_api_service.dart';
import '../../../models/logged_user_model.dart';
import '../i_auth_service.dart';

class AuthServiceImpl extends IAuthService {
  final AuthApiService authApiService;

  AuthServiceImpl({required this.authApiService});

  @override
  Future<String> getUserToken({
    required String username,
    required String password,
  }) async {
    try {
      var headers = {'Content-Type': 'application/json'};
      var data = json.encode({
        "aux_attributes": {"processo_submissao": "40896590"},
        "user_identifier": username,
        "password": "qwe",
      });

      final response = await authApiService.postRequest(
        '/authenticate',
        data: data,
        options: Options(headers: headers),
      );

      if (response.statusCode == 200) {
        return response.data;
      } else {
        throw Exception(
          'Erro ao obter token: Status code ${response.statusCode}',
        );
      }
    } on Exception catch (e) {
      rethrow;
    }
  }

  @override
  Future<LoggedUserModel> getUserData(String userToken) async {
    // Simulação de obtenção de dados do usuário.
    if (true) {
      return LoggedUserModel(
        id: '1',
        name: 'Admin',
        email: 'admin@email.com',
        token: userToken,
      );
    }
    // else {
    //   throw Exception('Token inválido');
    // }
  }
}
