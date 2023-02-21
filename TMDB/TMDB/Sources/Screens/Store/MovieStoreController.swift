//
//  MovieStoreController.swift
//  TMDB
//
//  Created by jc.kim on 2/18/23.
//

import UIKit

class MovieStoreController: UIViewController {
    
    // MARK: Views
    
    var collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewLayout())
    
    // MARK: Properties
    
    var dataSource: UICollectionViewDiffableDataSource<Section, Item>?
    private(set) var fetchResult: FetchResult?
    private let service: MoviesServiceType
    
    // MARK: LifeCycle
    
    init(service: MoviesServiceType) {
        self.service = service
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) is not supported")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addAttributes()
        addSubviews()
        createDataSource()
        applyInitialSnapshot()
        
        loadTableView {
            self.createDataSource()
            self.applyInitialSnapshot()
        }
        
    }
    
    // MARK: Methods
    
    struct FetchResult {
        let topRated: Movies
        let popular: Movies
        let genre: Genres
        let upcoming: Movies
    }
    
    private func fetchData(completion: @escaping (FetchResult) -> Void) {
        Task(priority: .background) {
            let tapRated = await service.topRated()
            let popular = await service.popular()
            let genre = await service.genre()
            let upcoming = await service.upcoming()
            
            do {
                let t = try tapRated.get()
                let p = try popular.get()
                let g = try genre.get()
                let u = try upcoming.get()
            
                let result = FetchResult(topRated: t, popular: p, genre: g, upcoming: u)
                completion(result)
            } catch {
                showModal(title: "Error", message: error.localizedDescription)
            }
        }
    }
    
    func loadTableView(completion: (() -> Void)? = nil) {
        fetchData { response in
            self.fetchResult = response
            completion?()
        }
    }
    
    func addAttributes() {
        view.backgroundColor = .white
        
        title = "스토어"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: createCompositionalLayout())
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        collectionView.backgroundColor = .systemBackground
        collectionView.delegate = self
    }
    
    func addSubviews() {
        view.addSubview(collectionView)
    }
    
    func sectionHeaderRegistration<T: UICollectionReusableView>(_ viewType: T.Type) -> UICollectionView.SupplementaryRegistration<T>{
        return UICollectionView.SupplementaryRegistration<T>(elementKind: UICollectionView.elementKindSectionHeader) { supplementaryView,elementKind,indexPath in }
    }
    
    func createFeaturedCellRegistration() -> UICollectionView.CellRegistration<FeaturedCell, Movie> {
        return UICollectionView.CellRegistration<FeaturedCell, Movie> { (cell, _ , movie) in
            cell.configure(with: movie)
        }
    }
    
    func createThreeTableCellRegistration() -> UICollectionView.CellRegistration<ThreeTableCell, Movie> {
        return UICollectionView.CellRegistration<ThreeTableCell, Movie> { (cell, _ , movie) in
            cell.configure(with: movie)
        }
    }
    
    func createSmallTableCellRegistration() -> UICollectionView.CellRegistration<SmallTableCell, Genre> {
        return UICollectionView.CellRegistration<SmallTableCell, Genre> { (cell, _ , genre) in
            cell.configure(with: genre)
        }
    }
    
    func createSquareCellRegistration() -> UICollectionView.CellRegistration<SquareCell, Movie> {
        return UICollectionView.CellRegistration<SquareCell, Movie> { (cell, _ , movie) in
            cell.configure(with: movie)
        }
    }
    
    func createDataSource() {
        let sectionHeaderRegistration = sectionHeaderRegistration(SectionHeader.self)
        
        let featuredCellRegistration = createFeaturedCellRegistration()
        let mediumTableCellRegistration = createThreeTableCellRegistration()
        let smallTableCellRegistration = createSmallTableCellRegistration()
        let squareCellRegistration = createSquareCellRegistration()
        
        dataSource = UICollectionViewDiffableDataSource<Section, Item>(collectionView: collectionView) { collectionView, indexPath, item in
            guard let section = Section(rawValue: indexPath.section) else { fatalError("Unknown section") }
            switch section {
            case .popular:
                return collectionView.dequeueConfiguredReusableCell(using: featuredCellRegistration, for: indexPath, item: item.popular)
            case .topRated:
                return collectionView.dequeueConfiguredReusableCell(using: mediumTableCellRegistration, for: indexPath, item: item.topRated)
            case .genre:
                return collectionView.dequeueConfiguredReusableCell(using: smallTableCellRegistration, for: indexPath, item: item.genre)
            case .upcoming:
                return collectionView.dequeueConfiguredReusableCell(using: squareCellRegistration, for: indexPath, item: item.upcoming)
            }
        }
        
        dataSource?.supplementaryViewProvider = { [weak self] collectionView, kind, indexPath in
            let sectionHeader = collectionView.dequeueConfiguredReusableSupplementary(using: sectionHeaderRegistration, for: indexPath)

            guard let firstApp = self?.dataSource?.itemIdentifier(for: indexPath) else { return nil }
            guard let section = self?.dataSource?.snapshot().sectionIdentifier(containingItem: firstApp) else { return nil }
            
            switch section {
            case .popular: return sectionHeader
            case .topRated:
                sectionHeader.title.text = "HOT & NEW"
                sectionHeader.subtitle.text = "최고 등급의 평점을 받은 영화입니다."
                return sectionHeader
            case .genre:
                sectionHeader.title.text = "영화 카테고리"
                return sectionHeader
            case .upcoming:
                sectionHeader.title.text = "UPCOMING"
                return sectionHeader
            }
        }
    }
    
    func applyInitialSnapshot() {
        var snapshot = NSDiffableDataSourceSnapshot<Section, Item>()
        snapshot.appendSections(Section.allCases)
        
        guard let result = fetchResult else {
            return
        }
        
        let popularItems = result.popular.items.map { Item(popular: $0 )}
        let topRatedItems = result.topRated.items.map { Item(topRated: $0 )}
        let genreItems = result.genre.items.map { Item(genre: $0 )}
        let upcomingItems = result.upcoming.items.map { Item(upcoming: $0 )}
        snapshot.appendItems(popularItems, toSection: .popular)
        snapshot.appendItems(topRatedItems, toSection: .topRated)
        snapshot.appendItems(genreItems, toSection: .genre)
        snapshot.appendItems(upcomingItems, toSection: .upcoming)
        
        dataSource?.apply(snapshot)
    }
    
    func createCompositionalLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { sectionIndex, layoutEnvironment in
            guard let section = Section(rawValue: sectionIndex) else { fatalError("Unknown section") }
            switch section {
            case .popular:
                return self.createFeaturedSection()
            case .topRated:
                return self.createMediumTableSection()
            case .genre:
                return self.createSmallTableSection()
            case .upcoming:
                return self.createSquareTableSection()
            }
        }
        
        let config = UICollectionViewCompositionalLayoutConfiguration()
        config.interSectionSpacing = 20
        layout.configuration = config
        return layout
    }
    
    func createFeaturedSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        
        let layoutItem = NSCollectionLayoutItem(layoutSize: itemSize)
        layoutItem.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 5, bottom: 0, trailing: 5)
        let layoutGroupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.93), heightDimension: .estimated(300))
        let layoutGroup = NSCollectionLayoutGroup.horizontal(layoutSize: layoutGroupSize, subitems: [layoutItem])
        
        let layoutSection = NSCollectionLayoutSection(group: layoutGroup)
        layoutSection.orthogonalScrollingBehavior = .groupPagingCentered
        return layoutSection
    }
    
    func createMediumTableSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(0.33))
        
        let layoutItem = NSCollectionLayoutItem(layoutSize: itemSize)
        layoutItem.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 5, bottom: 5, trailing: 5)
        
        let layoutGroupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.93), heightDimension: .fractionalWidth(0.55))
        let layoutGroup = NSCollectionLayoutGroup.vertical(layoutSize: layoutGroupSize, subitems: [layoutItem])
        
        let layoutSection = NSCollectionLayoutSection(group: layoutGroup)
        layoutSection.orthogonalScrollingBehavior = .groupPagingCentered
        let layoutSectionHeader = createSectionHeader()
        layoutSection.boundarySupplementaryItems = [layoutSectionHeader]
        return layoutSection
    }
    
    func createSmallTableSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(0.2))
        let layoutItem = NSCollectionLayoutItem(layoutSize: itemSize)
        layoutItem.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 0)
        
        let layoutGroupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.93), heightDimension: .estimated(200))
        let layoutGroup = NSCollectionLayoutGroup.vertical(layoutSize: layoutGroupSize, subitems: [layoutItem])
        
        let layoutSection = NSCollectionLayoutSection(group: layoutGroup)
        let layoutSectionHeader = createSectionHeader()
        layoutSection.boundarySupplementaryItems = [layoutSectionHeader]
        
        return layoutSection
    }
    
    func createSquareTableSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(0.5))

        let layoutItem = NSCollectionLayoutItem(layoutSize: itemSize)
        layoutItem.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 20, bottom: 5, trailing: 0)

        let layoutGroupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.46), heightDimension: .fractionalHeight(0.46))
        let layoutGroup = NSCollectionLayoutGroup.vertical(layoutSize: layoutGroupSize, subitems: [layoutItem])

        let layoutSection = NSCollectionLayoutSection(group: layoutGroup)
        layoutSection.orthogonalScrollingBehavior = .continuous
        let layoutSectionHeader = createSectionHeader()
        layoutSection.boundarySupplementaryItems = [layoutSectionHeader]
        return layoutSection
    }
    
    func createSectionHeader() -> NSCollectionLayoutBoundarySupplementaryItem {
        let layoutSectionHeaderSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.93), heightDimension: .estimated(80))
        let layoutSectionHeader = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: layoutSectionHeaderSize, elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
        return layoutSectionHeader
    }
}

extension MovieStoreController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let app = self.dataSource?.itemIdentifier(for: indexPath) else {
            collectionView.deselectItem(at: indexPath, animated: true)
            return
        }
        var movie: Movie?
        
        switch indexPath.section {
        case 0: movie = app.popular
        case 1: movie = app.topRated
        case 2: movie = app.upcoming
        case 3: return
        default: break
        }
        
        let detailViewController = DetailMovieController(service: MoviesService(), with: movie?.id ?? 0)
        detailViewController.navigationItem.largeTitleDisplayMode = .never
        self.navigationController?.pushViewController(detailViewController, animated: true)
    }

}
