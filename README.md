# TMDB-Combine-SwiftUI

![](https://velog.velcdn.com/images/dev_kickbell/post/beeaa984-9528-496e-9970-f1d745d407d1/image.png)

## SwiftUI + Combine + MVVM

### 기술정보

- 화면구현: SwiftUI, UIKit
- 네트워킹: URLSession
- 비동기 프로그래밍: Combine
- 사용한 디자인패턴: MVVM

### 상세설명

스토어 : 탭바컨트롤러를 사용하지 않기 때문에 `MainView`라는 뷰에 `TabView`를 사용해서 각 `StoreView, SearchView, TrendView`로 구분하였습니다. 개인적으로 하나의 파일에 전체 화면을 그리는 것보다는 `각 View로 나눠어서 관리`하는 것을 선호하기 때문에 기존의 UICollectionViewCell를 대체할 수 있도록 같은 이름으로 View를 만들어 주었습니다. 메인 body 에서도 각 담당하는 파트별로 VStack을 `featured(), topandnew(), upcoming(), category()`로 나누어 가독성을 높이고 실제 구현은 `extension` 에서 구현하도록 했습니다. 

검색 : SwiftUI에는 SearchBar가 없기 때문에 `UIViewRepresentable` 를 사용해서 `SearchBar 구조체를 만들어 대체`하였습니다. body는 SearchBar 화면을 나타내는 search() 과 실제 UITableViewCell을 나타내던 content() 이 있습니다. content()는 `List(data:id:)` 를 사용하였고 내부에는 실제 컨텐츠를 나타내는 `SearchRow`라는 View를 따로 만들어주었습니다. 

트렌드 : 상대적으로 간단한 화면이므로 같은 방법으로 타이틀과 고정된 텍스트 값이 있는 subtitle() 부분과 데이터에 따라 유동적으로 변경되는 content() 부분으로 나누어서 구현해주었습니다. 

네트워킹 : 위에서 사용한 파일들을 대부분 사용했으나, `async/await` 부분만 `Combine`을 사용하도록 리턴 값을 `AnyPublisher<T, NetworkError>` 으로 대체하였습니다. 

사용한 디자인 패턴 : `Combine` 프레임워크를 사용했으므로 꽤나 조합이 잘맞는 `MVVM 패턴`을 적용하였습니다. 각 `ViewModel`에서는 `ObservableObject 프로토콜`과 `@Published`를, 그리고 사용하는 `View`에서는 `@ObservedObject` 를 사용해서 구현하였습니다.
