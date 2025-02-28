import 'dart:convert';
import 'dart:io';

import 'package:get/get.dart';
import 'package:golf_game_play/app/data/api_constants.dart';
import 'package:golf_game_play/app/modules/invitation/model/invitation_model.dart';
import 'package:golf_game_play/common/prefs_helper/prefs_helpers.dart';
import 'package:http/http.dart' as http;

class InvitationController extends GetxController {
  final Rx<InvitationModel> invitationModel = InvitationModel().obs;
  RxBool isLoading = false.obs;


  getInvitations() async {
    isLoading.value = true;
    try {
      String token = await PrefsHelper.getString('token');
      String userId = await PrefsHelper.getString('userId');

      Map<String, String> headers = {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json'
      };

      var request = http.Request('GET', Uri.parse(ApiConstants.allInvitationUrl));

      request.headers.addAll(headers);

      var response = await request.send();
      var responseBody = await http.Response.fromStream(response);
      print('Location update body: ${responseBody.body}');
      var decodedBody = jsonDecode(responseBody.body);

      if (response.statusCode == 200) {
        invitationModel.value = InvitationModel.fromJson(decodedBody);
        print(invitationModel.value);
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
    await getInvitations();
    super.onReady();
  }
}
