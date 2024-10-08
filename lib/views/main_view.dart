import 'package:flutter/material.dart';
import 'package:lets_enlist/controllers/enlist_controller.dart';
import 'package:lets_enlist/controllers/find_controller.dart';
import 'package:lets_enlist/models/enlist_model.dart';
import 'package:lets_enlist/utilities/color.dart';
import 'package:lets_enlist/utilities/value.dart';
import 'package:lets_enlist/utilities/widget.dart';
import 'package:lets_enlist/views/details_view.dart';
import 'package:lets_enlist/views/filter_view.dart';
import 'package:lets_enlist/views/search_view.dart';

class MainView extends StatefulWidget {
  const MainView({super.key});

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  // int _bannerIndex = 0;

  @override
  Widget build(BuildContext context) {
    TextTheme tt = Theme.of(context).textTheme;
    ColorScheme cs = Theme.of(context).colorScheme;

    // ignore: unused_local_variable
    // Timer _timer = Timer.periodic(const Duration(minutes: 1), (_) {
    //   setState(() {
    //     _bannerIndex = (_bannerIndex + 1) % 3;
    //   });
    // });

    double viewportWidth = MediaQuery.of(context).size.width;
    bool isMobile = viewportWidth <= WIDTHTRHESHOLD;

    Widget _buildImage() {
      return Image.asset(
        width: double.infinity,
        height: isMobile ? 384 : 512,
        'assets/banner0.png',
        fit: BoxFit.cover,
      );

      // return IndexedStack(
      //   index: _bannerIndex,
      //   children: [
      //     Image.asset(
      //       width: double.infinity,p
      //       height: 512,
      //       'assets/banner0.png',
      //       fit: BoxFit.fitWidth,
      //     ),
      //     Image.asset(
      //       width: double.infinity,
      //       height: 512,
      //       'assets/banner1.png',
      //       fit: BoxFit.fitWidth,
      //     ),
      //     Image.asset(
      //       width: double.infinity,
      //       height: 512,
      //       'assets/banner2.png',
      //       fit: BoxFit.fitWidth,
      //     ),
      //   ],
      // );
    }

    Text _buildHeadline() {
      return Text(
        '이때갈까 저때갈까\n입대할때 이때입대',
        style: (isMobile ? tt.headlineSmall : tt.headlineLarge)?.copyWith(
          fontWeight: FontWeight.bold,
          color: WHITE,
        ),
      );
    }

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

    SearchBar _buildMobileSearchBar() {
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
        elevation: const WidgetStatePropertyAll(0),
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

    SearchBar _buildSearchBar() {
      return SearchBar(
        controller: FindController.mainViewKeywordController,
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

    Widget _buildMobileSearchContainer() {
      return Row(
        children: [
          Expanded(
            child: _buildMobileSearchBar(),
          ),
        ],
      );
    }

    Container _buildSearchContainer() {
      return Container(
        decoration: BoxDecoration(
          color: WHITE,
          borderRadius: BorderRadius.circular(32),
        ),
        width: double.infinity,
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

    Stack _buildStack() {
      return Stack(
        alignment: AlignmentDirectional.bottomStart,
        children: [
          _buildImage(),
          Padding(
            padding: EdgeInsets.symmetric(
              vertical: 32,
              horizontal:
                  isMobile ? MOBILEPADDING : DESKTOPPADDING(viewportWidth),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildHeadline(),
                buildSizedBox(32),
                isMobile
                    ? _buildMobileSearchContainer()
                    : _buildSearchContainer(),
              ],
            ),
          ),
        ],
      );
    }

    Expanded _buildPopularEnlist(EnlistModel enlistModel) {
      return Expanded(
        child: MouseRegion(
          cursor: SystemMouseCursors.click,
          child: GestureDetector(
            onTap: () => Navigator.push(
              context,
              PageRouteBuilder(
                pageBuilder: (context, a, b) => DetailsView(
                  enlistModel: enlistModel,
                ),
                transitionDuration: Duration.zero,
                reverseTransitionDuration: Duration.zero,
              ),
            ).then(
              (_) {
                setState(() {});
              },
            ),
            child: Container(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 48),
              decoration: BoxDecoration(
                gradient: enlistModel.branch.gradientColor,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        enlistModel.descriptionShort,
                        style: (isMobile ? tt.labelSmall : tt.labelLarge)
                            ?.copyWith(
                          color: WHITE,
                        ),
                      ),
                      Text(
                        enlistModel.classification ?? '-',
                        style: (isMobile ? tt.headlineSmall : tt.headlineLarge)
                            ?.copyWith(
                          color: WHITE,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  Image.asset(
                    'assets/Logo${enlistModel.branch.nameEng}.png',
                    height: 64,
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    }

    Row _buildPopularEnlists() {
      return Row(
        children: [
          _buildPopularEnlist(EnlistController.rawEnlists[167]),
          buildSizedBox(32),
          _buildPopularEnlist(EnlistController.rawEnlists[22]),
          buildSizedBox(32),
          _buildPopularEnlist(EnlistController.rawEnlists[7]),
        ].sublist(0, isMobile ? 1 : 5),
      );
    }

    // temporarily displaying all enlists
    Column _buildLatestEnlists() {
      return Column(
        children: List.generate(
          EnlistController.latestEnlistsSublist.length,
          (int i) => buildEnlist(
            enlistModel: EnlistController.latestEnlistsSublist[i],
          ),
        ),
      );
    }

    Padding _buildList() {
      return Padding(
        padding: EdgeInsets.symmetric(
          vertical: isMobile ? 16 : 48,
          horizontal: isMobile ? MOBILEPADDING : DESKTOPPADDING(viewportWidth),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  '🔥',
                  style: (isMobile ? tt.titleSmall : tt.titleLarge)?.copyWith(
                    color: Colors.red,
                  ),
                ),
                buildSizedBox(4),
                Text(
                  '인기 모집병',
                  style: (isMobile ? tt.titleSmall : tt.titleLarge),
                ),
              ],
            ),
            buildSizedBox(16),
            _buildPopularEnlists(),
            buildSizedBox(48),
            Row(
              children: [
                Text(
                  '⏳',
                  style: (isMobile ? tt.titleSmall : tt.titleLarge)?.copyWith(
                    color: Colors.amber,
                  ),
                ),
                buildSizedBox(4),
                Text(
                  '얼마 남지 않았어요!',
                  style: (isMobile ? tt.titleSmall : tt.titleLarge),
                ),
              ],
            ),
            buildSizedBox(16),
            _buildLatestEnlists(),
          ],
        ),
      );
    }

    return Scaffold(
      appBar: const buildAppBar(),
      floatingActionButton: const buildFloatingActionButton(),
      body: NotificationListener<ScrollNotification>(
        onNotification: (notification) {
          if (!EnlistController.isLoadingLatestEnlists &&
              notification.metrics.pixels ==
                  notification.metrics.maxScrollExtent) {
            setState(() {
              EnlistController.loadLatestEnlists();
            });
          }

          return true;
        },
        child: ListView(
          children: [
            _buildStack(),
            _buildList(),
          ],
        ),
      ),
    );
  }
}
