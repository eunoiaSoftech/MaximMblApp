import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_storage/get_storage.dart';
import 'package:logistics_app/app.dart';
import 'package:logistics_app/core/shared/data/base_api.dart';
import 'package:logistics_app/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:logistics_app/features/auth/data/repositories/auth_repos.dart';
import 'package:logistics_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:logistics_app/features/branches/data/repositories/branch_repos.dart';

import 'features/branches/data/datasources/branch_remote_datasource.dart';
import 'features/branches/presentation/bloc/branch_bloc.dart';

void main() async {
  await GetStorage.init();
  final authRemoteDataSource = AuthRemoteDataSource(BaseApi(Dio()));
  final branchRemoteDataSource = BranchRemoteDataSource(BaseApi(Dio()));

  final authRepository = AuthRepository(authRemoteDataSource);
  final branchRepository = BranchRepository(branchRemoteDataSource);

  runApp(MultiBlocProvider(
    providers: [
      BlocProvider<BranchBloc>(
        create: (context) => BranchBloc(branchRepository),
      ),
      BlocProvider(create: (context) => AuthBloc(authRepository)),
    ],
    child: const MyApp(),
  ));
}
