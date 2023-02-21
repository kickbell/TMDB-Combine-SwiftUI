//
//  LoadingCell.swift
//  TMDB
//
//  Created by jc.kim on 2/18/23.
//


import UIKit

class LoadingCell: UITableViewCell {
    
    // MARK: - Views
    
    private let indicatorView = UIActivityIndicatorView()
    
    // MARK: - Properties
    
    static let reuseIdentifler = String(describing: LoadingCell.self)
    
    // MARK: - LifeCycle
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addAttributes()
        addSubviews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    // MARK: - Methods
    
    private func addAttributes() {
        indicatorView.style = .medium
        indicatorView.frame.size = CGSize(width: UIScreen.main.bounds.width, height: frame.height)
    }
        
    private func addSubviews() {
        contentView.addSubview(indicatorView)
    }
    
    func start() {
        indicatorView.startAnimating()
    }
}
