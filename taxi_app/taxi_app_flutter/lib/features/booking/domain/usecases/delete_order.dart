import 'package:fpdart/src/either.dart';
import 'package:taxi_app_flutter/core/error/failure.dart';
import 'package:taxi_app_flutter/core/usecases/usecase.dart';
import 'package:taxi_app_flutter/features/booking/domain/repositories/book_repository.dart';

class DeleteOrderUseCase implements Usecase<void, DeleteOrderParams> {
  final BookRepository bookRepository;

  DeleteOrderUseCase(this.bookRepository);

  @override
  Future<Either<Failure, void>> call(DeleteOrderParams params) async {
    try {
      await bookRepository.deleteOrder(params.id);
      return right(null);
    } catch (error) {
      return Left(Failure("Failed to delete order $error"));
    }
  }
}

class DeleteOrderParams {
  final int id;

  DeleteOrderParams(this.id);
}