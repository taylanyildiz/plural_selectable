import 'sub_branch_model.dart';

class BranchModel {
  BranchModel({
    this.name,
    this.subBranches,
  });

  String? name;
  List<SubBranchModel>? subBranches;
}
