import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:taxi_app_client/taxi_app_client.dart';
import 'package:taxi_app_flutter/core/entities/user.dart';
import 'package:taxi_app_flutter/core/router/app_router.dart';
import 'package:taxi_app_flutter/core/utils/show_snackbar.dart';
import 'package:taxi_app_flutter/core/widgets/style.dart';
import 'package:taxi_app_flutter/features/booking/presentation/bloc/booking_detail/booking_detail_block.dart';
import 'package:taxi_app_flutter/features/booking/presentation/pages/booking_button.dart';
import '../bloc/booking_detail/booking_detail_event.dart';
import '../bloc/booking_detail/booking_detail_state.dart';

class MenuItem {
  final int id;
  final String label;
  final IconData icon;

  MenuItem(this.id, this.label, this.icon);
}

class BookingDetail extends StatefulWidget {
  static String route() => "/booking_detail";

  BookingDetail({super.key});

  @override
  _BookingDetailState createState() => _BookingDetailState();
}

class _BookingDetailState extends State<BookingDetail> {
  Map<String, String> user_choice_cities = {"From": "None", "To": "None"};
  MenuItem? selectedMenu;
  MenuItem? selectedMenu2;
  List<MenuItem> menuItems = [];
  List<MenuItem> filteredMenuItems = [];
  double? calculatedPrice;

  @override
  void initState() {
    super.initState();
    BlocProvider.of<BookingDetailBloc>(context).add(FetchBookingDetailsEvent());
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<int?> getUserId() async {
    return get_user_id();
  }

  void showBookingDialog(BuildContext context, double totalPrice) async {
    var userId = await getUserId();
    final order = Orders(
      passengerId: userId!,
      fromAddress: user_choice_cities["From"]!,
      toAddress: user_choice_cities["To"]!,
      status: 'Pending',
      price: totalPrice.toInt(),
    );

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirm Booking'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('From: ${user_choice_cities["From"]}'),
              Text('To: ${user_choice_cities["To"]}'),
              const SizedBox(height: 16),
              Text('Cost: \$${totalPrice.toStringAsFixed(2)}'),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                context.read<BookingDetailBloc>().add(CreateOrderEvent(order));
                context.go(BookingButton.route());

                print('Booking confirmed');
              },
              child: const Text('Confirm'),
            ),
          ],
        );
      },
    );
  }

  void filterMenuItems(String query) {
    setState(() {
      filteredMenuItems = menuItems
          .where((menuItem) =>
              menuItem.label.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<BookingDetailBloc, BookingDetailState>(
      listener: (context, state) {
        if (state is BookingDetailStateFailure) {
          showSnackbar(context, state.message);
        }

        if (state is CalculatePriceStateSuccess) {
          showBookingDialog(context, state.price);

          context.read<BookingDetailBloc>().add(FetchBookingDetailsEvent());
        }
      },
      builder: (context, state) {
        if (state is BookingDetailStateLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is BookingDetailStateInitial) {
          return const Scaffold(body: SizedBox());
        } else if (state is BookingDetailStateSuccess) {
          return Scaffold(
            appBar: AppBar(
              title: const Text("Booking Detail"),
              leading: IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () {
                  context.go(BookingButton.route());
                },
              ),
            ),
            body: BlocBuilder<BookingDetailBloc, BookingDetailState>(
              builder: (context, state) {
                if (state is BookingDetailStateLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is BookingDetailStateSuccess) {
                  // Convert city names to MenuItem objects
                  menuItems = state.cities!
                      .map((city) => MenuItem(state.cities!.indexOf(city), city,
                          Icons.location_city))
                      .toList();
                  filteredMenuItems = menuItems;

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Заголовок
                      Padding(
                        padding:
                            EdgeInsets.only(left: 12, top: 12, bottom: 9.0),
                        child: Text(
                          "Select City:",
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: blueGrey),
                        ),
                      ),
                      // Выбор города "From"
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Card(
                          elevation: 5,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12)),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: DropdownMenu<MenuItem>(
                              initialSelection: selectedMenu,
                              width: MediaQuery.of(context).size.width * 0.8,
                              hintText: "Select From City",
                              requestFocusOnTap: true,
                              enableFilter: true,
                              label: const Text('Select From City'),
                              onSelected: (MenuItem? menu) {
                                setState(() {
                                  selectedMenu = menu;
                                  user_choice_cities["From"] = menu!.label;
                                });
                              },
                              dropdownMenuEntries: filteredMenuItems
                                  .map<DropdownMenuEntry<MenuItem>>(
                                      (MenuItem menu) {
                                return DropdownMenuEntry<MenuItem>(
                                  value: menu,
                                  label: menu.label,
                                  leadingIcon:
                                      Icon(menu.icon, color: blue),
                                );
                              }).toList(),
                            ),
                          ),
                        ),
                      ),
                      // Разделитель
                      Divider(
                        color: blueGrey,
                        height: 2,
                        indent: 16,
                        endIndent: 16,
                      ),
                      // Выбор города "To"
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Card(
                          elevation: 5,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12)),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: DropdownMenu<MenuItem>(
                              initialSelection: selectedMenu2,
                              width: MediaQuery.of(context).size.width * 0.8,
                              hintText: "Select To City",
                              requestFocusOnTap: true,
                              enableFilter: true,
                              label: const Text('Select To City'),
                              onSelected: (MenuItem? menu) {
                                setState(() {
                                  selectedMenu2 = menu;
                                  user_choice_cities["To"] = menu!.label;
                                });
                              },
                              dropdownMenuEntries: filteredMenuItems
                                  .map<DropdownMenuEntry<MenuItem>>(
                                      (MenuItem menu) {
                                return DropdownMenuEntry<MenuItem>(
                                  value: menu,
                                  label: menu.label,
                                  leadingIcon:
                                      Icon(menu.icon, color: blue),
                                );
                              }).toList(),
                            ),
                          ),
                        ),
                      ),
                      // Разделитель
                      Divider(
                        color: blueGrey,
                        height: 2,
                        indent: 16,
                        endIndent: 16,
                      ),
                      // Кнопка бронирования
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: ElevatedButton(
                          onPressed: () async {
                            context
                                .read<BookingDetailBloc>()
                                .add(CalculatePriceEvent(user_choice_cities));
                          },
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(
                                vertical: 16.0, horizontal: 24.0),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8)),
                            textStyle: const TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          child: const Text('Book Taxi'),
                        ),
                      ),
                    ],
                  );
                } else if (state is BookingDetailStateFailure) {
                  return Center(child: Text(state.message));
                }

                return const Center(child: Text("No Data Available"));
              },
            ),
          );
        } else if (state is BookingDetailStateFailure) {
          return Center(child: Text(state.message));
        }

        return const Center(child: Text("No Data Available"));
      },
    );
  }
}
