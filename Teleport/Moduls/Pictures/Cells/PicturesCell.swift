//
//  PicturesCell.swift
//  Teleport
//
//  Created by Майя Калицева on 03.06.2022.
//

import RxCocoa
import RxSwift
import RxGesture
import CoreServices

final class PicturesCell: UITableViewCell {

    // MARK: Private Properies
    
    private var bag = DisposeBag()
    
    private let urbanImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 20
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let photographerName: UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont.systemFont(ofSize: 16)
        lbl.textColor = UIColor.black.withAlphaComponent(0.8)
        lbl.numberOfLines = 0
        return lbl
    }()

    // MARK: - Init
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
      //  setupLayout()
        cellStyle()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Life-cycle
    
    override func prepareForReuse() {
        super.prepareForReuse()
        bag = DisposeBag()
    }
    
    // MARK: Public Methods

   
    // MARK: Private Methods
    
    private func cellStyle() {
        backgroundColor = .clear
        selectionStyle = .none
    }
    
    
}



