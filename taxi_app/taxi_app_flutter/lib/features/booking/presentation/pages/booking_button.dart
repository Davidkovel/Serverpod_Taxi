import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:taxi_app_flutter/core/utils/show_snackbar.dart';
import 'package:taxi_app_flutter/features/booking/presentation/bloc/booking_manage.dart/booking_manage_bloc.dart';

import './booking_detail.dart';

class BookingButton extends StatefulWidget {
  static String route() => "/booking_button";

  const BookingButton({super.key});

  @override
  State<BookingButton> createState() => _BookingButtonState();
}

class _BookingButtonState extends State<BookingButton> {

  @override
  void initState() {
    super.initState();

    BlocProvider.of<BookingManageBloc>(context).add(FetchCurrentOrdersUserEvent());
  }

  @override
  void dispose() {
    super.dispose();
  }



  @override
  Widget build(BuildContext context) {
    return BlocConsumer<BookingManageBloc,BookingManageState>(
      listener: (context, state) {
        if (state is BookingManageStateFailure) {
          showSnackbar(context, state.message);
        }
        if (state is BookingManageStateDeleteSuccess)
        {
          context.read<BookingManageBloc>().add(FetchCurrentOrdersUserEvent());
        }
      },
      builder: (context, state) {

        if (state is BookingManageStateLoading) {
          return const Center(child: CircularProgressIndicator());
        } 
        else if (state is BookingManageStateInitial){
          return const Scaffold(body: SizedBox());
        }
        else if (state is BookingManageStateSuccess) {
          final orders = state.orders;
          if (orders.isEmpty) {
            return Scaffold(
              appBar: AppBar(
                title: const Text("The Taxi App"),
              ),
              body: Center(
                child: ElevatedButton(
                  onPressed: () {
                    context.go(BookingDetail.route());
                  },
                  child: const Text("No orders available. Book a taxi now!"),
                ),
              ),
            );
          } else {
            return Scaffold(
              appBar: AppBar(
                title: const Text("The Taxi App"),
              ),
              body: ListView.builder(
                itemCount: orders.length,
                itemBuilder: (context, index) {
                  final order = orders[index];
                  return Card(
                    child: ListTile(
                      title: Text("Trip to ${order.toAddress}"),
                      subtitle: Text("From ${order.fromAddress} to ${order.toAddress}. Price: \$${order.price}"),
                      trailing: IconButton(
                        icon: const Icon(Icons.delete, color: Colors.red),
                        onPressed: () {
                          // Confirm deletion
                          showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              title: const Text("Confirm Deletion"),
                              content: const Text("Are you sure you want to delete this order?"),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop(); // Close the dialog
                                  },
                                  child: const Text("Cancel"),
                                ),
                                TextButton(
                                  onPressed: () {
                                    // Call the method to delete the order
                                    context.read<BookingManageBloc>().add(DeleteOrderEvent(order.id!));
                                    Navigator.of(context).pop(); // Close the dialog
                                  },
                                  child: const Text("Delete", style: TextStyle(color: Colors.red)),
                                ),
                              ]
                            ),
                          );
                        }
                      ),
                    )
                  );
                },
              ),
            );
          }
        }

        return const Center(child: Text("No Data Available"));
      },
    );
  }
}

// ПЛАНИ: 1. Украшать главное меню, 2. Добавить api запрос + БД 3. Добавить карту

/*

Center(
              child: ElevatedButton(
                  onPressed: () {
                    context.go(BookingManage.route());
                  },
                  child: Text("Click To book Taxi")),
            ),
*/