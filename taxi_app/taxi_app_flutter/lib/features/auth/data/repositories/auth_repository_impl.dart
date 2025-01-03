
import 'package:fpdart/fpdart.dart';
import 'package:taxi_app_flutter/core/error/exceptions.dart';
import 'package:taxi_app_flutter/features/auth/data/datasources/auth_datasource.dart';
import 'package:taxi_app_flutter/features/auth/domain/repositories/auth_repository.dart';
import 'package:taxi_app_flutter/core/error/failure.dart';
import 'package:taxi_app_flutter/core/entities/user.dart';

class AuthRepositoryImpl implements AuthRepository {
  
  final AuthDatasource datasource;

  const AuthRepositoryImpl(this.datasource);
  
  @override
  Future<Either<Failure, User>> loginWithEmailPassword({required String email, required String password}) async {
    try {
      final result = await datasource.loginWithEmailAndPassword(email: email, password: password);
      return Right(result);
    } on ServerException catch (e) {
      return Left(Failure(e.message));
    }
  }

}