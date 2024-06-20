import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:http/http.dart' as http;
import 'package:wall_vista/pages/imageScreen.dart';
import 'package:wall_vista/utils/api.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List data = [];

  final TextEditingController searchConotroller = TextEditingController();
  final List<String> categories = [
    'Architecture',
    'Movies',
    'Travel',
    'Animal',
    'Food',
    'Sports',
    'Nature'
  ];
  @override
  void dispose() {
    super.dispose();
    searchConotroller.dispose();
  }

  @override
  void initState() {
    super.initState();
    getPhoto(categories[0]);
  }

  getPhoto(search) async {
    setState(() {
      data = [];
    });

    try {
      final url = Uri.parse(
          'https://api.unsplash.com/search/photos/?client_id=$api&query=${search}+"mobile wallpaper"+&per_page=30');

      var response = await http.get(url);
      var result = jsonDecode(response.body);
      data = result['results'];
      print(data);

      setState(() {});
    } catch (err) {
      print(err.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        centerTitle: true,
        title: Text(
          'Wall Vista',
          style: TextStyle(
              fontSize: 25, fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: searchConotroller,
                      decoration: InputDecoration(
                          hintText: 'Search Wallpapers',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                          )),
                    ),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  GestureDetector(
                    onTap: () {
                      getPhoto(searchConotroller.text);
                    },
                    child: Card(
                      color: Colors.grey,
                      child: Container(
                          height: 45,
                          width: 45,
                          child: Icon(
                            Icons.search,
                            size: 30,
                          )),
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: Column(
                children: [
                  Container(
                      height: 170,
                      child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: categories.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      getPhoto(categories[index]);
                                    },
                                    child: Container(
                                      height: 100,
                                      width: 150,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          image: DecorationImage(
                                              image: AssetImage(
                                                  'assets/images/${categories[index]}.jpg'),
                                              fit: BoxFit.cover)),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    categories[index],
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                    ),
                                  )
                                ],
                              ),
                            );
                          })),
                ],
              ),
            ),
            Expanded(
              child: data.isNotEmpty
                  ? MasonryGridView.count(
                      crossAxisCount: 2,
                      itemCount: data.length,
                   
                      itemBuilder: (context, index) {
                        double ht = index % 2 == 0 ? 200 : 100;
                        return GestureDetector(
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context){
                              return ImageScreen(imageUrl:data[index]['urls']['full'] ,);
                            }));
                            print(data[index]['urls']['full']);
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: ClipRRect(
                              child: Image.network(
                                data[index]['urls']['regular'],
                                height: ht,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        );
                      },
                    )
                  : Center(
                      child: CircularProgressIndicator(),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
