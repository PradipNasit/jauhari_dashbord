import 'package:flutter/cupertino.dart';
import 'package:jauhari_dashbord/Helper/color_helper.dart';
import 'package:jauhari_dashbord/common/common_text_field.dart';
import 'package:jauhari_dashbord/common/common_text_widget.dart';

Widget commonColumnWidgets(
    {required String title,
    required BuildContext context,
    required String hintText,
    final String? Function(String?)? validator,
    final void Function(String)? onChanged,
    required  TextEditingController controller,
    int? maxCount}) {
  final width = MediaQuery.sizeOf(context).width;
  final height = MediaQuery.sizeOf(context).height;
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      CommonText(
        text: title,
        color: ColorHelper.brownColor,
      ),
      SizedBox(height: 6,),
      SizedBox(
          width: width / 4,
          child: CommonTextField(
            hintText: hintText,
            onChanged: onChanged,
            controller: controller,
            validator: validator,
          ))
    ],
  );
}
