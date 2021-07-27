//
//  SeparatorTableViewFooter.swift
//  TableViewEx
//
//  Created by 김종권 on 2021/07/27.
//

import UIKit

class SeparatorTableViewFooter: BaseTableViewHeaderFooterView<Void> {

    lazy var separatorView: UIView = {
        let view = UIView()
        view.backgroundColor = .separator

        return view
    }()

    override func configure() {
        super.configure()

        addSubviews()
        makeConstraints()
    }

    private func addSubviews() {
        contentView.addSubview(separatorView)
    }

    private func makeConstraints() {
        separatorView.snp.makeConstraints { maker in
            maker.height.equalTo(1)
            maker.leading.trailing.greaterThanOrEqualToSuperview().inset(16)
            maker.centerY.equalToSuperview()
        }
    }
}
