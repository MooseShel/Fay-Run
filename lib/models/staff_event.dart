enum StaffEventType {
  shoeTie, // Head of School: Stumble/No Jump
  coachWhistle, // Coach: Double Speed
  librarianShush, // Librarian: Mute/Dim
  scienceSplat, // Science Teacher: Ink Splat
  deanGlare, // Dean: Slow Motion
  peDrill, // PE Staff: Super Jump
  englishTeacher, // English: Voice Line
  firstGradeTeacher, // 1st Grade: Voice Line
  prekTeacher, // Pre-K: Voice Line
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
          duration: const Duration(seconds: 2),
        );
      case StaffEventType.librarianShush:
        return StaffEvent(
          type: type,
          title: 'The Librarian',
          message: 'Shhhhh!',
          duration: const Duration(seconds: 2),
        );
      case StaffEventType.scienceSplat:
        return StaffEvent(
          type: type,
          title: 'Science Teacher',
          message: 'Whoopsie!',
          duration: const Duration(seconds: 2),
        );
      case StaffEventType.deanGlare:
        return StaffEvent(
          type: type,
          title: 'Dean of Students',
          message: 'Detention!',
          duration: const Duration(seconds: 2),
        );
      case StaffEventType.peDrill:
        return StaffEvent(
          type: type,
          title: 'PE Staff',
          message: 'Drill Time!',
          duration: const Duration(seconds: 2),
        );
      case StaffEventType.englishTeacher:
        return StaffEvent(
          type: type,
          title: 'English Teacher',
          message: 'On to the Races!',
          duration: const Duration(seconds: 2),
        );
      case StaffEventType.firstGradeTeacher:
        return StaffEvent(
          type: type,
          title: '1st Grade Teacher',
          message: 'Great job!',
          duration: const Duration(seconds: 2),
        );
      case StaffEventType.prekTeacher:
        return StaffEvent(
          type: type,
          title: 'Pre-K Teacher',
          message: 'Eyes on me!',
          duration: const Duration(seconds: 2),
        );
    }
  }
}
