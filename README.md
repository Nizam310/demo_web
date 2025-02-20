Image App Documentation

Overview

This project is a Flutter-based application that allows users to load and view an image from a URL. The app provides an interactive UI where users can enter an image URL, display the image, and enable full-screen viewing using the web platform's fullscreen API.

Features

Input an image URL to display an image.

Click on the displayed image to open it in full-screen mode (web only).

Provides an alert dialog with options to enter and exit full-screen mode.

Utilizes Flutter's HtmlElementView to embed web elements into the Flutter app.

Dependencies

This project makes use of the following Flutter packages:

flutter/material.dart - Core Flutter UI components.

dart:ui - Provides platform view registry.

universal_html/html.dart - Allows interaction with HTML elements.

nb_utils - Utility functions and extensions for Flutter widgets.

Code Breakdown

1. Home Widget

The Home widget is a StatefulWidget that manages the UI and interactions.

2. Variables

String image - Stores the image URL.

TextEditingController urlFieldController - Controls the text input field for the image URL.

bool fullScreen - Keeps track of the fullscreen mode status.

3. initState()

Registers a custom HTML view (fullscreen-image) using ui.platformViewRegistry.registerViewFactory.

Creates an ImageElement in HTML with styles and a double-click event listener to trigger full-screen mode.

4. build() Method

Builds a UI with an input field for the image URL and a button to load the image.

Displays the image using HtmlElementView if a valid URL is provided.

Provides a floating action button that opens a dialog with full-screen options.

5. AlertDialog for Fullscreen Options

Displays buttons to enter and exit full-screen mode.

Usage Instructions

Run the Flutter web project.

Enter an image URL in the text field.

Click the arrow button to display the image.

Double-click the image to enter full-screen mode.

Use the floating action button to open the full-screen options dialog.

Platform Compatibility

This project is designed specifically for Flutter web due to the use of HtmlElementView and the fullscreen API.