# flappy_translator

A tool which automatically generates Flutter localization resources from CSV and Excel files.

This is especially useful as any team member can edit the CSV/Excel file, with the subsequent translations imported into the project with the use of a simple terminal command. This contrasts starkly to the default i18n approach in which dart files need to be manually for new keys and languages. More information can be found in [Internationalizing Flutter apps](https://flutter.dev/docs/development/accessibility-and-localization/internationalization#an-alternative-class-for-the-apps-localized-resources).

Note that as of version 2.0.0, null sae code is generated. Please use version 1.5.0 for non-null safe projects.

## Getting Started

In order to use the *flappy_translator* package, please provide your translations in a CSV or Excel file. For CSV files, delimiters `,` and `;` have been tested to work.

The following table is used in the [example](example/) project:

| keys | fr | en | es | de_CH |
| ---- | -- | -- | -- | ----- |
| appTitle | Ma super application | My awesome application | Mi gran application | Meine tolle App |
| subtitle | Un sous titre | A subtitle | Un subtitulò | Ein Untertitel |
| description | Un texte avec une variable : %1$s | Text with a variable: %1$s | Un texto con una variable : %1$s | Text mit einer Variable: %1$s |
| littleTest | "Voici, pour l'exemple, ""un test"" avec la variable %age$d" | "Here is, for the example, ""a test"" with the variable %age$d" | "Aqui esta, por ejemplo, ""una prueba"" con la variable %age$d" | "Hier ist, zum Beispiel, ""ein Test"" mit der Variable %age$d" |

### Add dependency

```yaml
dependencies:
  flutter_localizations:
    sdk: flutter
    
dev_dependencies: 
  flappy_translator: 
```

Note that *flappy_translator* requires dart sdk >= 2.12.

### Define Settings

Settings for *flappy_translator* must set in your project's *pubspec.yaml* file. `input_file_path` is the only required parameter.

```yaml
flappy_translator:
  input_file_path: "test.csv"
  output_dir: "lib"
  file_name: "i18n"
  class_name: "I18n"
  delimiter: ","
  start_index: 1
  depend_on_context: true
  use_single_quotes: false
  replace_no_break_spaces: false
  expose_get_string: false
  expose_loca_strings: false
  expose_locale_maps: false
```

| Setting                 | Default | Description                                                                        |
| ----------------------- | ------- | ---------------------------------------------------------------------------------- |
| input_file_path         | N/A     | Required. A path to the input CSV/Excel file.                                      |
| output_dir              | lib     | A directory to generate the output file.                                           |
| file_name               | i18n    | A filename for the generated file.                                                 |
| class_name              | I18n    | A class name for the generated file.                                               |
| delimiter               | ,       | CSV files only: a delimited to separate columns in the input CSV file.             |
| start_index             | 1       | The column index where translations begin (i.e. column index of default language). |
| depend_on_context       | true    | Whether the generated localizations should depend on *BuildContext*                |
| use_single_quotes       | false   | Whether the generated file should use single or double quotes for strings.         |
| replace_no_break_spaces | false   | Whether no break spaces (\u00A0) should be replaced with normal spaces (\u0020).   |
| expose_get_string       | false   | The default value for whether a getString method should be exposed.                |
| expose_loca_strings     | false   | The default value for whether a locaStrings getter should be exposed.              |
| expose_locale_maps      | false   | The default value for whether a localeMaps getter should be exposed.               |

### Run package

Make sure that your current working directory is the project root.

```sh
flutter pub get
flutter pub run flappy_translator
```

### Update iOS Info.plist

For iOS, *ios/Runner/Info.plist* needs to be updated with an array of the languages that the app will supports:

```plist
<key>CFBundleLocalizations</key>
<array>
  <string>fr</string>
  <string>en</string>
  <string>es</string>
  <string>de</string>
</array>
```

For more information, see [Internationalizing Flutter apps](https://flutter.dev/docs/development/accessibility-and-localization/internationalization#appendix-updating-the-ios-app-bundle).

### Use the i18n generated file

The package used your input file in order to generate a file named *file_name* in *output_dir* you provided. The following example uses the default *class_name* I18n with a dependency on *BuildContext*.

Firstly, add the I18nDelegate to your delegates:

```dart
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: [
        const I18nDelegate(),
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: I18nDelegate.supportedLocals,
      home: Home(),
    );
  }
}
```

Then use the generated I18n class!

```dart
class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            children: <Widget>[
              Text(I18n.of(context).appTitle),
              Text(I18n.of(context).description(var1: 2)),
              Text(I18n.of(context).littleTest(age: 32)),
            ],
          ),
        ),
      ),
    );
  }
}
```

Please see [example](example/) for more information.

### Material Localizations

Supporting a language (i.e. ga or cy) not included in GlobalMaterialLocalizations requires adding a material localization class and delegate. Although this is out of the scope of this package, a warning is logged to the console during code generation. [More info](https://flutter.dev/docs/development/accessibility-and-localization/internationalization#adding-support-for-a-new-language).

## Rules and functionalities

### Locale

Locales are specified in the top row and are expected to be given in the form `en` or `en_US`.

### Default language

The column at `start_index` is considered the default language. This means that:

1. This column must be completely filled, otherwise an error is printed to the console and code generation will not succeed.
2. If another language does not have translations for a given key, the value of the default language will be used.

### Keys

Each loca key must begin with a lowercase letter, after which any combinations of lowercase, uppercase, digits or underscores are valid.

### Add variables in Strings

We added the possibility to handle variables in the Strings.
This means respecting some rules : 

1. In order to be able to recognize them, you must write them this way :

* %myVariable$d (`d` stands for an int type)
* %myVariable$s (`s` stands for a String type)

2. if your variable's name start with a number, the generated name will be `varmyVariable`
Otherwise, the generated variable name would be the name you provided.

* `%1$d` becomes `var1`
* `%age$d` becomes `age`

3. Variables are required in the generated dart code

Let's take the example of the `description` String in the CSV we used.

The generated function signature will be :

```dart
String description({
  @required String var1,
})
```
