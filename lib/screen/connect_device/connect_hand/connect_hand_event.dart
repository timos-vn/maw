import 'package:equatable/equatable.dart';
import 'package:maw/models/models/core_water.dart';

abstract class ConnectHandEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class GetPrefs extends ConnectHandEvent {
  @override
  String toString() => 'GetPrefs';
}

class AddOrRemoveCoreWater extends ConnectHandEvent {

  final bool? type;
  final DataCoreWater item;
  final int? index;

  AddOrRemoveCoreWater({this.type,required this.item,this.index});

  @override
  String toString() => 'AddOrRemoveCoreWater{item:$item}';
}