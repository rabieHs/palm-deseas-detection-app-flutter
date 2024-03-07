import 'package:flutter/widgets.dart';

double screenWidth(BuildContext context) => MediaQuery.of(context).size.width;
double screenHeight(BuildContext context) => MediaQuery.of(context).size.height;
double defaultPadding = 16;
const String photoGeneratorUrl =
    "https://api/dicebear.com/5.x/initials/png?seed=";
