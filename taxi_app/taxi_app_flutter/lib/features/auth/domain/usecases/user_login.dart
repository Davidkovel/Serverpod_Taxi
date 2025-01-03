import 'package:fpdart/fpdart.dart';
import 'package:taxi_app_flutter/core/entities/user.dart';
import 'package:taxi_app_flutter/core/error/failure.dart';
import 'package:taxi_app_flutter/core/usecases/usecase.dart';
import 'package:taxi_app_flutter/features/auth/domain/repositories/auth_repository.dart';

class UserLoginUseCase implements Usecase<User, UserLoginParams> {
  final AuthRepository authRepository;

  const UserLoginUseCase(this.authRepository);

  @override
  Future<Either<Failure, User>> call(UserLoginParams params) async {
    return await authRepository.loginWithEmailPassword(email: params.email, password: params.password);
  }
}

class UserLoginParams {
  final String email;
  final String password;

  const UserLoginParams({
    required this.email,
    required this.password,
  });
}