import 'package:flutter/material.dart';
import 'package:lets_enlist/controllers/enlist_controller.dart';
import 'package:lets_enlist/controllers/find_controller.dart';
import 'package:lets_enlist/utilities/color.dart';
import 'package:lets_enlist/utilities/value.dart';
import 'package:lets_enlist/utilities/widget.dart';
import 'package:lets_enlist/views/filter_view.dart';

class SearchView extends StatefulWidget {
  const SearchView({super.key});

  @override
  State<SearchView> createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  @override
  Widget build(BuildContext context) {
    TextTheme tt = Theme.of(context).textTheme;

    double viewportWidth = MediaQuery.of(context).size.width;
    bool isMobile = viewportWidth <= WIDTHTRHESHOLD;

    Row _buildBranchPicker() {
      return Row(
        children: [
          Text(
            '군종',
            style: (isMobile ? tt.labelSmall : tt.labelLarge)?.copyWith(
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
            textStyle: (isMobile ? tt.labelSmall : tt.labelLarge)?.copyWith(
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
            style: (isMobile ? tt.labelSmall : tt.labelLarge)?.copyWith(
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
            textStyle: (isMobile ? tt.labelSmall : tt.labelLarge)?.copyWith(
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
              style: (isMobile ? tt.labelSmall : tt.labelLarge)?.copyWith(
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
                style: (isMobile ? tt.labelSmall : tt.labelLarge)?.copyWith(
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
              style: (isMobile ? tt.labelSmall : tt.labelLarge)?.copyWith(
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
                style: (isMobile ? tt.labelSmall : tt.labelLarge)?.copyWith(
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
            EnlistController.fetchFoundEnlists();
            EnlistController.filterFoundEnlists();
            EnlistController.sortFilteredFoundEnlists();
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
            EnlistController.fetchFoundEnlists();
            EnlistController.filterFoundEnlists();
            EnlistController.sortFilteredFoundEnlists();
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
          EnlistController.foundEnlistsSubList.length,
          (int i) => buildEnlist(
            enlistModel: EnlistController.foundEnlistsSubList[i],
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
            style: (isMobile ? tt.titleSmall : tt.titleLarge),
          ),
          buildSizedBox(16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '총 ${EnlistController.foundEnlistsList.length} 건',
                style: (isMobile ? tt.labelSmall : tt.labelLarge),
              ),
              Row(
                children: [
                  DropdownMenu(
                    inputDecorationTheme: const InputDecorationTheme(
                      outlineBorder: BorderSide.none,
                      border: InputBorder.none,
                    ),
                    initialSelection: EnlistController.filterType,
                    textStyle:
                        (isMobile ? tt.labelSmall : tt.labelLarge)?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                    dropdownMenuEntries: FilterType.values
                        .map(
                          (FilterType enlistType) => DropdownMenuEntry(
                            value: enlistType,
                            label: enlistType.name,
                          ),
                        )
                        .toList(),
                    onSelected: (FilterType? value) => setState(
                      () {
                        EnlistController.filterType =
                            value ?? FilterType.CURRENT;
                        EnlistController.filterFoundEnlists();
                        EnlistController.sortFilteredFoundEnlists();
                      },
                    ),
                  ),
                  DropdownMenu(
                    inputDecorationTheme: const InputDecorationTheme(
                      outlineBorder: BorderSide.none,
                      border: InputBorder.none,
                    ),
                    initialSelection: EnlistController.sortType,
                    textStyle:
                        (isMobile ? tt.labelSmall : tt.labelLarge)?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
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
                        EnlistController.sortType = value ?? SortType.RECOMMEND;
                        EnlistController.sortFilteredFoundEnlists();
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

    SearchBar _buildMobileSearchBar() {
      return SearchBar(
        controller: FindController.mainViewKeywordController,
        elevation: const WidgetStatePropertyAll(4),
        hintText: FindController.keyword.isEmpty
            ? '찾으시는 모집병이 있나요?'
            : FindController.keyword,
        leading: const Icon(Icons.search),
        onTap: () => Navigator.push(
          context,
          PageRouteBuilder(
            pageBuilder: (context, a, b) => const FilterView(),
            transitionDuration: Duration.zero,
            reverseTransitionDuration: Duration.zero,
          ),
        ),
      );
    }

    Widget _buildMobileSearchContainer() {
      return Row(
        children: [
          Expanded(
            child: _buildMobileSearchBar(),
          ),
        ],
      );
    }

    return Scaffold(
      appBar: const buildAppBar(),
      floatingActionButton: const buildFloatingActionButton(),
      body: NotificationListener<ScrollNotification>(
        onNotification: (notification) {
          if (!EnlistController.isLoadingFoundEnlists &&
              notification.metrics.pixels ==
                  notification.metrics.maxScrollExtent) {
            setState(() {
              EnlistController.loadFoundEnlists();
            });
          }

          return true;
        },
        child: ListView(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal:
                    isMobile ? MOBILEPADDING : DESKTOPPADDING(viewportWidth),
                vertical: 48,
              ),
              child: Column(
                children: [
                  isMobile ? _buildMobileSearchContainer() : _buildSearchCard(),
                  buildSizedBox(48),
                  _buildList(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
