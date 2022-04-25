import 'package:equatable/equatable.dart';

abstract class DetailDeviceEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class GetPrefs extends DetailDeviceEvent {
  @override
  String toString() => 'GetPrefs';
}

class IndexBanner extends DetailDeviceEvent{
  final int? indexBanner;

  IndexBanner({this.indexBanner});
  @override
  String toString() {
    return 'IndexBanner{indexBanner: $indexBanner}';
  }
}
