import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qalb/providers/DataProvider.dart';

class  GetAllData{


  static getData(BuildContext context){
              Provider.of<DataProvider>(context, listen: false).getAudios();

          Provider.of<DataProvider>(context, listen: false).getShajraNasbiyaImageUrl("shajra_nasbiya/");
          Provider.of<DataProvider>(context, listen: false).getShajraHasbiyaImageUrl("shajra_hasbiya/");
          Provider.of<DataProvider>(context, listen: false).getMajlisImagesUrl();
          Provider.of<DataProvider>(context, listen: false).getPngs();
          Provider.of<DataProvider>(context, listen: false).getMajlisThumbUrl();
          Provider.of<DataProvider>(context, listen: false).getSounds();
          Provider.of<DataProvider>(context, listen: false).getakwalImageUrl();
          Provider.of<DataProvider>(context, listen: false).getAllImageUrl();
          Provider.of<DataProvider>(context, listen: false).getMajlisText();
          Provider.of<DataProvider>(context, listen: false).getMajlisAudios();
  }
}