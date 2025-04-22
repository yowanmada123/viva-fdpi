class Status {
  final String id;
  final String name;

  Status({required this.id, required this.name});

  static List<Status> get statusList => [
        Status(id: 'Aktif', name: 'Aktif'),
        Status(id: 'Non-aktif', name: 'Non-aktif'),
      ];
}