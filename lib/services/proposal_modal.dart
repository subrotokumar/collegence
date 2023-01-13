class ProposalModal {
  late BigInt id;
  late bool exist;
  late String description;
  late String deadline;
  late int voteUp;
  late int voteDown;
  late int maxVotes;
  late bool countConducted;
  late bool passed;

  ProposalModal({
    required this.id,
    required this.exist,
    required this.countConducted,
    required this.deadline,
    required this.description,
    required this.maxVotes,
    required this.passed,
    required this.voteDown,
    required this.voteUp,
  });

  factory ProposalModal.fromList(List<dynamic> list) {
    return ProposalModal(
      id: list[0],
      exist: list[1],
      description: list[2],
      deadline: list[3].toString(),
      voteUp: list[4].toInt(),
      voteDown: list[5].toInt(),
      maxVotes: list[6].toInt(),
      countConducted: list[7],
      passed: list[8],
    );
  }
}
