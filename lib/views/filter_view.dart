import 'package:flutter/material.dart';
import 'package:lets_enlist/controllers/enlist_controller.dart';
import 'package:lets_enlist/controllers/find_controller.dart';
import 'package:lets_enlist/utilities/value.dart';
import 'package:lets_enlist/utilities/widget.dart';
import 'package:lets_enlist/views/search_view.dart';

class FilterView extends StatefulWidget {
  const FilterView({super.key});

  @override
  State<FilterView> createState() => _FilterViewState();
}

class _FilterViewState extends State<FilterView> {
  @override
  Widget build(BuildContext context) {
    TextTheme tt = Theme.of(context).textTheme;
    ColorScheme cs = Theme.of(context).colorScheme;

    SearchBar _buildSearchBar() {
      return SearchBar(
        hintStyle: WidgetStatePropertyAll(
          tt.bodySmall?.copyWith(
            color: cs.onSurfaceVariant,
          ),
        ),
        textStyle: WidgetStatePropertyAll(
          tt.bodySmall?.copyWith(
            color: cs.onSurface,
          ),
        ),
        controller: FindController.mainViewKeywordController,
        hintText: FindController.keyword.isEmpty
            ? '찾으시는 모집병이 있나요?'
            : FindController.keyword,
        leading: const Icon(Icons.search),
        trailing: [
          IconButton(
            onPressed: () {
              setState(() {
                FindController.clearKeyword();
              });
            },
            icon: const Icon(Icons.close),
          ),
        ],
        onChanged: (String keyword) {
          FindController.keyword = keyword;
        },
        onSubmitted: (_) {
          EnlistController.fetchFoundEnlists();
          EnlistController.filterFoundEnlists();
          EnlistController.sortFilteredFoundEnlists();

          Navigator.push(
            context,
            PageRouteBuilder(
              pageBuilder: (context, a, b) => const SearchView(),
              transitionDuration: Duration.zero,
              reverseTransitionDuration: Duration.zero,
            ),
          ).then(
            (_) {
              setState(() {});
            },
          );
        },
      );
    }

    Widget _buildSearchContainer() {
      return Row(
        children: [
          Expanded(
            child: _buildSearchBar(),
          )
        ],
      );
    }

    Row _buildBranchPicker() {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            '군종',
            style: (tt.labelSmall)?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          DropdownMenu<Branch>(
            inputDecorationTheme: const InputDecorationTheme(
              outlineBorder: BorderSide.none,
              border: InputBorder.none,
            ),
            initialSelection: FindController.branch,
            textStyle: (tt.labelSmall)?.copyWith(
              fontWeight: FontWeight.bold,
            ),
            dropdownMenuEntries: Branch.values
                .map(
                  (Branch branch) => DropdownMenuEntry(
                    value: branch,
                    label: branch.nameKor,
                  ),
                )
                .toList(),
            onSelected: (dynamic d) {
              setState(() {
                FindController.branch = d;
              });
            },
          ),
        ],
      );
    }

    Row _buildInterViewTypePicker() {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            '면접',
            style: (tt.labelSmall)?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          DropdownMenu<InterviewType>(
            inputDecorationTheme: const InputDecorationTheme(
              outlineBorder: BorderSide.none,
              border: InputBorder.none,
            ),
            initialSelection: FindController.interviewType,
            textStyle: (tt.labelSmall)?.copyWith(
              fontWeight: FontWeight.bold,
            ),
            dropdownMenuEntries: InterviewType.values
                .map(
                  (InterviewType interviewType) => DropdownMenuEntry(
                    value: interviewType,
                    label: interviewType.name,
                  ),
                )
                .toList(),
            onSelected: (dynamic d) {
              setState(() {
                FindController.interviewType = d;
              });
            },
          ),
        ],
      );
    }

    Widget _buildDischargeDateTimePicker() {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            '전역일',
            style: (tt.labelSmall)?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          buildSizedBox(16),
          ElevatedButton(
            onPressed: () async {
              FindController.dischargeDateTimeRange = await showDateRangePicker(
                    context: context,
                    firstDate:
                        FindController.initialDischargeDateTimeRange.start,
                    currentDate: DateTime.now(),
                    lastDate: FindController.initialDischargeDateTimeRange.end,
                    initialDateRange: FindController.dischargeDateTimeRange,
                    initialEntryMode: DatePickerEntryMode.input,
                  ) ??
                  FindController.dischargeDateTimeRange;

              setState(() {});
            },
            child: Text(
              FindController.dischargeDateTimeRange ==
                      FindController.initialDischargeDateTimeRange
                  ? '전체'
                  : '${FindController.dischargeDateTimeRange.start.toString().substring(0, 10)} ~ ${FindController.dischargeDateTimeRange.end.toString().substring(0, 10)}',
              style: (tt.labelSmall)?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
          )
        ],
      );
    }

    Widget _buildEnlistDateTimePicker() {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            '입대일',
            style: (tt.labelSmall)?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          buildSizedBox(16),
          ElevatedButton(
            onPressed: () async {
              FindController.enlistDateTimeRange = await showDateRangePicker(
                    context: context,
                    firstDate: FindController.initialEnlistDateTimeRange.start,
                    currentDate: DateTime.now(),
                    lastDate: FindController.initialEnlistDateTimeRange.end,
                    initialDateRange: FindController.enlistDateTimeRange,
                    initialEntryMode: DatePickerEntryMode.input,
                  ) ??
                  FindController.enlistDateTimeRange;

              setState(() {});
            },
            child: Text(
              FindController.enlistDateTimeRange ==
                      FindController.initialEnlistDateTimeRange
                  ? '전체'
                  : '${FindController.enlistDateTimeRange.start.toString().substring(0, 10)} ~ ${FindController.enlistDateTimeRange.end.toString().substring(0, 10)}',
              style: (tt.labelSmall)?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
          )
        ],
      );
    }

    Widget _buildSearchButton() {
      return FilledButton(
        onPressed: () {
          EnlistController.fetchFoundEnlists();
          EnlistController.filterFoundEnlists();
          EnlistController.sortFilteredFoundEnlists();

          Navigator.push(
            context,
            PageRouteBuilder(
              pageBuilder: (context, a, b) => const SearchView(),
              transitionDuration: Duration.zero,
              reverseTransitionDuration: Duration.zero,
            ),
          ).then(
            (_) {
              setState(() {});
            },
          );
        },
        child: const Text('검색'),
      );
    }

    Widget _buildResetButton() {
      return OutlinedButton(
        onPressed: () {
          setState(() {
            FindController.clear();
          });
        },
        child: const Text('초기화'),
      );
    }

    return Scaffold(
      appBar: const buildAppBar(),
      // floatingActionButton: const buildFloatingActionButton(),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: MOBILEPADDING,
          vertical: 16,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                _buildSearchContainer(),
                buildSizedBox(16),
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      _buildBranchPicker(),
                      _buildInterViewTypePicker(),
                      buildSizedBox(8),
                      _buildEnlistDateTimePicker(),
                      buildSizedBox(16),
                      _buildDischargeDateTimePicker(),
                    ],
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: _buildResetButton(),
                ),
                buildSizedBox(32),
                Expanded(
                  child: _buildSearchButton(),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
