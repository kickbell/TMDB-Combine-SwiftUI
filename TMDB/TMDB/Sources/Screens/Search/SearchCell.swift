//
//  SearchCell.swift
//  TMDB
//
//  Created by jc.kim on 2/18/23.
//

import UIKit
import Combine

class SearchCell: UITableViewCell{
    
    // MARK: - Views
    
    private let poster = UIImageView()
    private let tagline = UILabel()
    private let title = UILabel()
    private let overview = UILabel()
    private var innerStackView = UIStackView()
    private var outerStackView = UIStackView()
    
    // MARK: - Properties
    
    static let reuseIdentifler = String(describing: SearchCell.self)
    private var cancellable: AnyCancellable?
    
    // MARK: - LifeCycle
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
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
    
    func addAttributes() {
        tagline.font = UIFontMetrics.default.scaledFont(for: UIFont.systemFont(ofSize: 12, weight: .bold))
        tagline.textColor = .systemBlue
        
        title.font = UIFont.preferredFont(forTextStyle: .title2)
        title.textColor = .label
        
        overview.font = UIFont.preferredFont(forTextStyle: .body)
        overview.textAlignment = .justified
        overview.numberOfLines = 3
        overview.textColor = .secondaryLabel
        
        poster.layer.cornerRadius = 5
        poster.clipsToBounds = true
        poster.backgroundColor = .lightGray
        poster.contentMode = .scaleAspectFill
        
        innerStackView = UIStackView(arrangedSubviews: [tagline, title, overview])
        innerStackView.axis = .vertical
        
        outerStackView = UIStackView(arrangedSubviews: [poster, innerStackView])
        outerStackView.translatesAutoresizingMaskIntoConstraints = false
        outerStackView.spacing = 10
        outerStackView.axis = .horizontal
        outerStackView.alignment = .top
    }
    
    func addSubviews() {
        contentView.addSubview(outerStackView)
    }
    
    func addConstraints() {
        title.setContentHuggingPriority(.defaultHigh, for: .vertical)
        tagline.setContentHuggingPriority(.defaultHigh, for: .vertical)
        
        NSLayoutConstraint.activate([
            poster.widthAnchor.constraint(equalToConstant: 62),
            poster.heightAnchor.constraint(equalToConstant: 62),
            
            outerStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            outerStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            outerStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            outerStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10)
        ])
    }
    
    func configure(with movie: Movie) {
        tagline.text = movie.releaseDate
        title.text = movie.title
        overview.text = movie.overview
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
