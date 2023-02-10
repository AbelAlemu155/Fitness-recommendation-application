import 'package:equatable/equatable.dart';

class UdEvent extends Equatable {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class UdLoadEvent extends UdEvent {
  String email;
  UdLoadEvent({required this.email});
}

class FoodFromList extends UdEvent {
  List<int> ids;
  int index;
  FoodFromList({required this.ids,required this.index});
}
