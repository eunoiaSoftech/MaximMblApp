import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

@immutable
abstract class ApprovalsState extends Equatable {
  @override
  List<Object?> get props => [];
}

class ApprovalsInitial extends ApprovalsState {}
