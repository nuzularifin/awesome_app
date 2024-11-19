import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_awesome_app/domain/entities/photo.dart';
import 'package:flutter_awesome_app/domain/usecase/get_photo_list.dart';
import 'package:flutter_awesome_app/presentation/bloc/photo_bloc.dart';
import 'package:flutter_awesome_app/presentation/bloc/photo_event.dart';
import 'package:flutter_awesome_app/presentation/bloc/photo_state.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockGetPhotoList extends Mock implements GetPhotoList {}

void main() {
  late PhotoBloc photoBloc;
  late MockGetPhotoList mockGetPhotoList;

  setUp(() {
    mockGetPhotoList = MockGetPhotoList();
    photoBloc = PhotoBloc(mockGetPhotoList);
  });

  tearDown(() {
    photoBloc.close();
  });

  group('PhotoBloc', () {
    final photos = [
      Photo(id: 1, photographer: 'Photo 1', url: 'url1'),
      Photo(id: 2, photographer: 'Photo 2', url: 'url2'),
      Photo(id: 3, photographer: 'Photo 3', url: 'url3'),
    ];

    test('initial state is PhotoListInitial', () {
      expect(photoBloc.state, equals(PhotoListInitial()));
    });

    blocTest<PhotoBloc, PhotoState>(
      'emits [PhotoListLoading, PhotoListSuccess] when photos are fetched successfully',
      build: () {
        when(() => mockGetPhotoList.exec(1)).thenAnswer((_) async => photos);
        return photoBloc;
      },
      act: (bloc) => bloc.add(FetchPhotoList()),
      expect: () => [
        PhotoListLoading(),
        PhotoListSuccess(photos: photos),
      ],
      verify: (_) => {verify(() => mockGetPhotoList.exec(1))},
    );

    blocTest<PhotoBloc, PhotoState>('emits []',
        build: () {
          when(() => mockGetPhotoList.exec(1))
              .thenThrow(Exception('Failed to fetch photo list'));
          return photoBloc;
        },
        act: (bloc) => bloc.add(FetchPhotoList()),
        expect: () => [
              PhotoListLoading(),
              PhotoListError(
                  message:
                      'Failed cause Exception: Failed to fetch photo list'),
            ],
        verify: (_) {
          verify(() => mockGetPhotoList.exec(1)).called(1);
        });
  });
}
