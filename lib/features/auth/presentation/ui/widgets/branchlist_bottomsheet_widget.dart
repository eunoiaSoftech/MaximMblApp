import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logistics_app/core/res/app_loader.dart';
import 'package:logistics_app/features/branches/presentation/bloc/branch_bloc.dart';
import 'package:logistics_app/features/branches/presentation/bloc/branch_events/branch_events.dart';
import 'package:logistics_app/features/branches/presentation/bloc/branch_states/branch_states.dart';

class BranchListBottomSheetWidget extends StatefulWidget {
  const BranchListBottomSheetWidget({super.key, required this.userId});

  final int userId;

  @override
  State<BranchListBottomSheetWidget> createState() =>
      _BranchListBottomSheetWidgetState();
}

class _BranchListBottomSheetWidgetState
    extends State<BranchListBottomSheetWidget> {
  void _callApi() {
    context.read<BranchBloc>().add(BranchListEvent(widget.userId));
  }

  @override
  void initState() {
    super.initState();
    _callApi();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer(
        bloc: context.read<BranchBloc>(),
        builder: (context, state) {
          if (state is BranchListLoaded) {
            return ListView.builder(
                itemCount: state.resp.data1?.length,
                itemBuilder: (context, int i) => ListTile(
                      title: Text(state.resp.data1?[i].branchName ?? "",
                          style: const TextStyle(color: Colors.black)),
                    ));
          }
          return const Padding(
            padding: EdgeInsets.all(20),
            child: Center(child: AppLoader()),
          );
        },
        listener: (context, state) {});
  }
}
