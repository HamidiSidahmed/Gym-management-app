import 'package:flutter/material.dart';

class CustomImageCache extends WidgetsFlutterBinding {
  @override
  ImageCache createImageCache() {
    ImageCache iamgecache = super.createImageCache();
    iamgecache.maximumSizeBytes = 1024 * 1024 * 100;
    return imageCache;
  }
}
