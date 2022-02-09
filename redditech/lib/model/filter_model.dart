import 'package:flutter/material.dart';

class Filter {
  final int id;
  final String title;
  final IconData iconData;

  Filter(this.id, this.title, this.iconData);
}

List<Filter> filterList = [
  Filter(0, 'hot', Icons.local_fire_department),
  Filter(1, 'best', Icons.new_releases),
  Filter(2, 'top', Icons.flash_on),
  Filter(3, 'new', Icons.assistant),
  Filter(4, 'controversial', Icons.outbond_outlined),
];
