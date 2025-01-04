
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
  
  @override
  Future<Either<Failure, bool>> registerWithEmailAndPassword({
    required String email,
    required String password,
    required String username,
  }) async {
    try {
      final success = await datasource.registerWithEmailAndPassword(
        email: email,
        password: password,
        username: username,
      );

      if (success) {
        return right(true);
      }

      return left(const Failure("Could not register"));
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, User>> confirmRegistration({
    required String email,
    required String verificationCode,
  }) async {
    try {
      final user = await datasource.confirmRegistration(
        email: email,
        verificationCode: verificationCode,
      );

      return right(user);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }

}