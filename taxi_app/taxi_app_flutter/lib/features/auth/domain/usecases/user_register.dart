import 'package:fpdart/fpdart.dart';
import 'package:taxi_app_flutter/core/error/failure.dart';
import 'package:taxi_app_flutter/features/auth/domain/repositories/auth_repository.dart';
import 'package:taxi_app_flutter/core/usecases/usecase.dart';

class UserRegisterUseCase implements Usecase<bool, UserRegisterParams> {
  final AuthRepository authRepository;

  const UserRegisterUseCase(this.authRepository);

  @override
  Future<Either<Failure, bool>> call(UserRegisterParams params) async {
    return await authRepository.registerWithEmailAndPassword(
      email: params.email,
      password: params.password,
      username: params.username,
    );
  }
}

class UserRegisterParams {
  final String email;
  final String password;
  final String username;

  const UserRegisterParams({
    required this.email,
    required this.password,
    required this.username,
  });
}