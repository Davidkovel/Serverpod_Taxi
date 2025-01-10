/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: implementation_imports
// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: public_member_api_docs
// ignore_for_file: type_literal_in_constant_pattern
// ignore_for_file: use_super_parameters

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:serverpod_client/serverpod_client.dart' as _i1;

abstract class Orders implements _i1.SerializableModel {
  Orders._({
    this.id,
    required this.passengerId,
    required this.fromAddress,
    required this.toAddress,
    required this.status,
    required this.price,
  });

  factory Orders({
    int? id,
    required int passengerId,
    required String fromAddress,
    required String toAddress,
    required String status,
    required int price,
  }) = _OrdersImpl;

  factory Orders.fromJson(Map<String, dynamic> jsonSerialization) {
    return Orders(
      id: jsonSerialization['id'] as int?,
      passengerId: jsonSerialization['passengerId'] as int,
      fromAddress: jsonSerialization['fromAddress'] as String,
      toAddress: jsonSerialization['toAddress'] as String,
      status: jsonSerialization['status'] as String,
      price: jsonSerialization['price'] as int,
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  int passengerId;

  String fromAddress;

  String toAddress;

  String status;

  int price;

  Orders copyWith({
    int? id,
    int? passengerId,
    String? fromAddress,
    String? toAddress,
    String? status,
    int? price,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'passengerId': passengerId,
      'fromAddress': fromAddress,
      'toAddress': toAddress,
      'status': status,
      'price': price,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _OrdersImpl extends Orders {
  _OrdersImpl({
    int? id,
    required int passengerId,
    required String fromAddress,
    required String toAddress,
    required String status,
    required int price,
  }) : super._(
          id: id,
          passengerId: passengerId,
          fromAddress: fromAddress,
          toAddress: toAddress,
          status: status,
          price: price,
        );

  @override
  Orders copyWith({
    Object? id = _Undefined,
    int? passengerId,
    String? fromAddress,
    String? toAddress,
    String? status,
    int? price,
  }) {
    return Orders(
      id: id is int? ? id : this.id,
      passengerId: passengerId ?? this.passengerId,
      fromAddress: fromAddress ?? this.fromAddress,
      toAddress: toAddress ?? this.toAddress,
      status: status ?? this.status,
      price: price ?? this.price,
    );
  }
}
