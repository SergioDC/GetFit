import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

import 'log.dart';
import 'log.service.dart';
import 'log.view.item.dart';

class LogView extends StatefulWidget {
  const LogView({super.key});

  static MaterialPageRoute route() =>
      MaterialPageRoute<void>(builder: (BuildContext _) => const LogView());

  static (Color color, IconData icon) getLogStyle(LogLevel level) {
    switch (level) {
      case LogLevel.data:
        return (Colors.blue, Icons.storage);
      case LogLevel.info:
        return (Colors.green, Icons.info);
      case LogLevel.warning:
        return (Colors.orange, Icons.warning);
      case LogLevel.error:
        return (Colors.red, Icons.error);
      default:
        return (Colors.white, Icons.help);
    }
  }

  @override
  LogViewState createState() => LogViewState();
}

class LogViewState extends State<LogView> with SingleTickerProviderStateMixin {
  bool _isFilterPanelVisible = false;

  // Filter criteria
  LogLevel _selectedLogLevel = LogLevel.data;
  DateTime? _selectedDate;
  List<String> _searchTerms = [];

  // Animation controller for smooth transitions
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
// Initialize animation controller
    _controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 300));
    _animation = CurvedAnimation(parent: _controller, curve: Curves.easeInOut);
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _toggleFilterPanel() {
    setState(() {
      _isFilterPanelVisible = !_isFilterPanelVisible;
      if (_isFilterPanelVisible) {
        _controller.forward();
      } else {
        _controller.reverse();
      }
    });
  }

  void _clearFilters() {
    setState(() {
      _selectedLogLevel = LogLevel.data;
      _selectedDate = null;
      _searchTerms.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Logs'),
        actions: [
          IconButton(
            icon: Icon(_isFilterPanelVisible ? Icons.close : Icons.filter_list),
            onPressed: _toggleFilterPanel,
            tooltip: _isFilterPanelVisible ? 'Close Filters' : 'Open Filters',
          ),
        ],
      ),
      body: Column(
        children: [
          SizeTransition(
            sizeFactor: _animation,
            axisAlignment: -1.0,
            child: _isFilterPanelVisible
                ? _buildFilterPanel()
                : const SizedBox.shrink(),
          ),
          Expanded(child: _buildLogList()),
        ],
      ),
    );
  }

  Widget _buildFilterPanel() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Card(
        elevation: 4.0,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
        child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: Column(
            // mainAxisSize: MainAxisSize.min,
            children: [
              // Header with Icon
              const Row(
                children: [
                  Icon(Icons.filter_alt, color: Colors.blue),
                  SizedBox(width: 8.0),
                  Text(
                    'Filters',
                    style:
                        TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              const Divider(color: Colors.grey),
              const SizedBox(height: 2.0),
              // Log Level Filter
              _buildLogLevelFilter(),
              const SizedBox(height: 4.0),
              // Log Date Filter
              _buildLogDateFilter(),
              const SizedBox(height: 4.0),
              // Log String Filter
              _buildLogStringFilter(),
              const SizedBox(height: 4.0),
              // Clear Filters Button
              Align(
                alignment: Alignment.centerRight,
                child: FilledButton.icon(
                  onPressed: _clearFilters,
                  icon: const Icon(Icons.clear),
                  label: const Text('Clear Filters'),
                  style: FilledButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.redAccent,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLogLevelFilter() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Log Level',
          style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 4.0),
        DropdownButtonFormField<LogLevel>(
          value: _selectedLogLevel,
          decoration: InputDecoration(
            prefixIcon: const Icon(Icons.priority_high),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 12.0, vertical: 0.0),
          ),
          hint: const Text('Select Minimum Level'),
          items: LogLevel.values
              .where((level) => level != LogLevel.none)
              .map((level) => DropdownMenuItem(
                    value: level,
                    child: Text(level.name.toUpperCase()),
                  ))
              .toList(),
          onChanged: (level) {
            setState(() {
              _selectedLogLevel = level!;
            });
          },
        ),
      ],
    );
  }

  Widget _buildLogDateFilter() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Log Date',
          style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 4.0),
        Row(
          children: [
            Expanded(
              child: FilledButton.icon(
                onPressed: () async {
                  DateTime? picked = await showDatePicker(
                    context: context,
                    initialDate: _selectedDate ?? DateTime.now(),
                    firstDate: DateTime(2000),
                    lastDate: DateTime.now(),
                  );
                  if (picked != null) {
                    setState(() {
                      _selectedDate = picked;
                    });
                  }
                },
                icon: const Icon(Icons.calendar_today),
                label: Text(_selectedDate == null
                    ? 'Select Date'
                    : DateFormat.yMMMMd().format(_selectedDate!)),
                style: FilledButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 4.0),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0)),
                ),
              ),
            ),
            if (_selectedDate != null)
              IconButton(
                icon: const Icon(Icons.clear, color: Colors.redAccent),
                onPressed: () {
                  setState(() {
                    _selectedDate = null;
                  });
                },
                tooltip: 'Clear Date Filter',
              ),
          ],
        ),
      ],
    );
  }

  Widget _buildLogStringFilter() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Search Terms',
          style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 4.0),
        TextFormField(
          initialValue: _searchTerms.join(', '),
          decoration: InputDecoration(
            prefixIcon: const Icon(Icons.search),
            hintText: 'Enter terms separated by comma',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 12.0, vertical: 0.0),
          ),
          onChanged: (value) {
            setState(() {
              _searchTerms = value
                  .split(',')
                  .map((term) => term.trim())
                  .where((term) => term.isNotEmpty)
                  .toList();
            });
          },
        ),
        const SizedBox(height: 4.0),
        if (_searchTerms.isNotEmpty)
          Wrap(
            spacing: 8.0,
            children: _searchTerms
                .map((term) => Chip(
                      label: Text(term),
                      onDeleted: () {
                        setState(() {
                          _searchTerms.remove(term);
                        });
                      },
                    ))
                .toList(),
          ),
      ],
    );
  }

  Widget _buildLogList() {
    return Consumer<LogService>(
      builder: (context, logService, child) {
        List<Log> filteredLogs = _applyFilters(logService.logBuffer);

        // Sort logs by timestamp descending
        filteredLogs.sort((a, b) => b.timestamp!.compareTo(a.timestamp!));

        return ListView.builder(
          itemCount: filteredLogs.length,
          itemBuilder: (context, index) {
            Log log = filteredLogs[index];
            return LogViewItem(log: log);
          },
        );
      },
    );
  }

  List<Log> _applyFilters(List<Log> logs) {
    return logs.where((log) {
      // Filter by log level
      if (log.level.index < _selectedLogLevel.index) {
        return false;
      }

      // Filter by date
      if (_selectedDate != null) {
        DateTime logDate = DateTime(
            log.timestamp!.year, log.timestamp!.month, log.timestamp!.day);
        DateTime selected = DateTime(
            _selectedDate!.year, _selectedDate!.month, _selectedDate!.day);
        if (logDate != selected) {
          return false;
        }
      }

      // Filter by search terms
      if (_searchTerms.isNotEmpty) {
        bool matchesAll = _searchTerms.every((term) =>
            log.message.toLowerCase().contains(term.toLowerCase()) ||
            log.param.toLowerCase().contains(term.toLowerCase()));
        if (!matchesAll) {
          return false;
        }
      }

      return true;
    }).toList();
  }
}
