// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'register_bloc.dart';

abstract class RegisterEvent {}

class DoRegisterEvent extends RegisterEvent {
  final RegisterRequestModel model;
  DoRegisterEvent({
    required this.model,
  });
}
