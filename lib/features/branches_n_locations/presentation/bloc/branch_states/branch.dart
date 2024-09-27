import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

@immutable
abstract class BranchState extends Equatable {
  @override
  List<Object?> get props => [];
}

class BranchInitial extends BranchState {}
