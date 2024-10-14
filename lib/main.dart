// import 'package:dio/dio.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:get_storage/get_storage.dart';
// import 'package:logistics_app/app.dart';
// import 'package:logistics_app/core/shared/data/base_api.dart';
// import 'package:logistics_app/features/approvals/data/datasources/approvals_remote_datasource.dart';
// import 'package:logistics_app/features/approvals/data/repositories/approvals_repo.dart';
// import 'package:logistics_app/features/approvals/presentation/blocs/approvals_bloc.dart';
// import 'package:logistics_app/features/auth/data/datasources/auth_remote_datasource.dart';
// import 'package:logistics_app/features/auth/data/repositories/auth_repos.dart';
// import 'package:logistics_app/features/auth/presentation/bloc/auth_bloc.dart';
// import 'package:logistics_app/features/branches/data/datasources/branch_remote_datasource.dart';
// import 'package:logistics_app/features/branches/data/repositories/branch_repos.dart';
// import 'package:logistics_app/features/branches/presentation/bloc/branch_bloc.dart';
// import 'package:logistics_app/features/legals/data/datasources/legal_remote_datasource.dart';
// import 'package:logistics_app/features/legals/data/repositories/legals_repo.dart';
// import 'package:logistics_app/features/legals/presentation/blocs/blocs/legal_document_list_bloc.dart';
// import 'package:logistics_app/features/legals/presentation/blocs/legals_bloc.dart';

// void main() async {
//   await GetStorage.init();
//   final authRemoteDataSource = AuthRemoteDataSource(BaseApi(Dio()));
//   final branchRemoteDataSource = BranchRemoteDataSource(BaseApi(Dio()));
//   final legalRemoteDataSource = LegalsRemoteDataSource(BaseApi(Dio()));
//   final approvalsRemoteDataSource = ApprovalsRemoteDataSource(BaseApi(Dio()));
//
//   final authRepository = AuthRepository(authRemoteDataSource);
//   final branchRepository = BranchRepository(branchRemoteDataSource);
//   final legalRepository = LegalsRepository(legalRemoteDataSource);
//   final approvalsRepository = ApprovalsRepository(approvalsRemoteDataSource);
//
//   runApp(MultiBlocProvider(
//     providers: [
//       BlocProvider(create: (context) => AuthBloc(authRepository)),
//       BlocProvider(create: (context) => BranchBloc(branchRepository)),
//       BlocProvider(create: (context) => LegalsBloc(legalRepository)),
//       BlocProvider(create: (context) => LegalDocumentListBloc(legalRepository)),
//       BlocProvider(create: (context) => ApprovalsBloc(approvalsRepository)),
//     ],
//     child: const MyApp(),
//   ));
// }


import 'package:logistics_app/core/services/build_config.dart';
import 'package:logistics_app/main_common.dart';

Future main() async {
  BuildConfig(
    buildVariant: BuildVariant.dev,

    apiBaseUrl: '47.247.181.6:8089',
  );
  await mainCommon();
}