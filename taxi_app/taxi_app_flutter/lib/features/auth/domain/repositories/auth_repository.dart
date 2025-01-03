import 'package:fpdart/fpdart.dart';
import 'package:taxi_app_flutter/core/entities/user.dart';
import 'package:taxi_app_flutter/core/error/failure.dart';

abstract interface class AuthRepository {
  Future<Either<Failure, User>> loginWithEmailPassword({required String email, required String password});
}