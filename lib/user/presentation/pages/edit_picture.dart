import 'dart:typed_data';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:swish/core/fonts/fonts.dart';

import '../../../core/service/image_selector.dart';

class EditPicture extends StatefulWidget {
  const EditPicture({Key? key, required this.image, required this.onChange,
    bool? isProfile, required this.imageBack,
    this.widthImage, }) :isProfile=isProfile??true, super(key: key);
  final ImageProvider image;
  final Function(Uint8List?) onChange;
  final bool isProfile;
  final double? widthImage;
  final String imageBack;


  @override
  State<EditPicture> createState() => _EditPictureState();
}

class _EditPictureState extends State<EditPicture> {

  late ImageProvider? profilePicture;

  @override
  void initState() {
    profilePicture = widget.image;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return  Stack(
      children: [
        CupertinoContextMenu(
          previewBuilder: (context, animation, Widget child) =>
              SizedBox(
                width: widget.widthImage ?? 250,
                height: 250,
                child: child,
              ),
          actions:[
            CupertinoContextMenuAction(
              trailingIcon: CupertinoIcons.photo,
              child: Text("Gallery".tr,style: const TextStyle(fontFamily:  Fonts.outfit),),
              onPressed: () => callBackFile(context,type:ImageSource.gallery, isIos:true),
            ),
            CupertinoContextMenuAction(
              trailingIcon: CupertinoIcons.camera,
              child: Text("Camera".tr,style: const TextStyle(fontFamily:  Fonts.outfit),),
              onPressed: () => callBackFile(context,type:ImageSource.camera, isIos:true),
            ),
            CupertinoContextMenuAction(
              isDestructiveAction: true,
              trailingIcon: CupertinoIcons.delete,
              child: Text("Remove".tr,style: const TextStyle(fontFamily:  Fonts.outfit),),
              onPressed: () => callBackFile(context, isIos:true),
            )
          ],
          child: Hero(
            tag: "avatar",
            child: widget.isProfile
                ? CircleAvatar(
                    radius: 75,
                    backgroundImage: profilePicture ?? AssetImage(widget.imageBack))
                : SizedBox(
              width: 360,
              height: 185,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: ClipRRect(
                      borderRadius: const BorderRadius.all(Radius.circular(25)),
                      child: Image(
                          image: profilePicture ?? AssetImage(widget.imageBack), fit: BoxFit.cover,),
                    ),
                  ),
                ),
          ),
        ),
        Positioned(
            right: 10,
            bottom: 7,
            child: SizedBox(
              width: 35,
              height: 35,
              child: Material(
                  clipBehavior: Clip.antiAlias,
                  borderRadius: BorderRadius.circular(14),
                  elevation: 3,
                  child: PopupMenuButton(
                    color: Colors.white,
                      child: const Icon(Icons.edit,
                          size: 20, color: Colors.blue),
                      itemBuilder: (context) {
                        return [
                          PopupMenuItem(
                              child: ListTile(
                                leading: const Icon(Icons.image),
                                title: Text("Gallery".tr),
                                onTap: () => callBackFile(context, type: ImageSource.gallery),
                              )),
                          PopupMenuItem(
                              child: ListTile(
                                leading: const Icon(Icons.camera_alt),
                                title: Text("Camera".tr),
                                onTap: () => callBackFile(context, type: ImageSource.camera),
                              )),
                          PopupMenuItem(
                              child: ListTile(
                                leading: const Icon(Icons.delete),
                                title: Text("Remove".tr),
                                onTap: () => callBackFile(context),
                                //     callBackFile(null, isDelete: true, isIos: false)
                              )
                          ),
                        ];
                      })),
            )),
      ],
    );
  }

  callBackFile(BuildContext context, {ImageSource? type, bool? isIos}) async {
    ImageSelector selector = ImageSelector();
   if(isIos!=true) Navigator.pop(context);
    if (type ==null) {
      profilePicture = AssetImage(widget.imageBack);
      widget.onChange(null);
      setState(() {});
      return;
    }
    Uint8List bytes = await selector.start(type);
    profilePicture = MemoryImage(bytes);
    widget.onChange(bytes);
    setState(() {});
  }

}
