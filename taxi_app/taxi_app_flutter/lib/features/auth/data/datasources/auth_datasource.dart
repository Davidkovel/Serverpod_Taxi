import 'package:serverpod_auth_shared_flutter/serverpod_auth_shared_flutter.dart';
import 'package:taxi_app_client/taxi_app_client.dart';
import 'package:taxi_app_flutter/core/entities/user.dart';
import 'package:taxi_app_flutter/core/error/exceptions.dart';
import 'package:taxi_app_flutter/features/auth/data/models/user_model.dart';

abstract interface class AuthDatasource {
  Future<User> loginWithEmailAndPassword({
    required String email,
    required String password,
  });
}

class AuthDatasourceImpl implements AuthDatasource {
  final Client client;
  final SessionManager sessionManager;

  AuthDatasourceImpl({
    required this.client,
    required this.sessionManager,
  });
  
  @override
  Future<UserModel> loginWithEmailAndPassword({required String email, required String password,})  async
  {
    try {
      final result = await client.modules.auth.email.authenticate(email, password);

      if (!result.success){
        throw ServerException(result.failReason?.toString() ?? 'Could not login');
      }

      if (result.userInfo == null) {
        throw ServerException('User not found');
      }

      if (result.userInfo!.email == null) {
        throw ServerException('Email not found');
      }

      if (result.keyId == null || result.key == null) {
        throw ServerException('Not key or keyid found');
      }
      await sessionManager.registerSignedInUser(result.userInfo!, result.keyId!, result.key!);
      
      return UserModel(id: result.userInfo!.id!, email: result.userInfo!.email!, username: result.userInfo!.userName!);
    } catch (e) {
      throw ServerException(e.toString());
    }
  }


}