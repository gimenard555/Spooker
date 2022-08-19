import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:spooker/data/model/artwork.dart';
import 'package:spooker/ui/components/dialogs/image_bottom_sheet.dart';
import 'package:spooker/ui/components/main_screen_extension.dart';
import 'package:spooker/ui/screens/artwork/artwork_view_model.dart';

import '../../../data/model/enums.dart';
import '../../../gen/assets.gen.dart';
import '../../components/Inputs/text_form_view.dart';
import '../../components/buttons/common_button_view.dart';
import '../../components/image/image.dart';
import '../../components/pickers/spinner_view.dart';
import '../../components/spooker_borders.dart';
import '../../components/top_bar_view.dart';
import '../../utils/spooker_colors.dart';
import '../../utils/spooker_fonts.dart';
import '../../utils/spooker_sizes.dart';
import '../../utils/spooker_strings.dart';
import '../camera/CameraScreen.dart';

// ignore: must_be_immutable
class NewArtworkScreen extends HookConsumerWidget {
  NewArtworkScreen({this.artwork, this.artworkId});

  late TextEditingController _titleController;
  late TextEditingController _descriptionFieldController;
  late ArtworkViewModel _viewModel;
  late double screenWidth;

  final Artwork? artwork;
  final String? artworkId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    _viewModel = ref.watch(artworkViewModel);
    _initTextControllers();
    screenWidth = MediaQuery.of(context).size.width;
    _viewModel.privacy = Privacy.values
        .map<String>((text) {
          return text.name;
        })
        .toList()
        .first;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          reverse: true,
          child: Column(
            children: [
              TopBarView(SpookerStrings.newArtwork),
              InkWell(
                  onTap: () {
                    context.showPhotoOptions((option) {
                      getImageByFlow(option, context);
                    });
                  },
                  child: Container(
                      margin: EdgeInsets.all(SpookerSize.m20),
                      height: screenWidth,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        border: Border.all(
                            width: SpookerSize.m3, color: getBorderColor()),
                        borderRadius: SpookerBorders.m30Border,
                        color: SpookerColors.completeLight,
                      ),
                      child: _getImage())),
              Container(
                  margin: EdgeInsets.symmetric(
                      horizontal: SpookerSize.m20, vertical: SpookerSize.m5),
                  alignment: Alignment.center,
                  child: TextFormView(
                    textController: _titleController,
                    textHint: SpookerStrings.artworkTitle,
                    errorMessage: '',
                    isValidText: _titleController.text.isNotEmpty ||
                        _viewModel.title.isNotEmpty,
                  )),
              Container(
                  margin: EdgeInsets.symmetric(
                      horizontal: SpookerSize.m20, vertical: SpookerSize.m5),
                  alignment: Alignment.center,
                  child: TextFormView(
                    textController: _descriptionFieldController,
                    textHint: SpookerStrings.artworkDescription,
                    errorMessage: '',
                    isValidText: _descriptionFieldController.text.isNotEmpty ||
                        _viewModel.description.isNotEmpty,
                  )),
              Container(
                margin: EdgeInsets.symmetric(
                    horizontal: SpookerSize.m20, vertical: SpookerSize.m5),
                alignment: Alignment.center,
                child: SpinnerView(
                    SpookerStrings.privacyType,
                    Privacy.values.map<String>((text) {
                      return text.name;
                    }).toList(), (value) {
                  _viewModel.privacy = value;
                }),
              ),
              Container(
                alignment: Alignment.center,
                margin: EdgeInsets.symmetric(
                    horizontal: SpookerSize.m20, vertical: SpookerSize.m5),
                child: CommonButtonView(
                  SpookerColors.blueCommonTextColor,
                  getButtonTextByData(),
                  SpookerFonts.s14BoldLight,
                  () {
                    _chargeViewModelData();
                    context.showLoading();
                    editOrCreateByData(context);
                  },
                  isAvailable:
                      _textControllers() || _viewModel.isDataCompleted(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _initTextControllers() {
    if (artwork != null && artworkId != null) {
      _titleController = useTextEditingController(text: artwork!.name);
      _descriptionFieldController =
          useTextEditingController(text: artwork!.description);
    } else {
      _titleController =
          useTextEditingController.fromValue(TextEditingValue.empty);
      _descriptionFieldController =
          useTextEditingController.fromValue(TextEditingValue.empty);
    }
    _titleController.addListener(() {
      _viewModel.title = _titleController.text;
    });
    _descriptionFieldController.addListener(() {
      _viewModel.description = _descriptionFieldController.text;
    });
  }

  void getImageByFlow(ImageType type, BuildContext context) async {
    var source;
    switch (type) {
      case ImageType.CAMERA:
        source = ImageSource.camera;
        break;
      case ImageType.GALLERY:
        source = ImageSource.gallery;
        break;
    }
    XFile? pickedFile = await ImagePicker().pickImage(
        source: source,
        maxWidth: SpookerSize.m1800,
        maxHeight: SpookerSize.m1800,
        imageQuality: SpookerSize.m100.toInt());
    if (pickedFile != null) {
      _saveArtworkImage(pickedFile);
    }
  }

  void _saveArtworkImage(XFile file) {
    if (artwork != null && artworkId != null) {
      artwork!.imagePath = '';
    }
    _viewModel.file = file.path;
  }

  Widget _getImage() {
    if (artwork != null && artworkId != null && artwork!.imagePath.isNotEmpty) {
      return ClipRRect(
        borderRadius: SpookerBorders.m30Border,
        child: networkImage(artwork!.imagePath, fit: BoxFit.cover),
      );
    } else {
      if (_viewModel.file.isNotEmpty) {
        return ClipRRect(
            borderRadius: SpookerBorders.m30Border,
            child: Image.file(
              File(_viewModel.file),
              fit: BoxFit.cover,
            ));
      } else {
        return Assets.images.emptyImageIcon.image();
      }
    }
  }

  Color getBorderColor() {
    if (_viewModel.file.isNotEmpty) {
      return SpookerColors.blueCommonTextColor;
    } else {
      return SpookerColors.noAvailableColor;
    }
  }

  void _manageState(BuildContext context) {
    Navigator.pop(context);
    if (_viewModel.isSaved) {
      Navigator.pop(context);
    } else {
      context.showErrorDialog(SpookerErrorStrings.dialogWrong);
    }
  }

  String getButtonTextByData() {
    if (artwork != null && artworkId != null) {
      return SpookerStrings.editText;
    } else {
      return SpookerStrings.continueText;
    }
  }

  void editOrCreateByData(BuildContext context) {
    if (artwork != null && artworkId != null) {
      _viewModel
          .editArtwork(artworkId!)
          .whenComplete(() => {_manageState(context)});
    } else {
      _viewModel.createNewArtwork().whenComplete(() => {_manageState(context)});
    }
  }

  bool _textControllers() {
    if (artwork != null && artworkId != null) {
      return _titleController.text.isNotEmpty &&
          _descriptionFieldController.text.isNotEmpty &&
          artwork!.imagePath.isNotEmpty;
    } else {
      return false;
    }
  }

  void _chargeViewModelData() {
    if (artwork != null && artworkId != null) {
      _viewModel.title = _titleController.text;
      _viewModel.description = _descriptionFieldController.text;
    }
  }
}
