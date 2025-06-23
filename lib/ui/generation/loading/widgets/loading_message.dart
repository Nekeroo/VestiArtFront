import 'package:flutter/material.dart';

class LoadingMessage extends StatefulWidget {
  final String message;

  const LoadingMessage({super.key, required this.message});

  @override
  State<LoadingMessage> createState() => _LoadingMessageState();
}

class _LoadingMessageState extends State<LoadingMessage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  String _currentMessage = "";
  String _nextMessage = "";

  @override
  void initState() {
    super.initState();
    _currentMessage = widget.message;
    _controller = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );

    _animation = Tween<double>(
      begin: 1.0,
      end: 0.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
  }

  @override
  void didUpdateWidget(LoadingMessage oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.message != _currentMessage && widget.message != _nextMessage) {
      _nextMessage = widget.message;
      _controller.forward().then((_) {
        setState(() {
          _currentMessage = _nextMessage;
        });
        _controller.reverse();
      });
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Opacity(
          opacity: _animation.value,
          child: Text(
            _currentMessage,
            style: TextStyle(
              fontSize: 16,
              color: Theme.of(context).colorScheme.onSurface,
              fontWeight: FontWeight.w500,
            ),
            textAlign: TextAlign.center,
          ),
        );
      },
    );
  }
}
