//
//  TutorialCollectionViewCell.swift
//  Plu-iOS
//
//  Created by 김민재 on 12/11/23.
//

import UIKit

final class TutorialCollectionViewCell: UICollectionViewCell, CollectionViewCellRegisterDequeueProtocol {
    
    private let tutorialLabel = PLULabel(type: .head2, color: .gray700, backgroundColor: .background, alignment: .center, lines: 2)
    
    private let screenshotImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.applyShadow()
        imageView.layer.cornerRadius = 12
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUI()
        setHirerachy()
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUI() {
        self.backgroundColor = .designSystem(.background)
    }
    
    private func setHirerachy() {
        contentView.addSubviews(tutorialLabel, screenshotImageView)
    }
    
    private func setLayout() {
        tutorialLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(28)
            make.centerX.equalToSuperview()
        }
        
        screenshotImageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(tutorialLabel.snp.bottom).offset(50)
            make.width.equalTo(214.seWidth)
            make.height.equalTo(screenshotImageView.snp.width).multipliedBy(258/214)
        }
    }
    
    func configureUI(image: UIImage, text: String) {
        self.screenshotImageView.image = image
        self.tutorialLabel.text = text
    }
}
