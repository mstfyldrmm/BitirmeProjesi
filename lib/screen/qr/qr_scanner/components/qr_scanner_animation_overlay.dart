import '../../../../export.dart';

class CustomQrScannerOverlay extends StatefulWidget {
  final bool isScanning;
  const CustomQrScannerOverlay({super.key, required this.isScanning});

  @override
  State<CustomQrScannerOverlay> createState() => _CustomQrScannerOverlayState();
}

class _CustomQrScannerOverlayState extends State<CustomQrScannerOverlay>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _animation;

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat();

    _animation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _controller, curve: Curves.linear),
    );

    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double size = MediaQuery.of(context).size.width * 0.7;
    final double cornerLength = 30;
    final double strokeWidth = 4;

    return Center(
      child: SizedBox(
        width: size,
        height: size,
        child: Stack(
          children: [
            ..._buildCorners(size, cornerLength, strokeWidth),
            Visibility(
              visible: widget.isScanning,
              child: AnimatedBuilder(
                animation: _animation,
                builder: (context, child) {
                  return Positioned(
                    top: _animation.value * size,
                    left: 0,
                    right: 0,
                    child: Container(
                      height: 4,
                      width: size,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Colors.greenAccent.withOpacity(0.1),
                            Colors.greenAccent,
                            Colors.greenAccent.withOpacity(0.1),
                          ],
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> _buildCorners(double size, double length, double strokeWidth) {
    final color = Colors.white;
    return [
      // Top Left
      Positioned(
        top: 0,
        left: 0,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(width: length, height: strokeWidth, color: color),
            Container(width: strokeWidth, height: length, color: color),
          ],
        ),
      ),
      // Top Right
      Positioned(
        top: 0,
        right: 0,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Container(width: length, height: strokeWidth, color: color),
            Container(width: strokeWidth, height: length, color: color),
          ],
        ),
      ),
      // Bottom Left
      Positioned(
        bottom: 0,
        left: 0,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(width: strokeWidth, height: length, color: color),
            Container(width: length, height: strokeWidth, color: color),
          ],
        ),
      ),
      // Bottom Right
      Positioned(
        bottom: 0,
        right: 0,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Container(width: strokeWidth, height: length, color: color),
            Container(width: length, height: strokeWidth, color: color),
          ],
        ),
      ),
    ];
  }
}
