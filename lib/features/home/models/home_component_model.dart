import 'package:flutter_svg/svg.dart';

class HomeComponent {
  HomeComponent({required this.title, required this.image, required this.moduleId});

  final String title;
  final SvgPicture image;
  final int moduleId;
}
