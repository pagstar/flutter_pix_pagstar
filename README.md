Certainly! Here's the updated README with the necessary instructions:

# Flutter Pix Pagstar Package

This is a Flutter package created by the company Pagstar to facilitate the creation of Pix transactions. This package follows an MVC architecture with the repository pattern and uses the maximum of Flutter's native resources with a minimum amount of external packages to avoid excessive dependencies.

## Prerequisites

Before you can use this package, you must first request access to the Pagstar sandbox environment to obtain the required credentials (`authorizationToken` and `tenantId`). You can do this by completing the registration at [Pagstar Sandbox](https://pagstar.gitbook.io/api-docs/welcome/sandbox). After completing the registration, you'll receive the necessary credentials to initialize the package.

## Installation

To install the package, add the following line to your project's `pubspec.yaml`:

```yaml
dependencies:
   flutter_pix_pagstar: ^0.0.1
```

After that run `flutter pub get` to get the package.

## Usage

Before using the package, it is necessary to initialize it with the `init()` function. This function takes two strings, `authorization` and `tenantId`, which are used for API requests.

```dart
FlutterPixPagstar.init('your_authorization_token', 'your_tenant_id');
```

### Change Theme

To customize the appearance of the package, you can use the `setTheme()` function, which takes a `ThemeData`.

```dart
FlutterPixPagstar.setTheme(ThemeData.dark());
```

### Generate Transaction Without Screen

To generate a transaction without returning a screen, you must call the `generateTransaction()` function. It receives a `PixTransactionModel` model (the name and document are optional to create a transaction, if you do not pass those arguments, an anonymous transaction will be created).

```dart
FlutterPixPagstar.generateTransaction(
   PixTransactionModel(
     value: 100,
     tenantId: 'your_tenant_id',
     name: 'your_name',
     document: 'your_document',
     expiration: 600,
   ),
);
```

### Generate Transaction With Screen

If you need to generate a transaction and also present a screen, you can use the `generateTransactionWithScreen()` function. This function also accepts several parameters for customizing the transaction screen including `title`, `subtitle`, `cancelButtonLabel`, `successMessage`, and `returnButtonLabel`.

```dart
FlutterPixPagstar.generateTransactionWithScreen(
   context,
   PixTransactionModel(
     value: 100,
     tenantId: 'your_tenant_id',
     name: 'your_name',
     document: 'your_document',
     expiration: 600,
   ),
   'Title',
   'Button Label',
   'Feedback text',
   'Subtitle',
   'Cancel Button Label',
   'Success Message',
   'Return Button Label',
);
```

### Select Value Page

You can also open a page for the user to select the amount of a transaction. To do so, use the `selectValuePage()` function, which receives the strings `headerText`, `transactionTitle`, `transactionButtonLabel` and `feedbackText`.

```dart
FlutterPixPagstar.selectValuePage(
   context,
   'Header',
   'Transaction Title',
   'Transaction Button Label',
   'Feedback Text',
);
```

### Check Transaction

To check the status of a transaction, use the `checkTransaction()` function. This function takes a string `externalReference` which is the identifier of the transaction you want to check.

```dart
FlutterPixPagstar.checkTransaction('external_reference');
```

## Error handling

If an unexpected error occurs during a request or on the package page, a generic screen with the error message will be displayed.

Certainly! Here's an additional section that outlines the planned changes for the package regarding greater decoupling of the design for better customization:

## Planned Changes

We are continuously working to improve the Flutter Pix Pagstar Package, and one of our primary goals for future updates is to achieve a higher level of decoupling in the design components. This change aims to allow developers greater flexibility in personalizing the package's appearance and behavior.

## Support

If you encounter any issues or have any suggestions for improving this package, feel free to open an issue or pull request on GitHub.

We hope this package makes it easy to integrate Pix into your Flutter app!