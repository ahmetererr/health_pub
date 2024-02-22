import 'package:flutter/material.dart';

import '../health_needs_pages/appointment_page.dart';
import '../health_needs_pages/covid19_page.dart';
import '../health_needs_pages/hospital_page.dart';
import '../health_needs_pages/pharmacy_page.dart';

class HealthNeeds extends StatelessWidget {
  const HealthNeeds({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<CustomIcon> customIcons = [
      CustomIcon(name: "Appointment", icon: 'assets/appointment.png'),
      CustomIcon(name: "Symptom", icon: 'assets/hospital.png'),
      CustomIcon(name: "Barcode Scanner", icon: 'assets/scanner.png'),
      CustomIcon(name: "More", icon: 'assets/more.png'),
    ];
    List<CustomIcon> healthNeeds = [
      CustomIcon(name: "Appointment", icon: 'assets/appointment.png'),
      CustomIcon(name: "Symptom", icon: 'assets/hospital.png'),
      CustomIcon(name: "Barcode Scanner", icon: 'assets/scanner.png'),
      CustomIcon(name: "Pharmacy", icon: 'assets/drug.png'),
    ];
    List<CustomIcon> specialisedCared = [
      CustomIcon(name: "Diabetes", icon: 'assets/blood.png'),
      CustomIcon(name: "Health Care", icon: 'assets/health_care.png'),
      CustomIcon(name: "Dental", icon: 'assets/tooth.png'),
      CustomIcon(name: "Insured", icon: 'assets/insurance.png'),
    ];

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: List.generate(customIcons.length, (index) {
        return Column(
          children: [
            InkWell(
              onTap: () {
                if (index == customIcons.length - 1) {
                  showModalBottomSheet(
                    context: context,
                    showDragHandle: true,
                    builder: (context) {
                      return Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(20),
                        height: 350,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Health Needs",
                              style: Theme.of(context).textTheme.headline6,
                            ),
                            const SizedBox(height: 15),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: List.generate(
                                healthNeeds.length,
                                    (innerIndex) {
                                  return Column(
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          _openPage(
                                              context, healthNeeds[innerIndex].name);
                                        },
                                        borderRadius: BorderRadius.circular(90),
                                        child: Container(
                                          width: 60,
                                          height: 60,
                                          padding: const EdgeInsets.all(15),
                                          decoration: BoxDecoration(
                                            color: Theme.of(context)
                                                .colorScheme
                                                .primaryContainer
                                                .withOpacity(0.4),
                                            shape: BoxShape.circle,
                                          ),
                                          child: Image.asset(
                                            healthNeeds[innerIndex].icon,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(height: 6),
                                      Text(healthNeeds[innerIndex].name)
                                    ],
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  );
                } else {
                  _openPage(context, customIcons[index].name);
                }
              },
              borderRadius: BorderRadius.circular(90),
              child: Container(
                width: 60,
                height: 60,
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: Theme.of(context)
                      .colorScheme
                      .primaryContainer
                      .withOpacity(0.4),
                  shape: BoxShape.circle,
                ),
                child: Image.asset(
                  customIcons[index].icon,
                ),
              ),
            ),
            const SizedBox(height: 6),
            Text(customIcons[index].name)
          ],
        );
      }),
    );
  }

  void _openPage(BuildContext context, String iconName) {
    switch (iconName) {
      case 'Appointment':
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => AppointmentPage()));
        break;
      case 'Symptom':
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => SymptomCheckerApp()));
        break;
      case 'Barcode Scanner':
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => Covid19Page()));
        break;
      case 'Pharmacy':
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => PharmacyPage()));
        break;
    // Proceed in the same way for other icons...
      default:
        break;
    }
  }
}

class CustomIcon {
  final String name;
  final String icon;

  CustomIcon({
    required this.name,
    required this.icon,
  });
}
