import 'package:flutter/material.dart';

import '../widgets/custom_bottom_navigator.dart';
import '../widgets/heading_bar.dart';

class StarterPage extends StatelessWidget {

  const StarterPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomHeadingBar(title: 'Starter Page'),
      bottomNavigationBar: CustomBottomAppBar(),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraints.maxHeight),
                child: IntrinsicHeight(
                  child: Container(  //TODO: Boiler Plate would be used everywhere this will be the outer background
                      )
                  ),
                ),
            );
          },
        )
      ),
    );
  }
}
