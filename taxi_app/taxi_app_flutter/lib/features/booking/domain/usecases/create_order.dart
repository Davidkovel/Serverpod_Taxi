import 'package:fpdart/fpdart.dart';
import 'package:taxi_app_client/taxi_app_client.dart';
import 'package:taxi_app_flutter/core/error/failure.dart';
import 'package:taxi_app_flutter/core/usecases/usecase.dart';
import 'package:taxi_app_flutter/features/booking/domain/repositories/book_repository.dart';

class CreateOrderUseCase implements Usecase<void, OrderCreateParams> {
  final BookRepository bookRepository;

  CreateOrderUseCase(this.bookRepository);

  @override
  Future<Either<Failure, void>> call(OrderCreateParams params) async {
    try {
      await bookRepository.createOrder(params.order);
      return right(null);
    } catch (error) {
      return Left(Failure("Failed to create order $error"));
    }
  }
}

class OrderCreateParams {
  final Orders order;

  OrderCreateParams(this.order);
}