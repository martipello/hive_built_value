import 'package:hive_built_value/hive_built_value.dart';

/// Not part of public API
class IgnoredTypeAdapter<T> implements TypeAdapter<T?> {
  const IgnoredTypeAdapter([this.typeId = 0]);

  @override
  final int typeId;

  @override
  T? read(BinaryReader reader) => null;

  @override
  void write(BinaryWriter writer, obj) {}
}
