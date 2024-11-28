import 'package:flutter/material.dart';
import 'package:jauhari_dashbord/base_layout.dart';
import 'package:jauhari_dashbord/responsive/common_builder.dart';


class Dummy extends StatelessWidget {
  const Dummy({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseLayout(content: ResponsiveLayout(deskTopView: Container(height: 50,width: 50,color: Colors.red,), ));
  }
}
