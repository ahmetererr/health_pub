// ignore_for_file: public_member_api_docs, sort_constructors_first
class DoctorModel {
  final String name;
  final String position;
  final int averageReview;
  final int totalReviews;
  final String profile;
  DoctorModel({
    required this.name,
    required this.position,
    required this.averageReview,
    required this.totalReviews,
    required this.profile,
  });
}

final List<DoctorModel> nearbyDoctors = [
  DoctorModel(
    name: "Erdem Batucu",
    position: "General Practitioner",
    averageReview: 0,
    totalReviews: 0,
    profile: "assets/doctor-2-.png",
  ),
  DoctorModel(
    name: "Semih Hurur",
    position: "General Practitioner",
    averageReview: 0,
    totalReviews: 0,
    profile: "assets/doctor-man.png",
  ),
  DoctorModel(
    name: "Deli Kaya",
    position: "General Practitioner",
    averageReview: 2,
    totalReviews: 0,
    profile: "assets/doctor.png",
  ),
];
