import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taxi_app_flutter/dependencies.dart';
import 'package:taxi_app_flutter/features/booking/domain/usecases/retrieve_cities.dart';
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

  const BookingDetail({super.key});

  @override
  _BookingDetailState createState() => _BookingDetailState();
}

class _BookingDetailState extends State<BookingDetail> {
  MenuItem? selectedMenu;
  List<MenuItem> menuItems = [];
  List<MenuItem> filteredMenuItems = [];

  @override
  void initState() {
    super.initState();
    // Initialize menuItems and filteredMenuItems with the list of cities from your use case
    // For example:
    // cities = await retrieveCitiesUseCase.call(NoParams());
    // filteredCities = cities;
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
    return BlocProvider<BookingDetailBloc>(
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
              menuItems = state.message
                  .map((city) => MenuItem(state.message.indexOf(city), city, Icons.location_city))
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
                      hintText: "Select City",
                      requestFocusOnTap: true,
                      enableFilter: true,
                      label: const Text('Select City'),
                      onSelected: (MenuItem? menu) {
                        setState(() {
                          selectedMenu = menu;
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
                ],
              );
            } else if (state is BookingDetailStateFailure) {
              return Center(child: Text(state.message));
            }

            return const Center(child: Text("No Data Available"));
          },
        ),
      ),
    );
  }
}




/*import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taxi_app_flutter/dependencies.dart';
import 'package:taxi_app_flutter/features/booking/domain/usecases/retrieve_cities.dart';

import 'package:taxi_app_flutter/features/booking/presentation/bloc/booking_detail/booking_detail_block.dart';
import '../bloc/booking_detail/booking_detail_event.dart';
import '../bloc/booking_detail/booking_detail_state.dart';

class BookingDetail extends StatelessWidget {
  static String route() => "/booking_detail";

  const BookingDetail({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<BookingDetailBloc>(
      create: (context) => serviceLocator<BookingDetailBloc>()..add(FetchBookingDetailsEvent()),
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Booking Detail"),
        ),
        body: BlocBuilder<BookingDetailBloc, BookingDetailState>(
          builder: (context, state) { 
            if (state is BookingDetailLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is BookingDetailSuccess) {
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
                  ...state.message.map(
                    (city) => ListTile(
                      title: Text(city),
                      onTap: () {
                        // Обработка выбора города
                      },
                    ),
                  ),
                ],
              );
            } else if (state is BookingDetailFailure) {
              return Center(child: Text(state.message));
            }

            return const Center(child: Text("No Data Available"));
          },
        ),
      ),
    );
  }
}
*/