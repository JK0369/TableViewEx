//
//  MyTableViewCell.swift
//  TableViewEx
//
//  Created by 김종권 on 2021/07/27.
//

import UIKit
import SnapKit

class MyTableViewCell: BaseTableViewCell<MyItem> {

    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16)
        label.textColor = .black

        return label
    }()

    override func configure() {
        super.configure()

        backgroundColor = .white

        addSubviews()
        makeConstraints()
    }

    private func addSubviews() {
        contentView.addSubview(titleLabel)
    }

    private func makeConstraints() {
        titleLabel.snp.makeConstraints { maker in
            maker.centerY.equalToSuperview()
            maker.leading.equalToSuperview().inset(24)
        }
    }

    override func bind(_ model: MyItem?) {
        super.bind(model)

        titleLabel.text = model?.title
    }
    
}
