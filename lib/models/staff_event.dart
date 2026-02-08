enum StaffEventType {
  shoeTie, // Head of School: Stumble/No Jump
  coachWhistle, // Coach: Double Speed
  librarianShush, // Librarian: Mute/Dim
  scienceSplat, // Science Teacher: Ink Splat
  deanGlare, // Dean: Slow Motion
  peDrill, // PE Staff: Super Jump
}

class StaffEvent {
  final StaffEventType type;
  final String title;
  final String message;
  final Duration duration;

  StaffEvent({
    required this.type,
    required this.title,
    required this.message,
    required this.duration,
  });

  static StaffEvent getEvent(StaffEventType type) {
    switch (type) {
      case StaffEventType.shoeTie:
        return StaffEvent(
          type: type,
          title: 'Head of School',
          message: 'Tie your shoes!',
          duration: const Duration(seconds: 2), // 1.5s stumble + buffer
        );
      case StaffEventType.coachWhistle:
        return StaffEvent(
          type: type,
          title: 'The Coach',
          message: 'HUSTLE!',
          duration: const Duration(seconds: 5),
        );
      case StaffEventType.librarianShush:
        return StaffEvent(
          type: type,
          title: 'The Librarian',
          message: 'Shhhhh!',
          duration: const Duration(seconds: 5),
        );
      case StaffEventType.scienceSplat:
        return StaffEvent(
          type: type,
          title: 'Science Teacher',
          message: 'Whoopsie!',
          duration: const Duration(seconds: 3),
        );
      case StaffEventType.deanGlare:
        return StaffEvent(
          type: type,
          title: 'Dean of Students',
          message: 'Detention!',
          duration: const Duration(seconds: 5),
        );
      case StaffEventType.peDrill:
        return StaffEvent(
          type: type,
          title: 'PE Staff',
          message: 'Drill Time!',
          duration: const Duration(seconds: 5),
        );
    }
  }
}
