import 'package:flutter/material.dart';
import 'dart:ui_web' as ui;
import 'package:universal_html/html.dart' as html;
import 'package:nb_utils/nb_utils.dart'; // Utility package for padding, spacing, etc.

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String image = ""; // Stores the URL of the image entered by the user
  TextEditingController urlFieldController =
      TextEditingController(); // Controller for the text field input
  bool fullScreen = false; // Tracks fullscreen state
  GlobalKey<FormState> formKey =
      GlobalKey<FormState>(); // formKey for validating url

// for check url is valid or not
  bool isValidUrl(String url) {
    return Uri.tryParse(url)?.isAbsolute ?? false;
  }

  String imageViewType = "fullscreen-image";

  void registerImageView() {
    String newViewType =
        'fullscreen-image-${DateTime.now().millisecondsSinceEpoch}';

    ui.platformViewRegistry.registerViewFactory(newViewType, (int viewId) {
      var img = html.ImageElement()
        ..src = image // Sets the image source URL
        ..style.width = '400px' // Sets image width
        ..style.height = '300px' // Sets image height
        ..style.borderRadius = "10px" // Rounds the image corners
        ..style.cursor = 'pointer'; // Changes cursor to pointer (clickable)

      // Enables fullscreen mode on double-click
      img.onDoubleClick.listen((event) {
        img.requestFullscreen();
      });

      return img; // Returns the configured image element
    });

    // Update the view type to force a refresh
    setState(() {
      imageViewType = newViewType;
    });
  }

  final border = OutlineInputBorder(
    borderRadius: BorderRadius.circular(10), // Sets border radius
    borderSide: BorderSide(color: Colors.black), // Sets border color
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment:
            MainAxisAlignment.center, // Centers content vertically
        crossAxisAlignment:
            CrossAxisAlignment.center, // Centers content horizontally
        children: [
          Align(
            alignment: Alignment.center,
            child: SizedBox(
              width: 400, // Sets a fixed width for the content
              child: Column(
                children: [
                  // Displays image if URL is provided, otherwise shows a placeholder
                  image != ""
                      ? SizedBox(
                              height: 300,
                              width: 400,
                              child: HtmlElementView(
                                  viewType:
                                      imageViewType)) // Uses the custom HTML element for displaying images
                          .paddingBottom(20) // Adds bottom padding
                      : Container(
                          height: 300,
                          width: 400,
                          decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.circular(10), // Rounds corners
                              border: Border.all(color: black)), // Adds border
                          child: Icon(
                            Icons.image,
                            size: 38,
                          ), // Displays a placeholder icon
                        ).paddingOnly(bottom: 20),

                  // Row containing a text field and a button
                  Form(
                    key: formKey,
                    child: Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            controller:
                                urlFieldController, // Binds the text field to a controller
                            validator: (value) {
                              // checking url is valid

                              if (value?.isEmpty ?? true) {
                                return "Field cant be empty";
                              } else {
                                if (isValidUrl(value.toString())) {
                                  return null;
                                } else {
                                  return "Enter a valid url"; // if not valid then this message will appear
                                }
                              }
                            },
                            decoration: InputDecoration(
                                hintText: 'Image URL', // Placeholder text
                                border: border,
                                enabledBorder: border,
                                focusedBorder: border),
                          ).paddingOnly(right: 30), // Adds right padding
                        ),

                        // Button to set the image URL
                        ElevatedButton(
                          style: ButtonStyle(
                            iconColor: WidgetStatePropertyAll(Colors.black),
                            backgroundColor:
                                WidgetStatePropertyAll(Colors.white),
                            shape: WidgetStatePropertyAll(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10))),
                            side: WidgetStatePropertyAll(
                                BorderSide(color: Colors.black)), // Adds border
                          ),
                          onPressed: () {
                            if (formKey.currentState?.validate() ?? true) {
                              setState(() {
                                image = urlFieldController.text;
                                registerImageView();
                              });
                            }
                          },
                          child: const Padding(
                            padding: EdgeInsets.fromLTRB(
                                0, 12, 0, 12), // Sets padding
                            child: Icon(
                                Icons.arrow_forward), // Displays an arrow icon
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),

      // Floating Action Button (FAB) to open a fullscreen modal dialog
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
              context: context,
              builder: (builder) {
                return StatefulBuilder(builder: (context, setState) {
                  return AlertDialog(
                    content: SizedBox(
                      height: fullScreen
                          ? MediaQuery.of(context)
                              .size
                              .height // Fullscreen height
                          : null,
                      width: fullScreen
                          ? MediaQuery.of(context).size.width
                          : null, // Fullscreen width
                      child: Column(
                        mainAxisSize:
                            MainAxisSize.min, // Wraps content to min size
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              // Button to enter fullscreen
                              ElevatedButton.icon(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                icon: const Icon(Icons.fullscreen),
                                label: const Text("Enter full screen"),
                              ).paddingOnly(right: 20), // Adds spacing

                              // Button to exit fullscreen
                              ElevatedButton.icon(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                icon: const Icon(Icons.remove),
                                label: const Text("Exit full screen"),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  );
                });
              });
        },
        child: const Icon(Icons.add), // Button icon
      ),
    );
  }
}
