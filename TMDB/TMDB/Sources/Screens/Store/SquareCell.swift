//
//  SquareCell.swift
//  TMDB
//
//  Created by jc.kim on 2/18/23.
//

import UIKit
import Combine

class SquareCell: UICollectionViewCell {
    // MARK: - Views
    
    private let poster = UIImageView()
    private let name = UILabel()
    private let subtitle = UILabel()
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
        poster.layer.cornerRadius = 5
        poster.contentMode = .scaleAspectFill
        poster.backgroundColor = .lightGray
        poster.clipsToBounds = true
        
        name.font = UIFont.preferredFont(forTextStyle: .subheadline)
        name.textColor = .label
        
        subtitle.font = UIFont.preferredFont(forTextStyle: .body)
        subtitle.textColor = .secondaryLabel
        
        stackView = UIStackView(arrangedSubviews: [poster, name, subtitle])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
    }
    
    private func addSubviews() {
        contentView.addSubview(stackView)
    }
    
    private func addConstraints() {
        name.setContentHuggingPriority(.defaultHigh, for: .vertical)
        subtitle.setContentHuggingPriority(.defaultHigh, for: .vertical)
        
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
        
        stackView.setCustomSpacing(5, after: poster)
    }
    
    func configure(with movie: Movie) {
        name.text = movie.title
        cancellable = loadImage(from: movie.backdropPath).sink { [weak self] image in self?.poster.image = image }
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
