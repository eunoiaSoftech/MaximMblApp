import 'branch.dart';

class BranchListEvent extends BranchEvent {
  final int userId;

  BranchListEvent(this.userId);

  @override
  List<Object?> get props => [userId];
}
