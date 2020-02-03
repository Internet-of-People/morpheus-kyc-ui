# Morpheus Common

This package contains common packages for Morpheus apps.

## IO

* **Authority/Ledger API:** DTO files and API endpoint factory
* **Native SDK:** utility class on top of the native SDK

## Utils

* **Logging:** logging utilities for more user friendly logs
* **Theming:** theming settings for Morpheus apps
* **Schema Form:**: widgets that can generate a form out of a Morpheus JsonSchema

## Development

### Building JSON Factories

For more info visit:
* https://flutter.dev/docs/development/data-and-backend/json
* https://github.com/dart-lang/json_serializable/tree/master/example

```bash
$ flutter pub run build_runner build
```