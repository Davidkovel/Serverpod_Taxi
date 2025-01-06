import 'package:serverpod/serverpod.dart';
import 'package:taxi_app_server/src/generated/protocol.dart';

class OrdersEndpoint extends Endpoint {

  Future<void> createOrder(Session session, Orders orders) async {
    var order = Orders(
      passengerId: orders.passengerId,
      fromAddress: orders.fromAddress,
      toAddress: orders.toAddress,
      status: orders.status,
      price: orders.price,
    );
    await Orders.db.insert(session, [order]);
  }

}