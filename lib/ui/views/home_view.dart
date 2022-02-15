import 'package:flutter/material.dart';
import 'package:finances/viewmodels/home_model.dart';
import 'package:finances/ui/views/base_view.dart';
import 'package:finances/ui/widgets/app_bar.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseView<HomeModel>(
      builder: (context, model, child) => Scaffold(
        appBar: MyAppBar.getAppBar('Home', false),
        body: const SafeArea(
          child: Text('Hi'),
        ),
      ),
    );
  }
}
