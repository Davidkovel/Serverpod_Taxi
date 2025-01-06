import 'package:taxi_app_client/taxi_app_client.dart';

abstract interface class BookDatasource {
  Future<void> createOrder(Orders orders);
}

class BookDatasourceImpl implements BookDatasource {
  final Client client;

  BookDatasourceImpl(this.client);

  @override
  Future<void> createOrder(Orders orders) async {
    try {
      await client.orders.createOrder(orders);      
    } catch(e) {
      throw Exception();
    }
  }
}