//go:generate go run github.com/csnewman/flutter-go-bridge/cmd/flutter-go-bridge generate --src example.go --go bridge/example.gen.go --dart ../lib/example.gen.dart
package example

func Add(a, b int) int {
    return a + b
}

func EnforceBinding() {}