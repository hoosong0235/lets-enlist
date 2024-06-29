import 'package:flutter/material.dart';
import 'package:lets_enlist/controllers/enlist_controller.dart';
import 'package:lets_enlist/controllers/find_controller.dart';
import 'package:lets_enlist/utilities/color.dart';
import 'package:lets_enlist/utilities/value.dart';
import 'package:lets_enlist/utilities/widget.dart';

class SearchView extends StatefulWidget {
  const SearchView({super.key});

  @override
  State<SearchView> createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  @override
  Widget build(BuildContext context) {
    TextTheme tt = Theme.of(context).textTheme;

    Row _buildBranchPicker() {
      return Row(
        children: [
          Text(
            '군종',
            style: tt.labelLarge?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          buildSizedBox(16),
          DropdownMenu<Branch>(
            inputDecorationTheme: const InputDecorationTheme(
              outlineBorder: BorderSide.none,
              border: InputBorder.none,
            ),
            initialSelection: FindController.branch,
            textStyle: tt.labelLarge?.copyWith(
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
        children: [
          Text(
            '면접',
            style: tt.labelLarge?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          buildSizedBox(16),
          DropdownMenu<InterviewType>(
            inputDecorationTheme: const InputDecorationTheme(
              outlineBorder: BorderSide.none,
              border: InputBorder.none,
            ),
            initialSelection: FindController.interviewType,
            textStyle: tt.labelLarge?.copyWith(
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

    Expanded _buildDischargeDateTimePicker() {
      return Expanded(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '전역일',
              style: tt.labelLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            buildSizedBox(16),
            ElevatedButton(
              onPressed: () async {
                FindController.dischargeDateTimeRange =
                    await showDateRangePicker(
                          context: context,
                          firstDate: FindController
                              .initialDischargeDateTimeRange.start,
                          currentDate: DateTime.now(),
                          lastDate:
                              FindController.initialDischargeDateTimeRange.end,
                          initialDateRange:
                              FindController.dischargeDateTimeRange,
                        ) ??
                        FindController.dischargeDateTimeRange;

                setState(() {});
              },
              child: Text(
                FindController.dischargeDateTimeRange ==
                        FindController.initialDischargeDateTimeRange
                    ? '전체'
                    : '${FindController.dischargeDateTimeRange.start.toString().substring(0, 10)} ~ ${FindController.dischargeDateTimeRange.end.toString().substring(0, 10)}',
                style: tt.labelLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
            )
          ],
        ),
      );
    }

    Expanded _buildEnlistDateTimePicker() {
      return Expanded(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '입대일',
              style: tt.labelLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            buildSizedBox(16),
            ElevatedButton(
              onPressed: () async {
                FindController.enlistDateTimeRange = await showDateRangePicker(
                      context: context,
                      firstDate:
                          FindController.initialEnlistDateTimeRange.start,
                      currentDate: DateTime.now(),
                      lastDate: FindController.initialEnlistDateTimeRange.end,
                      initialDateRange: FindController.enlistDateTimeRange,
                    ) ??
                    FindController.enlistDateTimeRange;

                setState(() {});
              },
              child: Text(
                FindController.enlistDateTimeRange ==
                        FindController.initialEnlistDateTimeRange
                    ? '전체'
                    : '${FindController.enlistDateTimeRange.start.toString().substring(0, 10)} ~ ${FindController.enlistDateTimeRange.end.toString().substring(0, 10)}',
                style: tt.labelLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
            )
          ],
        ),
      );
    }

    Widget _buildSearchButton() {
      return FilledButton(
        onPressed: () {
          setState(() {
            EnlistController.findFoundEnlists();
          });
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

    SearchBar _buildSearchBar() {
      return SearchBar(
        controller: FindController.searchViewKeywordController,
        elevation: const WidgetStatePropertyAll(0),
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
          setState(() {
            EnlistController.findFoundEnlists();
          });
        },
      );
    }

    Card _buildSearchCard() {
      return Card(
        color: WHITE,
        elevation: 4,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 16,
            horizontal: 32,
          ),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: _buildSearchBar(),
                  ),
                  buildSizedBox(32),
                  _buildSearchButton(),
                ],
              ),
              buildSizedBox(16),
              Row(
                children: [
                  _buildBranchPicker(),
                  buildSizedBox(32),
                  _buildInterViewTypePicker(),
                  buildSizedBox(32),
                  _buildEnlistDateTimePicker(),
                  buildSizedBox(32),
                  _buildDischargeDateTimePicker(),
                  buildSizedBox(32),
                  _buildResetButton(),
                ],
              ),
            ],
          ),
        ),
      );
    }

    // display filtered enlist
    Column _buildFoundEnlists() {
      return Column(
        children: List.generate(
          EnlistController.foundEnlists.length,
          (int i) => buildEnlist(
            enlistModel: EnlistController.foundEnlists[i],
          ),
        ),
      );
    }

    Column _buildList() {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '${FindController.keyword.isEmpty ? '' : '"${FindController.keyword}" '}검색 결과',
            style: tt.titleLarge,
          ),
          buildSizedBox(16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '총 ${EnlistController.foundEnlists.length} 건',
                style: tt.labelLarge,
              ),
              Row(
                children: [
                  DropdownMenu(
                    inputDecorationTheme: const InputDecorationTheme(
                      outlineBorder: BorderSide.none,
                      border: InputBorder.none,
                    ),
                    initialSelection: EnlistController.enlistType,
                    dropdownMenuEntries: EnlistType.values
                        .map(
                          (EnlistType enlistType) => DropdownMenuEntry(
                            value: enlistType,
                            label: enlistType.name,
                          ),
                        )
                        .toList(),
                    onSelected: (EnlistType? value) => setState(
                      () {
                        EnlistController.enlistType = value ?? EnlistType.CURRENT;
                      },
                    ),
                  ),
                  DropdownMenu(
                    inputDecorationTheme: const InputDecorationTheme(
                      outlineBorder: BorderSide.none,
                      border: InputBorder.none,
                    ),
                    initialSelection: SortType.RECOMMEND,
                    dropdownMenuEntries: SortType.values
                        .map(
                          (SortType sortType) => DropdownMenuEntry(
                            value: sortType,
                            label: sortType.name,
                          ),
                        )
                        .toList(),
                    onSelected: (SortType? value) => setState(
                      () {
                        EnlistController.sortFoundEnlists(
                          value ?? SortType.RECOMMEND,
                        );
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
          buildSizedBox(16),
          _buildFoundEnlists(),
        ],
      );
    }

    return Scaffold(
      appBar: const buildAppBar(),
      floatingActionButton: const buildFloatingActionButton(),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: PADDING,
              vertical: 48,
            ),
            child: Column(
              children: [
                _buildSearchCard(),
                buildSizedBox(48),
                _buildList(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
