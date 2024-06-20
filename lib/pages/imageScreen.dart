import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:wall_vista/pages/home.dart';
import 'package:wall_vista/utils/snackbar.dart';

import 'package:wallpaper_manager_flutter/wallpaper_manager_flutter.dart';

class ImageScreen extends StatefulWidget {
  final String imageUrl;

  const ImageScreen({super.key, required this.imageUrl});

  @override
  State<ImageScreen> createState() => _ImageScreenState();
}

class _ImageScreenState extends State<ImageScreen> {
  bool isloading = false;
  Future<void> setHomeWallpaper() async {
    setState(() {
      isloading = true;
    });
    var cachedimage =
        await DefaultCacheManager().getSingleFile(widget.imageUrl);
    int location = WallpaperManagerFlutter.HOME_SCREEN;
    await WallpaperManagerFlutter().setwallpaperfromFile(cachedimage, location);
    setState(() {
      isloading = false;
    });
    showSnackbar('Wallpaper set successfully', context);
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
      return HomePage();
    }));
  }

  Future<void> setLockWallpaper() async {
    setState(() {
      isloading = true;
    });
    var cachedimage =
        await DefaultCacheManager().getSingleFile(widget.imageUrl);
    int location = WallpaperManagerFlutter.LOCK_SCREEN;
    await WallpaperManagerFlutter().setwallpaperfromFile(cachedimage, location);
    setState(() {
      isloading = false;
    });
    showSnackbar('Wallpaper set successfully', context);
  }

  Future<void> setBothWallpaper() async {
    setState(() {
      isloading = true;
    });
    var cachedimage =
        await DefaultCacheManager().getSingleFile(widget.imageUrl);
    int location = WallpaperManagerFlutter.BOTH_SCREENS;
    await WallpaperManagerFlutter().setwallpaperfromFile(cachedimage, location);
    setState(() {
      isloading = false;
    });
    showSnackbar('Wallpaper set successfully', context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Stack(
            children: [
              Container(
                height: MediaQuery.of(context).size.height,
                child: Image.network(
                  widget.imageUrl,
                  fit: BoxFit.cover,
                ),
              ),
              isloading
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : Positioned(
                      bottom: 20,
                      left: 10,
                      right: 10,
                      child: GestureDetector(
                        onTap: () {
                          showModalBottomSheet(
                              backgroundColor: Colors.grey.shade300,
                              context: context,
                              builder: (context) {
                                return Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        GestureDetector(
                                          onTap: () {
                                            setHomeWallpaper();
                                            Navigator.pop(context);
                                          },
                                          child: Card(
                                            color: Colors.grey,
                                            child: Container(
                                              height: 120,
                                              width: 120,
                                              child: Center(
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Text(
                                                    'Set as Home Screen',
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 20),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            setLockWallpaper();
                                            Navigator.pop(context);
                                          },
                                          child: Card(
                                            color: Colors.grey,
                                            child: Container(
                                              height: 120,
                                              width: 120,
                                              child: Center(
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Text(
                                                    'Set as Lock Screen',
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 20),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            setBothWallpaper();
                                            Navigator.pop(context);
                                          },
                                          child: Card(
                                            color: Colors.grey,
                                            child: Container(
                                              height: 120,
                                              width: 120,
                                              child: Center(
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Text(
                                                    'Set as Both',
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 20),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 20,
                                    )
                                  ],
                                );
                              });
                        },
                        child: Card(
                          color: Colors.black,
                          child: Container(
                            height: 60,
                            width: MediaQuery.of(context).size.width,
                            child: Center(
                                child: Text(
                              'Set as wallpaper',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 25,
                              ),
                            )),
                          ),
                        ),
                      ),
                    )
            ],
          ),
        ],
      ),
    );
  }
}
