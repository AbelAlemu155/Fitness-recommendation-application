import 'package:flutter/material.dart';

import 'data.dart';

class BarData {
  static double interval = 1;

  static List<Data> barData = [
    Data(
      id: 0,
      name: 'Mon',
      color: Color(0xff19bfff),
    ),
    Data(
      name: 'Tue',
      id: 1,
      color: Color(0xffff4d94),
    ),
    Data(
      name: 'Wed',
      id: 2,
      color: Color(0xff2bdb90),
    ),
    Data(
      name: 'Thu',
      id: 3,
      color: Color(0xffffdd80),
    ),
    Data(
      name: 'Fri',
      id: 4,
      color: Color(0xff2bdb90),
    ),
    Data(
      name: 'Sat',
      id: 5,
      color: Color(0xffffdd80),
    ),
    Data(
      name: 'Sun',
      id: 6,
      color: Color(0xffff4d94),
    ),
  ];
}
