import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Constants {
  // static late bool isLoading;
  static var container_color = Colors.white;
  static var fontFamily = GoogleFonts.inter().fontFamily;
  static var icon_con_color = Colors.grey[200];
  static var icon_color = Colors.grey[600];
  static var icon_text_color = Colors.grey[800];
  static var divider_color = Colors.grey[300];
  static var button_text_color = Colors.green[700];
  static var base_url = "https://api.restful-api.dev/";
  static var allproduct_url = "${base_url}objects";
  static var update_url = "${base_url}objects/7";
  static var delete_url = "${base_url}objects/6";
  static var partialUpdate_url = "${base_url}objects/7";
  static var add_url = "${base_url}objects";
}
