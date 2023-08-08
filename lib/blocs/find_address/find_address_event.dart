part of 'find_address_bloc.dart';

abstract class FindAddressEvent extends Equatable {
  const FindAddressEvent();

  @override
  List<Object> get props => [];
}

class MarkAddress extends FindAddressEvent {
  final LatLng latlng;

  const MarkAddress(this.latlng);
}

class SearchAddress extends FindAddressEvent {
  final String placeName;

  const SearchAddress(this.placeName);
}
