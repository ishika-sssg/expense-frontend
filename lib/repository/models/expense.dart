class Expense {
  String expenseName;
  String description;
  double amount;
  int paidBy;
  List<int> members;
  String group_id;

  Expense({
    required this.expenseName,
    required this.description,
    required this.amount,
    required this.paidBy,
    required this.members,
    required this.group_id,
  });
  // @override
  // String toString() {
  //   return 'Expense(expenseName: $expenseName, description: $description, amount: $amount, paidBy: $paidBy, members: $members, group_id :$group_id)';
  // }
  Map<String, dynamic> toJson() {
    return {
      'expenseName': expenseName,
      'description': description,
      'amount': amount,
      'paidBy': paidBy,
      'members': members,
      'group_id': group_id,
    };
  }
}
