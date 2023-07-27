# flutter_pix_pagstar Package

This is a Flutter package developed by Pagstar to simplify the creation of Pix transactions. The package adopts an MVC architecture with a repository pattern and utilizes Flutter's native capabilities with a minimal dependency on external packages to minimize dependency load.

## Installation

To install this package, insert the following line into your project's `pubspec.yaml`:

```yaml
dependencies:
   flutter_pix_pagstar: ^0.0.1
```

Subsequently, execute `flutter pub get` to fetch the package.

## Usage

Before utilizing the package, you must initialize it using the `init()` function. This function requires two strings, `authorizationToken` and `tenant`, which are utilized for API requests.

```dart
FlutterPixPagstar.init(authorizationToken: 'your_authorization_token', tenant: 'your_tenant_id');
```

### Change Theme

To customize the visual aspects of the package, you can leverage the `setTheme()` function, which accepts a `ThemeData`.

```dart
FlutterPixPagstar.setTheme(ThemeData.dark());
```

### Generate Transaction

To create a transaction, call the `generateTransaction()` function. It accepts a `PixTransactionModel` model along with the strings `title`, `buttonLabel`, `feedbackText`, `subtitle`, `cancelButtonLabel`, `successMessage`, and `returnButtonLabel`.

```dart
FlutterPixPagstar.generateTransactionWithScreen(
   context: context,
   model: PixTransactionModel(
     value: 100,
     tenantId: 'your_tenant_id',
     name: 'your_name',
     document: 'your_document',
     expiration: 600,
   ),
   title: 'Title',
   buttonLabel: 'Button Label',
   feedbackText: 'Feedback Text',
   subtitle: 'Subtitle',
   cancelButtonLabel: 'Cancel Button Label',
   successMessage: 'Success Message',
   returnButtonLabel: 'Return Button Label',
);
```

### Select Page Value

You can also launch a page to allow the user to determine the amount for a transaction. To do this, utilize the `selectValuePage()` function, which takes the strings `headerText`, `buttonText`, `subtitleText`, `transactionTitle`, `transactionButtonLabel`, `feedbackText`, `cancelButtonLabel`, `successMessage`, and `returnButtonLabel`.

```dart
FlutterPixPagstar.selectValuePage(
   context: context,
   headerText: 'Header',
   buttonText: 'Button Text',
   subtitleText: 'Subtitle Text',
   transactionTitle: 'Transaction Title',
   transactionButtonLabel: 'Transaction Button Label',
   feedbackText: 'Feedback Text',
   cancelButtonLabel: 'Cancel Button Label',
   successMessage: 'Success Message',
   returnButtonLabel: 'Return Button Label',
);
```

## Error handling

If an unexpected error arises during a request or on the package page, a generic screen with the error message will be displayed.

## Support

If you encounter any issues or have suggestions for enhancing this package, feel free to initiate an issue or pull request on GitHub.

We hope this package simplifies the process of integrating Pix into your Flutter application!