import 'dart:async';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_storage/get_storage.dart';
import 'package:logistics_app/app.dart';
import 'package:logistics_app/core/shared/data/base_api.dart';
import 'package:logistics_app/features/approvals/data/datasources/approvals_remote_datasource.dart';
import 'package:logistics_app/features/approvals/data/repositories/approvals_repo.dart';
import 'package:logistics_app/features/approvals/presentation/blocs/approvals_bloc.dart';
import 'package:logistics_app/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:logistics_app/features/auth/data/repositories/auth_repos.dart';
import 'package:logistics_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:logistics_app/features/branches_n_locations/data/datasources/branch_remote_datasource.dart';
import 'package:logistics_app/features/branches_n_locations/data/repositories/branch_repos.dart';
import 'package:logistics_app/features/branches_n_locations/presentation/bloc/branch_bloc.dart';
import 'package:logistics_app/features/branches_n_locations/presentation/bloc/location_list_bloc.dart';
import 'package:logistics_app/features/daily_log/data/daily_log_bloc.dart';
import 'package:logistics_app/features/daily_log/data/daily_log_remote_datasource.dart';
import 'package:logistics_app/features/daily_log/data/daily_log_repository.dart';
import 'package:logistics_app/features/legals/data/datasources/home_remote_datasource.dart';
import 'package:logistics_app/features/legals/data/repositories/legals_repo.dart';
import 'package:logistics_app/features/legals/presentation/blocs/blocs/legal_document_list_bloc.dart';
import 'package:logistics_app/features/legals/presentation/blocs/legals_bloc.dart';

Future mainCommon() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  await Future.wait([
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]),
  ]);

  await GetStorage.init();
  final authRemoteDataSource = AuthRemoteDataSource(BaseApi(Dio()));
  final branchRemoteDataSource = BranchRemoteDataSource(BaseApi(Dio()));
  final legalRemoteDataSource = LegalsRemoteDataSource(BaseApi(Dio()));
  final approvalsRemoteDataSource = ApprovalsRemoteDataSource(BaseApi(Dio()));
  final dailyLogRemoteDataSource = DailyLogRemoteDataSource(BaseApi(Dio()));

  final authRepository = AuthRepository(authRemoteDataSource);
  final branchRepository = BranchRepository(branchRemoteDataSource);
  final legalRepository = LegalsRepository(legalRemoteDataSource);
  final approvalsRepository = ApprovalsRepository(approvalsRemoteDataSource);
  final dailyLogRepository = DailyLogRepository(dailyLogRemoteDataSource);

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => AuthBloc(authRepository)),
        BlocProvider(create: (context) => BranchBloc(branchRepository)),
        BlocProvider(create: (context) => LegalsBloc(legalRepository)),
        BlocProvider(
            create: (context) => LegalDocumentListBloc(legalRepository)),
        BlocProvider(create: (context) => ApprovalsBloc(approvalsRepository)),
        BlocProvider(create: (context) => LocationListBloc()),
        BlocProvider(create: (context) => DailyLogBloc(dailyLogRepository)),
      ],
      child: const MyApp(),
    ),
  );
}
