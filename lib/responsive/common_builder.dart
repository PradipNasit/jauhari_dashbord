import 'package:flutter/material.dart';
import 'package:jauhari_dashbord/common/common_text_widget.dart';

class ResponsiveLayout  extends StatelessWidget {
  final Widget deskTopView;
  const ResponsiveLayout({super.key , required this.deskTopView ,});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (_, constraints) {
      if(constraints.maxWidth <= 1000){
        return SizedBox(
          child: CommonText(text: "please use in full Screen"),
        );
      }else {
        return deskTopView;
      }
    },);
  }
}
