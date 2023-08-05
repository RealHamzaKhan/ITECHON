import 'dart:io';
import 'dart:typed_data';

import 'package:dotted_border/dotted_border.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:itechon/common/custom_button.dart';
import 'package:itechon/common/custom_text.dart';
import 'package:itechon/common/height_spacer.dart';
import 'package:itechon/common/textfield_with_title.dart';
import 'package:itechon/common/width_spacer.dart';
import 'package:provider/provider.dart';
import '../../../common/custom_appbar.dart';
import '../../../consts/colors.dart';
import '../../provider/event_provider.dart';

class AddToGallery extends StatefulWidget {
  const AddToGallery({Key? key}) : super(key: key);

  @override
  State<AddToGallery> createState() => _AddToGalleryState();
}

class _AddToGalleryState extends State<AddToGallery> {
  PlatformFile? _imageFile;
  Future<void> pickImage()async{
    FilePickerResult? result=await FilePicker.platform.pickFiles(
        type: FileType.image
    );
    if(result==null){
      return;
    }
    else{
      setState(() {
        _imageFile = result.files.first;
      });
    }
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.sizeOf(context).height;
    double width = MediaQuery.sizeOf(context).width;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(height * 0.1),
        child: customAppBar(context: context),
      ),
      body: Container(
          height: double.infinity,
          width: double.infinity,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [kLight, kLightBlue],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: SingleChildScrollView(
            child: Padding(
                padding:
                EdgeInsets.symmetric(vertical: 10.h, horizontal: 177.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Align(
                        alignment: Alignment.center,
                        child: _imageFile==null?GestureDetector(
                          onTap: (){
                            pickImage();
                          },
                          child: DottedBorder(
                            color: Colors.black.withOpacity(0.3),
                            borderType: BorderType.RRect,
                            radius: const Radius.circular(10),
                            padding: const EdgeInsets.all(6),
                            child: ClipRRect(
                              borderRadius:
                              const BorderRadius.all(Radius.circular(10)),
                              child: Container(
                                alignment: Alignment.center,
                                height: 300.h,
                                width: 500.w,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Image.asset(
                                      'assets/icons/plus-circle.png',
                                      height: 24.h,
                                      width: 24.w,
                                      color: Colors.black.withOpacity(0.3),
                                    ),
                                    widthSpacer(width: 4.w),
                                    customText(
                                        text: "ADD IMAGE",
                                        size: 18.sp,
                                        fw: FontWeight.w500,
                                        color: Colors.black.withOpacity(0.3)),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ):GestureDetector(
                          onTap: (){
                            pickImage();
                          },
                          child: Image.memory(Uint8List.fromList(_imageFile!.bytes!),height: 243.h,
                            width: 367.w,),
                        )
                    ),

                    heightSpacer(height: 50.h),
                    Consumer<EventProvider>(builder: (context,provider,child){
                      return Align(
                          alignment: Alignment.center,
                          child: provider.isAdding?customButton(height: 66.h,width: 220.w,text: "Add Image",color: kLightBlue.withOpacity(0.2),

                          ):customButton(height: 66.h,width: 220.w,text: "Add Image",color: kLightBlue,
                              onTap: (){
                            provider.addImageToGallery(context: context, image: _imageFile!.bytes);
                              }
                          ));
                    }),
                    heightSpacer(height: 50.h),
                  ],
                )),
          )),
    );
  }
}
