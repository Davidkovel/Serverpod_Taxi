import 'package:fpdart/fpdart.dart';
import 'package:taxi_app_client/taxi_app_client.dart';
import 'package:taxi_app_flutter/core/error/failure.dart';
import 'package:taxi_app_flutter/core/usecases/usecase.dart';
import 'package:taxi_app_flutter/features/booking/domain/repositories/book_repository.dart';
import 'package:taxi_app_flutter/features/booking/domain/usecases/create_order.dart';

class ListAvailableOrdersUseCase implements Usecase<List<Orders>, NoParams>{
  final BookRepository bookRepository;

  ListAvailableOrdersUseCase(this.bookRepository);

  @override
  Future<Either<Failure, List<Orders>>> call(NoParams params) async {
    try {
      return Right(await bookRepository.listOrders());
    } catch (error) {
      return Left(Failure("Failed to create order $error"));
    }
  } 

}