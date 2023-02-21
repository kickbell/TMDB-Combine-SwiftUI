//
//  SectionHeader.swift
//  TMDB
//
//  Created by jc.kim on 2/18/23.
//

import UIKit

class SectionHeader: UICollectionViewCell {
    
    // MARK: - Views
    
    private let separator = UIView()
    let title = UILabel()
    let subtitle = UILabel()
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
    
    // MARK: - Methods
    
    private func addAttributes() {
        separator.translatesAutoresizingMaskIntoConstraints = false
        separator.backgroundColor = .quaternaryLabel
        
        title.textColor = .label
        title.font = UIFontMetrics.default.scaledFont(for: UIFont.systemFont(ofSize: 22, weight: .bold))
        subtitle.textColor = .secondaryLabel
        subtitle.numberOfLines = 1
        
        innerStackView = UIStackView(arrangedSubviews: [separator, title, subtitle])
        innerStackView.axis = .vertical
        
        outerStackView = UIStackView(arrangedSubviews: [innerStackView])
        outerStackView.translatesAutoresizingMaskIntoConstraints = false
        outerStackView.axis = .horizontal
    }
    
    private func addSubviews() {
        addSubview(outerStackView)
    }
    
    private func addConstraints() {
        NSLayoutConstraint.activate([
            separator.heightAnchor.constraint(equalToConstant: 1),
            
            outerStackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            outerStackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            outerStackView.topAnchor.constraint(equalTo: topAnchor),
            outerStackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10)
        ])
        
        innerStackView.setCustomSpacing(10, after: separator)
    }
    
}
