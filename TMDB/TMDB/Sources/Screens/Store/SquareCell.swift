//
//  SquareCell.swift
//  TMDB
//
//  Created by jc.kim on 2/18/23.
//

import UIKit

class SquareCell: UICollectionViewCell {
    // MARK: - Views
    
    private let poster = UIImageView()
    private let name = UILabel()
    private let subtitle = UILabel()
    private var stackView = UIStackView()
    
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
        loadImage(from: movie.backdropPath)
    }
    
    private func loadImage(from path: String?) {
        guard let path = path,
              let url = URL(string: ApiConstants.mediumImageUrl + path) else { return }
        ImageLoaderService.shared.loadImage(from: url) { [weak self] result in
            guard let image = try? result.get() else { return }
            DispatchQueue.main.async {
                self?.poster.image = image
            }
        }
    }
}
