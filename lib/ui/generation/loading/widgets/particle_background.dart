import 'dart:math';
import 'package:flutter/material.dart';

class ParticleBackground extends StatefulWidget {
  final int particleCount;
  final Color color;

  const ParticleBackground({
    super.key,
    this.particleCount = 20,
    required this.color,
  });

  @override
  State<ParticleBackground> createState() => _ParticleBackgroundState();
}

class _ParticleBackgroundState extends State<ParticleBackground> {
  late List<Particle> _particles;
  final Random _random = Random();

  @override
  void initState() {
    super.initState();
    _particles = List.generate(
      widget.particleCount,
      (_) => Particle.random(_random),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: ParticlePainter(
        particles: _particles,
        color: widget.color,
      ),
      child: Container(),
    );
  }
}

class Particle {
  final Offset position;
  final double size;
  final double speed;
  final double angle;
  final double opacity;

  Particle({
    required this.position,
    required this.size,
    required this.speed,
    required this.angle,
    required this.opacity,
  });

  factory Particle.random(Random random) {
    return Particle(
      position: Offset(
        random.nextDouble() * 400 - 200,
        random.nextDouble() * 400 - 200,
      ),
      size: random.nextDouble() * 10 + 5,
      speed: random.nextDouble() * 0.2 + 0.1,
      angle: random.nextDouble() * 2 * pi,
      opacity: random.nextDouble() * 0.6 + 0.2,
    );
  }

  Particle move(double progress) {
    // Conversion du progress en un mouvement continu
    final double continuousProgress = progress * speed * 2;
    final double dx = cos(angle) * continuousProgress * 100;
    final double dy = sin(angle) * continuousProgress * 100;
    
    // Calcul de l'opacité pulsante
    final double opacityFactor = 0.5 + 0.5 * sin(continuousProgress * 2);
    
    return Particle(
      position: Offset(position.dx + dx, position.dy + dy),
      size: size,
      speed: speed,
      angle: angle,
      opacity: opacity * opacityFactor,
    );
  }
}

class ParticlePainter extends CustomPainter {
  final List<Particle> particles;
  final Color color;

  ParticlePainter({
    required this.particles,
    required this.color,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    
    for (final particle in particles) {
      final position = center + particle.position;
      
      if (position.dx < 0 || 
          position.dx > size.width || 
          position.dy < 0 || 
          position.dy > size.height) {
        continue;
      }
      
      final paint = Paint()
        ..color = color.withValues(alpha: particle.opacity)
        ..style = PaintingStyle.fill;
        
      canvas.drawCircle(position, particle.size, paint);
    }
  }

  @override
  bool shouldRepaint(ParticlePainter oldDelegate) => true;
}
