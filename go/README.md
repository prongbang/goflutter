# How to

## 1. Create go project

```shell
mkdir go && cd go && go mod init com.github.com/prongbang/example && mkdir bridge
```

## 2. Install fgb

```shell
go get github.com/csnewman/flutter-go-bridge/parser@v0.2.0
go get github.com/csnewman/flutter-go-bridge/generator@v0.2.0
go get github.com/csnewman/flutter-go-bridge/cmd/flutter-go-bridge@v0.2.0
```

## 3. Create a wrapper around your Go code.

```shell
//go:generate go run github.com/csnewman/flutter-go-bridge/cmd/flutter-go-bridge generate --src example.go --go bridge/bridge.gen.go --dart ../lib/bridge.gen.dart
package example
```

## 4. Generate bindings in the directory

```shell
go generate
```

```shell
2024/07/19 22:17:32 flutter-go-bridge generator
2024/07/19 22:17:32 Parsing
2024/07/19 22:17:32  - Package com.github.com/prongbang/example
2024/07/19 22:17:32    - File /Users/11283991/Development/Flutter/Workspaces/goflutter/go/example.go
2024/07/19 22:17:32 Processing
2024/07/19 22:17:32  - Type Point
2024/07/19 22:17:32  - Type Obj
2024/07/19 22:17:32  - Func Add
2024/07/19 22:17:32  - Func AddPoints
2024/07/19 22:17:32  - Func AddError
2024/07/19 22:17:32  - Func NewObj
2024/07/19 22:17:32  - Func ModifyObj
2024/07/19 22:17:32  - Func FormatObj
2024/07/19 22:17:32 Validating
2024/07/19 22:17:32  - Type Obj
2024/07/19 22:17:32  - Type Point
2024/07/19 22:17:32 Preparing
2024/07/19 22:17:32  - Type Point
2024/07/19 22:17:32    - Type used as value
2024/07/19 22:17:32  - Type Obj
2024/07/19 22:17:32    - Type used as ref
2024/07/19 22:17:32  - Func Add
2024/07/19 22:17:32  - Func AddPoints
2024/07/19 22:17:32  - Func AddError
2024/07/19 22:17:32  - Func NewObj
2024/07/19 22:17:32  - Func ModifyObj
2024/07/19 22:17:32  - Func FormatObj
2024/07/19 22:17:32 Generating
2024/07/19 22:17:32  - Go bridge/bridge.gen.go
2024/07/19 22:17:32  - Dart ../lib/bridge.gen.dart
```

## 5. Use the generated bindings from your Flutter/Dart application

## 6. Automate library building by integrating into flutter build.

- Manual building

```shell
make gen
make build
make pack
```

### Documents

https://github.com/csnewman/flutter-go-bridge/tree/master?tab=readme-ov-file#platform-building