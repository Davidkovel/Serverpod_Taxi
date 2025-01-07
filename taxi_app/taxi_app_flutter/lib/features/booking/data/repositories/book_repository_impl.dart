import 'package:taxi_app_client/src/protocol/orders_model.dart';
import 'package:taxi_app_flutter/core/error/exceptions.dart';
import 'package:taxi_app_flutter/features/booking/data/datasources/book_datasource.dart';
import 'package:taxi_app_flutter/features/booking/domain/repositories/book_repository.dart';

class BookRepositoryImpl implements BookRepository {
  final BookDatasource bookDatasource;

  BookRepositoryImpl(this.bookDatasource);
  
  @override
  Future<void> createOrder(Orders orders) async {
    try {
      await bookDatasource.createOrder(orders);
    } catch(ex) {
      throw Exception(ex.toString());
    }
  }
  
  @override
  Future<List<Orders>> listOrders() async {
    try {
      return await bookDatasource.listOrders();
    }catch (ex) {
      throw ServerException(ex.toString());
    }
  }
  
  @override
  Future<void> deleteOrder(int orderId) async {
    try {
      await bookDatasource.deleteOrder(orderId);
    } catch (ex) {
      throw ServerException(ex.toString());
    }
  }
}