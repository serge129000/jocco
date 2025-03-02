class DateT {
  static String getDureeRelative(DateTime datePublication) {
    final DateTime maintenant = DateTime.now();
    final int differenceEnJours = maintenant.toLocal().difference(datePublication).inDays;

    if (differenceEnJours == 0) {
      // Aujourd'hui
      final int differenceEnHeures =
          maintenant.difference(datePublication).inHours;
      if (differenceEnHeures == 0) {
        // Moins d'une heure
        final int differenceEnMinutes =
            maintenant.difference(datePublication).inMinutes;
        if (differenceEnMinutes < 2) {
          return "À l'instant";
        } else {
          return "${differenceEnMinutes} minutes";
        }
      } else {
        if (differenceEnHeures == 1) {
          return "${differenceEnHeures} heure";
        }
        return "${differenceEnHeures} heures";
      }
    } else if (differenceEnJours == 1) {
      // Hier
      return "Hier";
    } else if (differenceEnJours < 7) {
      // Cette semaine
      return "${joursSemaine[datePublication.weekday - 1]}";
    } else if (differenceEnJours < 30) {
      // Ce mois-ci
      return "${datePublication.day} ${mois[datePublication.month - 1]}";
    } else {
      // Plus ancien
      return "${datePublication.day} ${mois[datePublication.month - 1]} ${datePublication.year}";
    }
  }

  static String getSecondDureeRelative(DateTime datePublication) {
    final DateTime maintenant = DateTime.now();
    final int differenceEnJours = maintenant.difference(datePublication).inDays;

    if (differenceEnJours == 0) {
      // Aujourd'hui
      final int differenceEnHeures =
          maintenant.difference(datePublication).inHours;
      if (differenceEnHeures == 0) {
        // Moins d'une heure
        final int differenceEnMinutes =
            maintenant.difference(datePublication).inMinutes;
        if (differenceEnMinutes < 2) {
          return "0s";
        } else {
          return "${differenceEnMinutes} m";
        }
      } else {
        if (differenceEnHeures == 1) {
          return "${differenceEnHeures} h";
        }
        return "${differenceEnHeures} h";
      }
    } else {
      // Plus ancien
      return "${datePublication.day}/${datePublication.month}/${datePublication.year}";
    }
  }
}

const List<String> mois = [
  "janvier",
  "février",
  "mars",
  "avril",
  "mai",
  "juin",
  "juillet",
  "août",
  "septembre",
  "octobre",
  "novembre",
  "décembre",
];
const List<String> joursSemaine = [
  "Lundi",
  "Mardi",
  "Mercredi",
  "Jeudi",
  "Vendredi",
  "Samedi",
  "Dimanche"
];