List<List<T>> transformTo5x4<T>(List<List<T>> layout) {
  // Flatten the original layout into a single list
  final List<T> flattened = layout.expand((row) => row).toList();

  // Define the number of rows and columns for the transformed layout
  const int newRowLength = 5;

  // Create the transformed layout
  final List<List<T>> transformed = [];
  for (int i = 0; i < flattened.length; i += newRowLength) {
    transformed.add(flattened.sublist(
      i,
      i + newRowLength > flattened.length ? flattened.length : i + newRowLength,
    ));
  }

  return transformed;
}
