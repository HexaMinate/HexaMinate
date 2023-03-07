// ignore_for_file: non_constant_identifier_names

part of hexaminate_flutter;

Widget SaveWidget({
  Key? key,
  required Widget child,
  required void Function(RenderRepaintBoundary bytes) callback,
}) {
  if (key != null && key is GlobalKey) {
    BuildContext? boundarys = key.currentContext;
    if (boundarys != null) {
      RenderObject? getBoundary = boundarys.findRenderObject();
      if (getBoundary != null) {
        var boundary = getBoundary as RenderRepaintBoundary;
        print("aoks");
        callback(boundary);
      }
    }
    /*
    RenderRepaintBoundary boundary = key.currentContext?.findRenderObject() as RenderRepaintBoundary;
    boundary.toImage().then((image) async {
      ByteData? byteData = await image.toByteData(format: ui.ImageByteFormat.png);
      Uint8List pngBytes = byteData!.buffer.asUint8List();
      return callback(pngBytes);
    });

    */
  }
  return RepaintBoundary(
    key: key,
    child: child,
  );
}
