import 'package:flutter_riverpod/flutter_riverpod.dart';

final imagesStateProvider = StateProvider.autoDispose<ImagesProvider>((ref) {
  return ImagesProvider(profileImage: "", aadhaarImg: "");
});

class ImagesProvider {
  final String profileImage;
  final String aadhaarImg;

  ImagesProvider({required this.profileImage, required this.aadhaarImg});
}
