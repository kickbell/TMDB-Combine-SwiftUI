//
//  FeaturedCell.swift
//  TMDB
//
//  Created by jc.kim on 2/18/23.
//

import UIKit
import Combine

class FeaturedCell: UICollectionViewCell {
    
    // MARK: - Views
    
    private let separator = UIView()
    private let tagline = UILabel()
    private let name = UILabel()
    private let subtitle = UILabel()
    private let poster = UIImageView()
    private var stackView = UIStackView()
    
    // MARK: Properties

    private var cancellable: AnyCancellable?
    
    // MARK: - LifeCycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addAttributes()
        addSubviews()
        addConstraints()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        poster.image = nil
        cancellable?.cancel()
    }
    
    // MARK: - Methods
    
    private func addAttributes() {
        separator.translatesAutoresizingMaskIntoConstraints = false
        separator.backgroundColor = .quaternaryLabel
        
        tagline.font = UIFontMetrics.default.scaledFont(for: UIFont.systemFont(ofSize: 12, weight: .bold))
        tagline.textColor = .systemBlue
        
        name.font = UIFont.preferredFont(forTextStyle: .title2)
        name.textColor = .label
        
        subtitle.font = UIFont.preferredFont(forTextStyle: .body)
        subtitle.numberOfLines = 1
        subtitle.textColor = .secondaryLabel
        
        poster.layer.cornerRadius = 5
        poster.clipsToBounds = true
        poster.contentMode = .scaleAspectFit
        poster.backgroundColor = .lightGray
        
        stackView = UIStackView(arrangedSubviews: [separator, tagline, name, subtitle, poster])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
    }
    
    private func addSubviews() {
        contentView.addSubview(stackView)
    }
    
    private func addConstraints() {
        tagline.setContentHuggingPriority(.defaultHigh, for: .vertical)
        name.setContentHuggingPriority(.defaultHigh, for: .vertical)
        poster.setContentHuggingPriority(.defaultHigh, for: .vertical)
        
        NSLayoutConstraint.activate([
            separator.heightAnchor.constraint(equalToConstant: 1),
            
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
        
        stackView.setCustomSpacing(10, after: separator)
        stackView.setCustomSpacing(10, after: subtitle)
    }
    
    func configure(with movie: Movie) {
        tagline.text = movie.releaseDate
        name.text = movie.title
        subtitle.text = movie.overview == "" ? "구매: \(movie.voteCount), 평점: \(movie.voteAverage)" : movie.overview
        cancellable = loadImage(from: movie.backdropPath).sink { [unowned self] image in poster.image = image }
    }
    
    private func loadImage(from path: String?) -> AnyPublisher<UIImage?, Never> {
        return Just(path)
            .compactMap { $0 }
            .flatMap({ poster -> AnyPublisher<UIImage?, Never> in
                let url = URL(string: ApiConstants.mediumImageUrl + poster)!
                return ImageLoaderService.shared.loadImage(from: url)
            })
            .eraseToAnyPublisher()
    }
    
}
