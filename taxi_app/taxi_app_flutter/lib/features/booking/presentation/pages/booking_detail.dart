import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:taxi_app_flutter/core/router/app_router.dart';
import 'package:taxi_app_flutter/core/utils/show_snackbar.dart';
import 'package:taxi_app_flutter/dependencies.dart';
import 'package:taxi_app_flutter/features/booking/domain/usecases/retrieve_cities.dart';
import 'package:taxi_app_flutter/features/booking/domain/usecases/calculating_price.dart';
import 'package:taxi_app_flutter/features/booking/presentation/bloc/booking_detail/booking_detail_block.dart';
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
    // Initialize menuItems and filteredMenuItems with the list of cities from your use case
    // For example:
    // cities = await retrieveCitiesUseCase.call(NoParams());
    // filteredCities = cities;
  }

  @override
  void dispose() {
    super.dispose();
  }

  void showBookingDialog(BuildContext context, double totalPrice) {
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
                Navigator.of(context).pop();
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
          .where((menuItem) => menuItem.label.toLowerCase().contains(query.toLowerCase()))
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
            } 
            else if (state is BookingDetailStateInitial){
              return const Scaffold(body: SizedBox());
            }
            else if (state is BookingDetailStateSuccess) {
              return Scaffold(
                appBar: AppBar(
                  title: const Text("Booking Detail"),
                ),
                body: BlocBuilder<BookingDetailBloc, BookingDetailState>(
                  builder: (context, state) {
                    if (state is BookingDetailStateLoading) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (state is BookingDetailStateSuccess) {
                      // Convert city names to MenuItem objects
                      menuItems = state.cities!
                          .map((city) => MenuItem(state.cities!.indexOf(city), city, Icons.location_city))
                          .toList();
                      filteredMenuItems = menuItems;

                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Padding(
                            padding: EdgeInsets.all(16.0),
                            child: Text(
                              "Select City:",
                              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: TextField(
                              decoration: InputDecoration(
                                labelText: 'Search City',
                                border: OutlineInputBorder(),
                              ),
                              onChanged: filterMenuItems,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(16.0),
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
                              dropdownMenuEntries: filteredMenuItems.map<DropdownMenuEntry<MenuItem>>((MenuItem menu) {
                                return DropdownMenuEntry<MenuItem>(
                                  value: menu,
                                  label: menu.label,
                                  leadingIcon: Icon(menu.icon),
                                );
                              }).toList(),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(16.0),
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
                              dropdownMenuEntries: filteredMenuItems.map<DropdownMenuEntry<MenuItem>>((MenuItem menu) {
                                return DropdownMenuEntry<MenuItem>(
                                  value: menu,
                                  label: menu.label,
                                  leadingIcon: Icon(menu.icon),
                                );
                              }).toList(),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(16),
                            child: ElevatedButton(
                              onPressed: () {
                                print(user_choice_cities);
                              },
                              child: const Text('Book Taxi'),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: ElevatedButton(
                              onPressed: () async{
                                context.read<BookingDetailBloc>().add(CalculatePriceEvent(user_choice_cities));
                              },
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

            print(state);
            return const Center(child: Text("No Data Available"));
          },
        );
      }
  }


/*
 /**/


// ---

*/


 /*return BlocProvider<BookingDetailBloc>(
      create: (context) => serviceLocator<BookingDetailBloc>()..add(FetchBookingDetailsEvent()),
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Booking Detail"),
        ),
        body: BlocBuilder<BookingDetailBloc, BookingDetailState>(
          builder: (context, state) {
            if (state is BookingDetailStateLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is BookingDetailStateSuccess) {
              // Convert city names to MenuItem objects
              menuItems = state.cities!
                  .map((city) => MenuItem(state.cities!.indexOf(city), city, Icons.location_city))
                  .toList();
              filteredMenuItems = menuItems;

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Text(
                      "Select City:",
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: TextField(
                      decoration: InputDecoration(
                        labelText: 'Search City',
                        border: OutlineInputBorder(),
                      ),
                      onChanged: filterMenuItems,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
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
                      dropdownMenuEntries: filteredMenuItems.map<DropdownMenuEntry<MenuItem>>((MenuItem menu) {
                        return DropdownMenuEntry<MenuItem>(
                          value: menu,
                          label: menu.label,
                          leadingIcon: Icon(menu.icon),
                        );
                      }).toList(),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
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
                      dropdownMenuEntries: filteredMenuItems.map<DropdownMenuEntry<MenuItem>>((MenuItem menu) {
                        return DropdownMenuEntry<MenuItem>(
                          value: menu,
                          label: menu.label,
                          leadingIcon: Icon(menu.icon),
                        );
                      }).toList(),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(16),
                    child: ElevatedButton(
                      onPressed: () {
                        // Обработка выбора города
                        print(user_choice_cities);
                      },
                      child: const Text('Book Taxi'),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: ElevatedButton(
                      onPressed: () async{
                        await calculatePrice();
                      },
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
      ),
    );*/