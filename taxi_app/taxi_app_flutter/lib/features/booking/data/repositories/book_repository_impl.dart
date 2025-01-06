import 'package:taxi_app_client/src/protocol/orders_model.dart';
import 'package:taxi_app_flutter/features/booking/data/datasources/book_datasource.dart';
import 'package:taxi_app_flutter/features/booking/domain/repositories/book_repository.dart';

class BookRepositoryImpl implements BookRepository {
  final BookDatasource bookDatasource;

  BookRepositoryImpl(this.bookDatasource);
  
  @override
  Future<void> createOrder(Orders orders) async {
    try {
      await bookDatasource.createOrder(orders);
    } catch(e) {
      throw Exception();
    }
  }
}