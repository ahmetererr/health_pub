import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Covid19Page(),
    );
  }
}

class Covid19Page extends StatefulWidget {
  @override
  _Covid19PageState createState() => _Covid19PageState();
}

class _Covid19PageState extends State<Covid19Page> {
  final TextEditingController _barcodeController = TextEditingController();
  Map<String, dynamic>? _productData;

  Future<void> _getProductData() async {
    String barcode = _barcodeController.text.trim();
    if (barcode.isNotEmpty) {
      try {
        Map<String, dynamic> data = await fetchProductData(barcode);
        setState(() {
          _productData = data;
        });
      } catch (error) {
        print('Error fetching product data: $error');
        showDialog(
          context: context,
          builder: (BuildContext context) {
            BuildContext dialogContext = context;
            return AlertDialog(
              title: Text('Error'),
              content: Text('Failed to fetch product data.'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(dialogContext).pop();
                  },
                  child: Text('Close'),
                ),
              ],
            );
          },
        );
      }
    } else {
      // Handle empty barcode case
    }
  }

  Future<Map<String, dynamic>> fetchProductData(String barcode) async {
    try {
      final String apiUrl = 'https://world.openfoodfacts.org/api/v0/product/$barcode.json';
      final response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        throw Exception('Failed to load product data: ${response.statusCode}');
      }
    } catch (error) {
      throw Exception('Failed to load product data: $error');
    }
  }


// ... (Previous code remains unchanged)

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue, // Set app bar background color to white
        title: Text(
          'Product Details',
          style: TextStyle(
            color: Colors.white, // Set app bar title color to white
            fontWeight: FontWeight.bold, // Make the app bar title bold
          ),
        ),
      ),
      body: Container(
        color: Colors.blue, // Set background color of the main screen to blue
        padding: EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center, // Center the content vertically
          children: [
            Container(
              color: Colors.white, // Set background color of barcode input area to white
              // Adjust horizontal padding
              child: TextField(
                controller: _barcodeController,
                decoration: InputDecoration(
                  labelText: 'Enter Barcode',
                  labelStyle: TextStyle(color: Colors.black , fontWeight: FontWeight.bold),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue, width: 6.0), // Set border color and width
                  ),
                ),
              ),
            ),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: _getProductData,
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Colors.blue),
              ),
              child: Text(
                'Fetch Product Data',
                style: TextStyle(
                  color: Colors.white, // Set text color of the button to white
                ),
              ),
            ),
            SizedBox(height: 20.0),
            if (_productData != null && _productData!.containsKey('product')) ...[
              Text(
                'Product Name: ${_productData!['product']['product_name'] ?? 'N/A'}',
                style: TextStyle(fontSize: 18.0 ,color: Colors.white,),
              ),
              SizedBox(height: 10.0),
              if (_productData!['product'].containsKey('image_url'))
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.blue, // Set border color to blue
                      width: 2.0, // Set border width
                    ),
                    borderRadius: BorderRadius.circular(15.0), // Set border radius to 15px
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(13.0), // Adjust border radius to 13px (slightly smaller to fit within the border)
                    child: Image.network(
                      _productData!['product']['image_url'],
                      height: MediaQuery.of(context).size.height * 0.3, // Set image height to 30% of the screen height
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              SizedBox(height: 10.0),
              Text(
                'Allergens: ${_productData!['product']['allergens'] ?? 'N/A'}',
                style: TextStyle(fontSize: 16.0,color: Colors.white,),
              ),
            ],
          ],
        ),
      ),
    );
  }
}