import 'package:flutter/material.dart';

class HotCommandsMenu extends StatelessWidget {
  const HotCommandsMenu({super.key, required this.onSelectCommand});

  final void Function(String command) onSelectCommand;

  @override
  Widget build(BuildContext context) {
    final commands = [
      'Título',
      'Subtítulo',
      'Lista',
      'Checklist',
      'Código',
      'Imagem',
      'Tabela',
    ];

    return Material(
      elevation: 4,
      borderRadius: BorderRadius.circular(8),
      color: Colors.grey[900],
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 200),
        child: ListView.separated(
          shrinkWrap: true,
          padding: const EdgeInsets.symmetric(vertical: 8),
          itemCount: commands.length,
          separatorBuilder:
              (_, __) => const Divider(height: 1, color: Colors.white12),
          itemBuilder: (context, index) {
            final command = commands[index];
            return InkWell(
              onTap: () => onSelectCommand(command),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 10,
                ),
                child: Text(
                  '$command',
                  style: const TextStyle(color: Colors.white),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
