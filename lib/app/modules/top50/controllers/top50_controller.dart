import 'dart:convert';
import 'dart:io';

import 'package:get/get.dart';
import 'package:golf_game_play/app/data/api_constants.dart';
import 'package:golf_game_play/app/modules/top50/model/top_50_player.dart';
import 'package:golf_game_play/common/prefs_helper/prefs_helpers.dart';
import 'package:http/http.dart' as http;


class Top50Controller extends GetxController {

  RxBool isLoading= false.obs;
 Rx<Top50GolfersModel> top50GolfersModel = Top50GolfersModel().obs;

  fetchTop50Golfers() async {
    isLoading.value = true;
    try {
      String token = await PrefsHelper.getString('token');

      Map<String, String> headers = {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json'
      };

      var request = http.Request('GET', Uri.parse(ApiConstants.to50GolfersUrl));

      request.headers.addAll(headers);
      var response = await request.send();
      var responseBody = await http.Response.fromStream(response);
      print('Response body: ${responseBody.body}');
      Map<String,dynamic> decodedBody = jsonDecode(responseBody.body);
      if (response.statusCode == 200) {
        top50GolfersModel.value= Top50GolfersModel.fromJson(decodedBody);
        print(top50GolfersModel.value);
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
  @override
  void onReady() async{
    await fetchTop50Golfers();
    super.onReady();
  }
}
