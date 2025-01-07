import 'package:taxi_app_client/taxi_app_client.dart';
import 'package:taxi_app_flutter/core/error/exceptions.dart';

abstract interface class BookDatasource {
  Future<void> createOrder(Orders orders);
  Future<List<Orders>> listOrders();
  Future<void> deleteOrder(int orderId);
}

class BookDatasourceImpl implements BookDatasource {
  final Client client;

  BookDatasourceImpl(this.client);

  @override
  Future<void> createOrder(Orders orders) async {
    try {
      await client.orders.createOrder(orders);      
    } catch(ex) {
      throw ServerException(ex.toString());
    }
  }

  @override
  Future<List<Orders>> listOrders() async {
    try {
    
      final List<Orders> orders = await client.orders.listOrders();
      return orders ?? [];
    } catch (ex)
    {
      throw ServerException(ex.toString());
    }
  }
  
  @override
  Future<void> deleteOrder(int orderId) async {
    try {
      await client.orders.deleteOrder(orderId);
      
    } catch (ex) {
      throw ServerException(ex.toString());
    }
  }


}