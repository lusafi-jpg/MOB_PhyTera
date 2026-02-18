import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:latlong2/latlong.dart';
import '../../domain/models/field_model.dart';
import '../providers/field_provider.dart';
import '../../../../core/constants/app_colors.dart';

class MapScreen extends ConsumerStatefulWidget {
  const MapScreen({super.key});

  @override
  ConsumerState<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends ConsumerState<MapScreen> {
  final MapController _mapController = MapController();
  final LatLng _center = const LatLng(-4.4419, 15.2663); // Kinshasa

  @override
  Widget build(BuildContext context) {
    final fieldState = ref.watch(fieldMapProvider);
    final savedFieldsAsync = ref.watch(savedFieldsProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Carte des Champs'),
        actions: [
          IconButton(
            icon: const Icon(Icons.list),
            onPressed: () =>
                _showSavedFieldsList(context, savedFieldsAsync, ref),
          ),
          if (fieldState.currentPoints.isNotEmpty)
            IconButton(
              icon: const Icon(Icons.undo),
              onPressed: () {
                ref.read(fieldMapProvider.notifier).undoLastPoint();
              },
            ),
        ],
      ),
      body: Stack(
        children: [
          FlutterMap(
            mapController: _mapController,
            options: MapOptions(
              initialCenter: _center,
              initialZoom: 15.0,
              onTap: (tapPosition, point) {
                ref.read(fieldMapProvider.notifier).addPoint(point);
              },
            ),
            children: [
              TileLayer(
                urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                userAgentPackageName: 'com.example.phytera_mobile',
              ),
              // Saved Fields Layer
              savedFieldsAsync.when(
                data: (fields) => PolygonLayer(
                  polygons: fields.map((field) {
                    return Polygon(
                      points: field.points,
                      color: Colors.green.withValues(alpha: 0.3),
                      borderColor: Colors.green,
                      borderStrokeWidth: 2,
                      label: field.name,
                      labelStyle: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    );
                  }).toList(),
                ),
                loading: () => const SizedBox.shrink(),
                error: (error, stack) => const SizedBox.shrink(),
              ),
              // Current Drawing Layer
              if (fieldState.currentPoints.isNotEmpty)
                PolygonLayer(
                  polygons: [
                    Polygon(
                      points: fieldState.currentPoints,
                      color: Colors.blue.withValues(alpha: 0.3),
                      borderColor: Colors.blue,
                      borderStrokeWidth: 2,
                      // isDotted: fieldState.currentPoints.length < 3, // Removed as it is not supported
                    ),
                  ],
                ),
              if (fieldState.currentPoints.isNotEmpty)
                MarkerLayer(
                  markers: fieldState.currentPoints.map((p) {
                    return Marker(
                      point: p,
                      width: 10,
                      height: 10,
                      child: Container(
                        decoration: const BoxDecoration(
                          color: Colors.blue,
                          shape: BoxShape.circle,
                        ),
                      ),
                    );
                  }).toList(),
                ),
            ],
          ),

          // Controls / Info Panel
          Positioned(
            bottom: 20,
            left: 20,
            right: 20,
            child: Card(
              color: AppColors.surface.withValues(alpha: 0.9),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (fieldState.currentPoints.isNotEmpty) ...[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Surface:',
                                style: Theme.of(context).textTheme.titleSmall,
                              ),
                              Text(
                                '${fieldState.currentArea.toStringAsFixed(2)} m²',
                                style: Theme.of(context).textTheme.headlineSmall
                                    ?.copyWith(
                                      fontWeight: FontWeight.bold,
                                      color: AppColors.primary,
                                    ),
                              ),
                              Text(
                                '(${(fieldState.currentArea / 10000).toStringAsFixed(4)} hectares)',
                                style: Theme.of(context).textTheme.bodySmall,
                              ),
                            ],
                          ),
                          ElevatedButton.icon(
                            onPressed: fieldState.currentPoints.length >= 3
                                ? () => _showSaveDialog(context, ref)
                                : null,
                            icon: const Icon(Icons.save),
                            label: const Text('Enregistrer'),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      SizedBox(
                        width: double.infinity,
                        child: OutlinedButton(
                          onPressed: () {
                            ref
                                .read(fieldMapProvider.notifier)
                                .clearCurrentField();
                          },
                          style: OutlinedButton.styleFrom(
                            foregroundColor: Colors.red,
                            side: const BorderSide(color: Colors.red),
                          ),
                          child: const Text('Effacer le tracé actuel'),
                        ),
                      ),
                    ] else ...[
                      const Text(
                        'Tap sur la carte pour délimiter un champ',
                        style: TextStyle(fontStyle: FontStyle.italic),
                      ),
                    ],
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showSavedFieldsList(
    BuildContext context,
    AsyncValue<List<FieldModel>> savedFieldsAsync,
    WidgetRef ref,
  ) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Container(
          padding: const EdgeInsets.all(16),
          height: MediaQuery.of(context).size.height * 0.5,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Mes Champs Sauvegardés',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 16),
              Expanded(
                child: savedFieldsAsync.when(
                  data: (fields) {
                    if (fields.isEmpty) {
                      return const Center(
                        child: Text('Aucun champ enregistré.'),
                      );
                    }
                    return ListView.builder(
                      itemCount: fields.length,
                      itemBuilder: (context, index) {
                        final field = fields[index];
                        return Card(
                          margin: const EdgeInsets.only(bottom: 8),
                          child: ListTile(
                            leading: const Icon(
                              Icons.grass,
                              color: Colors.green,
                            ),
                            title: Text(field.name),
                            subtitle: Text(
                              '${(field.areaInfo / 10000).toStringAsFixed(4)} ha',
                            ),
                            trailing: IconButton(
                              icon: const Icon(Icons.delete, color: Colors.red),
                              onPressed: () {
                                ref
                                    .read(fieldRepositoryProvider)
                                    .deleteField(field.id);
                                // ignore: unused_result
                                ref.refresh(savedFieldsProvider);
                                Navigator.pop(
                                  context,
                                ); // Close and reopen to refresh or just ref.refresh
                                // Actually ref.refresh updates the provider, so just rebuilding is needed
                                // But since we are inside a showModalBottomSheet builder, it might not rebuild
                                // if the provider is watched in the parent.
                                // Better to let the parent rebuild pass down new data or use Consumer in the sheet.
                                // For simplicity popping is fine, or valid riverpod usage.
                              },
                            ),
                            onTap: () {
                              // Optional: Fit bounds to this field
                              Navigator.pop(context);
                              // TODO: Implement fit bounds if needed
                            },
                          ),
                        );
                      },
                    );
                  },
                  loading: () =>
                      const Center(child: CircularProgressIndicator()),
                  error: (e, _) => Center(child: Text('Erreur: $e')),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void _showSaveDialog(BuildContext context, WidgetRef ref) {
    final textController = TextEditingController();
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Nommer votre champ'),
        content: TextField(
          controller: textController,
          decoration: const InputDecoration(hintText: 'Ex: Champ de maïs Nord'),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Annuler'),
          ),
          ElevatedButton(
            onPressed: () {
              if (textController.text.isNotEmpty) {
                ref
                    .read(fieldMapProvider.notifier)
                    .saveCurrentField(textController.text);
                Navigator.pop(ctx);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Champ enregistré avec succès!'),
                  ),
                );
              }
            },
            child: const Text('Sauvegarder'),
          ),
        ],
      ),
    );
  }
}
