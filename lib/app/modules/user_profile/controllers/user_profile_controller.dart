import 'dart:convert';
import 'dart:io';

import 'package:get/get.dart';
import 'package:golf_game_play/app/data/api_constants.dart';
import 'package:golf_game_play/app/modules/model/user_model.dart';
import 'package:golf_game_play/app/modules/user_profile/model/user_profile.dart';
import 'package:golf_game_play/common/prefs_helper/prefs_helpers.dart';
import 'package:http/http.dart' as http;

class UserProfileController extends GetxController {

  Rx<UserProfile> userProfile = UserProfile().obs;
  RxBool isLoading= false.obs;

  fetchUser() async {
    isLoading.value = true;
    try {
      String token = await PrefsHelper.getString('token');
     String userId = Get.arguments['userId'];

      Map<String, String> headers = {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json'
      };

      var request = http.Request('GET', Uri.parse(ApiConstants.userProfileByIdUrl(userId)));

      request.headers.addAll(headers);
      var response = await request.send();
      var responseBody = await http.Response.fromStream(response);
      print('Response body: ${responseBody.body}');
      Map<String,dynamic> decodedBody = jsonDecode(responseBody.body);

      if (response.statusCode == 200) {
        userProfile.value= UserProfile.fromJson(decodedBody);
        print(userProfile.value);
      } else {
        print('Error: ${response.statusCode}');
        Get.snackbar('Failed', decodedBody['message']);
      }
    } on SocketException catch (_) {
      Get.snackbar(
        'Error',
        'No internet connection. Please check your network and try again.',
        snackPosition: SnackPosition.TOP,
      );
    } catch (e) {
      Get.snackbar(
        'Error',
        'Something went wrong. Please try again later.',
        snackPosition: SnackPosition.TOP,
      );
      print(e);
    } finally {
      isLoading.value = false;
    }
  }


}
