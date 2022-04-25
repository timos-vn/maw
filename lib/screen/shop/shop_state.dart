import 'package:equatable/equatable.dart';

abstract class ShopState extends Equatable {
  @override
  List<Object> get props => [];
}
class InitialShopState extends ShopState {

  @override
  String toString() {
    return 'InitialShopState{}';
  }
}

class GetPrefsSuccess extends ShopState{

  @override
  String toString() {
    return 'GetPrefsSuccess{}';
  }
}