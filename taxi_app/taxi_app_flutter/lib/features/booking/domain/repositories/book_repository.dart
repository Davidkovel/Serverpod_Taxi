import 'package:fpdart/fpdart.dart';

import 'package:taxi_app_client/src/protocol/orders_model.dart';
import 'package:taxi_app_flutter/core/error/failure.dart';

abstract interface class BookRepository {
  Future<void> createOrder(Orders orders);
}