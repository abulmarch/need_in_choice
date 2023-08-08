part of 'find_address_bloc.dart';

abstract class FindAddressState extends Equatable {
  const FindAddressState();

  @override
  List<Object> get props => [];
}

class FindAddressInitial extends FindAddressState {}

class AddressLoaded extends FindAddressState {
  final LatLng latLng;
 final  String address;

  const AddressLoaded({required this.latLng, required this.address});
  @override
  List<Object> get props => [latLng , address];
}
