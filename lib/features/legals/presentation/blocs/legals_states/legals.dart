import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

@immutable
abstract class LegalsState extends Equatable {
  @override
  List<Object?> get props => [];
}

class LegalsInitial extends LegalsState {}
class LegalDocumentListInitial extends LegalsState {}
