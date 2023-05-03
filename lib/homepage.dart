import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() => runApp(const HomepageCI());

class HomepageCI extends StatefulWidget {
  const HomepageCI({super.key});

  @override
  State<HomepageCI> createState() => _HomepageCIState();
}

class _HomepageCIState extends State<HomepageCI> {
  Country country = Country("", "", "", "", "", "");
  String countryN = "";
  String code = "";

  TextEditingController countryCon = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 20, 69, 46),
          title: const Text(
            'ContInfo',
            style: TextStyle(
              fontFamily: 'Times New Roman',
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                Row(children: const [
                  Text(
                    "Country: ",
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Times New Roman',
                        color: Colors.brown),
                  ),
                ]),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    SizedBox(
                      width: 225,
                      height: 50,
                      child: TextField(
                        controller: countryCon,
                        decoration: InputDecoration(
                          hintText: "Search for country",
                          border: OutlineInputBorder(
                              borderSide: const BorderSide(color: Colors.brown),
                              borderRadius: BorderRadius.circular(100.0)),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    ElevatedButton(
                      onPressed: searchM,
                      style: ButtonStyle(
                        elevation: MaterialStateProperty.all(4),
                        fixedSize:
                            MaterialStateProperty.all(const Size(40, 50)),
                        shape: MaterialStateProperty.all(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(23),
                          ),
                        ),
                      ),
                      child: const Icon(
                        Icons.search_rounded,
                        size: 30,
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                  height: 320,
                  width: 300,
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Container(
                            padding: const EdgeInsets.all(8.0),
                            width: 140,
                            height: 150,
                            color: Colors.amber,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                const Text(
                                  "Country",
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Times New Roman',
                                  ),
                                ),
                                SizedBox(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      if (code != "")
                                        Image.network(
                                            "https://flagsapi.com/$code/flat/64.png"),
                                      if (code == "")
                                        const Icon(
                                          Icons.flag,
                                          size: 64,
                                        ),
                                      const SingleChildScrollView(),
                                      Text(
                                        country.countryN,
                                        style: const TextStyle(
                                          fontFamily: 'Times New Roman',
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Container(
                            width: 140,
                            height: 150,
                            color: Colors.amber,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                const Text(
                                  "Capital",
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontFamily: 'Times New Roman',
                                      fontWeight: FontWeight.bold),
                                ),
                                const Icon(
                                  Icons.apartment,
                                  size: 64,
                                  color: Color.fromARGB(255, 60, 88, 102),
                                ),
                                Text(
                                  country.capital,
                                  style: const TextStyle(
                                    fontFamily: 'Times New Roman',
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Container(
                            width: 140,
                            height: 150,
                            color: Colors.amber,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                const Text(
                                  "Currency",
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Times New Roman',
                                  ),
                                ),
                                const Icon(
                                  Icons.currency_exchange,
                                  size: 64,
                                  color: Color.fromARGB(255, 7, 98, 54),
                                ),
                                SizedBox(
                                  child: Column(
                                    children: [
                                      Text(
                                        country.currencyCode,
                                        style: const TextStyle(
                                          fontFamily: 'Times New Roman',
                                        ),
                                      ),
                                      Text(country.currencyName,
                                          style: const TextStyle(
                                            fontFamily: 'Times New Roman',
                                          ))
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Container(
                            width: 140,
                            height: 150,
                            color: Colors.amber,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                const Text(
                                  "Population",
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Times New Roman',
                                  ),
                                ),
                                const Icon(
                                  Icons.emoji_people,
                                  size: 64,
                                  color: Colors.black,
                                ),
                                Text(
                                  country.population,
                                  style: const TextStyle(
                                    fontFamily: 'Times New Roman',
                                  ),
                                )
                              ],
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> searchM() async {
    if (countryCon.text == "") {
      countryN = "Not Available";
      var showDial3 = showDialog(
          context: context,
          builder: (BuildContext context) {
            return const AlertDialog(
                title: Text("No Input"),
                content: Text("Please enter a country name"));
          });
    } else {
      countryN = countryCon.text;

      var showDial = showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
                title: const Text("Loading"),
                content: SizedBox(
                  child: Row(
                    children: const [
                      CircularProgressIndicator(),
                      SizedBox(
                        width: 10,
                      ),
                      Text("Please wait")
                    ],
                  ),
                ));
          });
      String appId = "8mFYqsEjvw6Q2LQjkHIitg==4t2Ihu4b4EFYcjtc";
      Uri url = Uri.parse(
          'https://api.api-ninjas.com/v1/country?name=$countryN&apiId={$appId}');
      var response = await http.get(
        url,
        headers: {
          'X-Api-Key': appId,
          'User-Agent': 'Flutter',
        },
      );

      try {
        if (response.statusCode == 200) {
          String jsonData = response.body;
          var parsedJson = json.decode(jsonData); //need dart convert
          code = parsedJson[0]['iso2'];
          country = Country(
              parsedJson[0]['name'],
              parsedJson[0]['capital'],
              parsedJson[0]['currency']['code'],
              parsedJson[0]['currency']['name'],
              parsedJson[0]['population'].toString(),
              code);
          Future.delayed(
              const Duration(seconds: 1), () => Navigator.of(context).pop());

          setState(() {});
        }
      } catch (e) {
        Navigator.pop(context);
        country = Country("", "", "", "", "", "");
        code = "";
        await showDialog(
          context: context,
          builder: (BuildContext context) {
            return const AlertDialog(
              title: Text("Error"),
              content: Text("Country is not found"),
            );
          },
        );
        setState(() {});
      }
    }
  }
}

class Country {
  String countryN = "",
      capital = "",
      currencyCode = "",
      currencyName = "",
      population = "",
      description = "",
      code = "";

  Country(this.countryN, this.capital, this.currencyCode, this.currencyName,
      this.population, this.code);
}
