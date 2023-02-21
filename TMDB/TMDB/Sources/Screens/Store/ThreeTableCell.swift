//
//  ThreeTableCell.swift
//  TMDB
//
//  Created by jc.kim on 2/18/23.
//

import UIKit

class ThreeTableCell: UICollectionViewCell {
    
    // MARK: - Views
    
    private let name = UILabel()
    private let subtitle = UILabel()
    private let poster = UIImageView()
    private let buyButton = UIButton(type: .custom)
    private var innerStackView = UIStackView()
    private var outerStackView = UIStackView()
    
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
        name.font = UIFont.preferredFont(forTextStyle: .headline)
        name.textColor = .label
        
        subtitle.font = UIFont.preferredFont(forTextStyle: .subheadline)
        subtitle.textColor = .secondaryLabel
        
        poster.layer.cornerRadius = 5
        poster.contentMode = .scaleAspectFill
        poster.backgroundColor = .lightGray
        poster.clipsToBounds = true
        
        buyButton.setImage(UIImage(systemName: "icloud.and.arrow.down"), for: .normal)

        innerStackView = UIStackView(arrangedSubviews: [name, subtitle])
        innerStackView.axis = .vertical
        
        outerStackView = UIStackView(arrangedSubviews: [poster, innerStackView, buyButton])
        outerStackView.translatesAutoresizingMaskIntoConstraints = false
        outerStackView.alignment = .center
        outerStackView.spacing = 10
    }
    
    private func addSubviews() {
        contentView.addSubview(outerStackView)
    }
    
    private func addConstraints() {
        poster.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        buyButton.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        
        NSLayoutConstraint.activate([
            poster.widthAnchor.constraint(equalToConstant: 80),
            
            outerStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            outerStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            outerStackView.topAnchor.constraint(equalTo: contentView.topAnchor),
            outerStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
        
    func configure(with movie: Movie) {
        name.text = movie.title
        subtitle.text = movie.overview
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
