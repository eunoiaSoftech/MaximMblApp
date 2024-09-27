import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logistics_app/core/res/app_loader.dart';
import 'package:logistics_app/features/branches_n_locations/presentation/bloc/branch_bloc.dart';
import 'package:logistics_app/features/branches_n_locations/presentation/bloc/branch_events/branch_events.dart';
import 'package:logistics_app/features/branches_n_locations/presentation/bloc/branch_states/branch_states.dart';
import 'package:logistics_app/features/branches_n_locations/presentation/bloc/location_list_bloc.dart';

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
                shrinkWrap: true,
                itemCount: state.resp.data1?.length,
                itemBuilder: (context, int i) => ListTile(
                      onTap: () {
                        Navigator.of(context, rootNavigator: true).pop([
                          true,
                          state.resp.data1?[i].iBrnchmMstId,
                          state.resp.data1?[i].branchName
                        ]);
                        context.read<LocationListBloc>().generateLocationList(
                            widget.userId,
                            state.resp.data1?[i].iBrnchmMstId ?? 0);
                      },
                      title: Text(state.resp.data1?[i].branchName ?? "",
                          style: const TextStyle(color: Colors.black)),
                    ));
          }
          return const Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: EdgeInsets.all(20),
                child: Center(child: AppLoader()),
              ),
            ],
          );
        },
        listener: (context, state) {});
  }
}
