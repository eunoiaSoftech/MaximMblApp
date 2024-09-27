import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logistics_app/core/res/app_loader.dart';
import 'package:logistics_app/core/shared/bloc/ui_state.dart';
import 'package:logistics_app/features/branches_n_locations/presentation/bloc/location_list_bloc.dart';

class LocationListBottomSheetWidget extends StatefulWidget {
  const LocationListBottomSheetWidget(
      {super.key, required this.userId, required this.branchId});

  final int userId;
  final int branchId;

  @override
  State<LocationListBottomSheetWidget> createState() =>
      _LocationListBottomSheetWidgetState();
}

class _LocationListBottomSheetWidgetState
    extends State<LocationListBottomSheetWidget> {
  void _callApi() {
    context
        .read<LocationListBloc>()
        .generateLocationList(widget.branchId, widget.userId);
  }

  @override
  void initState() {
    super.initState();
    _callApi();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer(
        bloc: context.read<LocationListBloc>(),
        builder: (context, state) {
          if (state is Success &&
              context.read<LocationListBloc>().state.getData()?.statusCode ==
                  0) {
            final respData = context.read<LocationListBloc>().state.getData();
            return ListView.builder(
                shrinkWrap: true,
                itemCount: respData?.data1?.length,
                itemBuilder: (context, int i) => ListTile(
                      onTap: () {
                        Navigator.of(context, rootNavigator: true).pop([
                          true,
                          respData?.data1?[i].iPKCustEnum,
                          respData?.data1?[i].sName
                        ]);
                      },
                      title: Text(respData?.data1?[i].sName ?? "",
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
