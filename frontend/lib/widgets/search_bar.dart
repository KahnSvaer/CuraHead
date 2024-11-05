import 'package:flutter/material.dart';

import '../state_management/appstate.dart';

class SearchWidget extends StatelessWidget{
  final bool showLast;

  const SearchWidget({
    super.key,
    this.showLast = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: TextField(
        decoration: InputDecoration(
          hintText: 'Search Therapist',
          alignLabelWithHint: true,
          border: InputBorder.none,
          isDense: true,
          contentPadding:
          const EdgeInsets.symmetric(horizontal: 8, vertical: 7.5),
          suffixIcon: IconButton(
            icon: const Icon(Icons.search,
                color: Colors.grey), // Search icon as a button
            onPressed: () {
              AppState().selectedPageIndex = 1;
              AppState().toShowNavTrue();
            },
          ), // Search icon on the right
        ),
      ),
    );
  }
}
