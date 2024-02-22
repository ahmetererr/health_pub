import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

class Pharmacy {
  bool? success;
  List<Result>? result;

  Pharmacy({this.success, this.result});

  factory Pharmacy.fromJson(Map<String, dynamic> json) {
    return Pharmacy(
      success: json['success'],
      result: (json['result'] as List<dynamic>?)
          ?.map((e) => Result.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }
}

class Result {
  String? name;
  String? district;
  String? address;
  String? phone;
  String? location;

  Result({this.name, this.district, this.address, this.phone, this.location});

  factory Result.fromJson(Map<String, dynamic> json) {
    return Result(
      name: json['name'],
      district: json['dist'],
      address: json['address'],
      phone: json['phone'],
      location: json['loc'],
    );
  }
}

Future<Pharmacy> fetchPharmacy(String city, {String? district}) async {
  String apiUrl = 'https://api.collectapi.com/health/dutyPharmacy?il=$city';
  if (district != null && district.isNotEmpty) {
    apiUrl += '&ilce=$district';
  }

  final response = await http.get(
    Uri.parse(apiUrl),
    headers: {
      HttpHeaders.contentTypeHeader: 'application/json',
      HttpHeaders.authorizationHeader:
      'apikey 2XAnz1I3HF1oV6RWh6dOEp:4gwT8Y1RDYaKYcMMYDCeGe',
    },
  );

  if (response.statusCode == 200) {
    return Pharmacy.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to load pharmacy data');
  }
}

class PharmacyPage extends StatefulWidget {
  const PharmacyPage({Key? key}) : super(key: key);

  @override
  State<PharmacyPage> createState() => _PharmacyPageState();
}

class _PharmacyPageState extends State<PharmacyPage> {
  late Future<Pharmacy> futurePharmacy;

  @override
  void initState() {
    super.initState();
    futurePharmacy = fetchPharmacy('Kayseri');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Duty Pharmacy'),
      ),
      body: Center(
        child: FutureBuilder<Pharmacy>(
          future: futurePharmacy,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final pharmacy = snapshot.data!;
              if (pharmacy.success == true && pharmacy.result != null) {
                return ListView.builder(
                  itemCount: pharmacy.result!.length,
                  itemBuilder: (context, index) {
                    final pharmacyInfo = pharmacy.result![index];
                    return Container(
                      margin: EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.green),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: ListTile(
                        title: Padding(
                          padding: EdgeInsets.only(bottom: 8.0),
                          child: Text(
                            pharmacyInfo.name ?? '',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.red.shade500
                            ),
                          ),
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(bottom: 4.0),
                              child: Text(
                                pharmacyInfo.address ?? '',
                                style: TextStyle(
                                  fontStyle: FontStyle.italic,
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(bottom: 4.0),
                              child: Row(
                                children: [
                                  Text(
                                    'District: ',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(pharmacyInfo.district ?? ''),
                                ],
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(bottom: 4.0),
                              child: Row(
                                children: [
                                  Text(
                                    'Phone: ',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(pharmacyInfo.phone ?? ''),
                                ],
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                launchMapsUrl(pharmacyInfo.location);
                              },
                              child: Padding(
                                padding: EdgeInsets.only(top: 4.0),
                                child: Text(
                                  'Location: ${pharmacyInfo.location ?? ''}',
                                  style: TextStyle(
                                    color: Colors.blue,
                                    decoration: TextDecoration.underline,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              } else {
                return const Text('Pharmacy information not found');
              }
            } else if (snapshot.hasError) {
              return Text('Mistake: ${snapshot.error}');
            }
            return const CircularProgressIndicator();
          },
        ),
      ),
    );
  }

  void launchMapsUrl(String? location) async {
    if (location != null && location.isNotEmpty) {
      final url = 'https://www.google.com/maps/search/?api=1&query=$location';
      if (await canLaunch(url)) {
        await launch(url);
      } else {
        throw 'Map link could not be opened: $url';
      }
    }
  }
}

void main() {
  runApp(MaterialApp(
    home: PharmacyPage(),
  ));
}