/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: implementation_imports
// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: public_member_api_docs
// ignore_for_file: type_literal_in_constant_pattern
// ignore_for_file: use_super_parameters

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:serverpod/serverpod.dart' as _i1;

abstract class Orders implements _i1.TableRow, _i1.ProtocolSerialization {
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

  static final t = OrdersTable();

  static const db = OrdersRepository._();

  @override
  int? id;

  int passengerId;

  String fromAddress;

  String toAddress;

  String status;

  int price;

  @override
  _i1.Table get table => t;

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
  Map<String, dynamic> toJsonForProtocol() {
    return {
      if (id != null) 'id': id,
      'passengerId': passengerId,
      'fromAddress': fromAddress,
      'toAddress': toAddress,
      'status': status,
      'price': price,
    };
  }

  static OrdersInclude include() {
    return OrdersInclude._();
  }

  static OrdersIncludeList includeList({
    _i1.WhereExpressionBuilder<OrdersTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<OrdersTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<OrdersTable>? orderByList,
    OrdersInclude? include,
  }) {
    return OrdersIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Orders.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(Orders.t),
      include: include,
    );
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

class OrdersTable extends _i1.Table {
  OrdersTable({super.tableRelation}) : super(tableName: 'orders') {
    passengerId = _i1.ColumnInt(
      'passengerId',
      this,
    );
    fromAddress = _i1.ColumnString(
      'fromAddress',
      this,
    );
    toAddress = _i1.ColumnString(
      'toAddress',
      this,
    );
    status = _i1.ColumnString(
      'status',
      this,
    );
    price = _i1.ColumnInt(
      'price',
      this,
    );
  }

  late final _i1.ColumnInt passengerId;

  late final _i1.ColumnString fromAddress;

  late final _i1.ColumnString toAddress;

  late final _i1.ColumnString status;

  late final _i1.ColumnInt price;

  @override
  List<_i1.Column> get columns => [
        id,
        passengerId,
        fromAddress,
        toAddress,
        status,
        price,
      ];
}

class OrdersInclude extends _i1.IncludeObject {
  OrdersInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table get table => Orders.t;
}

class OrdersIncludeList extends _i1.IncludeList {
  OrdersIncludeList._({
    _i1.WhereExpressionBuilder<OrdersTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(Orders.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table get table => Orders.t;
}

class OrdersRepository {
  const OrdersRepository._();

  Future<List<Orders>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<OrdersTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<OrdersTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<OrdersTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.find<Orders>(
      where: where?.call(Orders.t),
      orderBy: orderBy?.call(Orders.t),
      orderByList: orderByList?.call(Orders.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
    );
  }

  Future<Orders?> findFirstRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<OrdersTable>? where,
    int? offset,
    _i1.OrderByBuilder<OrdersTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<OrdersTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.findFirstRow<Orders>(
      where: where?.call(Orders.t),
      orderBy: orderBy?.call(Orders.t),
      orderByList: orderByList?.call(Orders.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
    );
  }

  Future<Orders?> findById(
    _i1.Session session,
    int id, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.findById<Orders>(
      id,
      transaction: transaction,
    );
  }

  Future<List<Orders>> insert(
    _i1.Session session,
    List<Orders> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insert<Orders>(
      rows,
      transaction: transaction,
    );
  }

  Future<Orders> insertRow(
    _i1.Session session,
    Orders row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<Orders>(
      row,
      transaction: transaction,
    );
  }

  Future<List<Orders>> update(
    _i1.Session session,
    List<Orders> rows, {
    _i1.ColumnSelections<OrdersTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<Orders>(
      rows,
      columns: columns?.call(Orders.t),
      transaction: transaction,
    );
  }

  Future<Orders> updateRow(
    _i1.Session session,
    Orders row, {
    _i1.ColumnSelections<OrdersTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<Orders>(
      row,
      columns: columns?.call(Orders.t),
      transaction: transaction,
    );
  }

  Future<List<Orders>> delete(
    _i1.Session session,
    List<Orders> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<Orders>(
      rows,
      transaction: transaction,
    );
  }

  Future<Orders> deleteRow(
    _i1.Session session,
    Orders row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<Orders>(
      row,
      transaction: transaction,
    );
  }

  Future<List<Orders>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<OrdersTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<Orders>(
      where: where(Orders.t),
      transaction: transaction,
    );
  }

  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<OrdersTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<Orders>(
      where: where?.call(Orders.t),
      limit: limit,
      transaction: transaction,
    );
  }
}
