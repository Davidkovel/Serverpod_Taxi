import 'package:fpdart/fpdart.dart';
import 'package:taxi_app_flutter/core/entities/user.dart';
import 'package:taxi_app_flutter/core/error/failure.dart';

abstract interface class AuthRepository {
  Future<Either<Failure, User>> loginWithEmailPassword({required String email, required String password});
  
  Future<Either<Failure, bool>> registerWithEmailAndPassword({required String email, required String password, required String username});

  Future<Either<Failure, User>> confirmRegistration({required String email, required String verificationCode});

}