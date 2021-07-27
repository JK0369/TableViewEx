//
//  MyTableViewHeader.swift
//  TableViewEx
//
//  Created by 김종권 on 2021/07/27.
//

import UIKit
import RxSwift

class MyTableViewHeader: BaseTableViewHeaderFooterView<Void> {

    var disposeBag = DisposeBag()

    private lazy var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white

        return view
    }()

    private lazy var myImageView: UIImageView = {
        let view = UIImageView()
        view.image = #imageLiteral(resourceName: "background")

        return view
    }()

    private lazy var disclosureIndicatorButton: UIButton = {
        let button = UIButton()
        button.setImage(#imageLiteral(resourceName: "btnDisclosureIndicator"), for: .normal)

        return button
    }()

    private lazy var separatorView: UIView = {
        let view = UIView()
        view.backgroundColor = .separator

        return view
    }()

    override func configure() {
        super.configure()

        backgroundColor = .white
        addSubviews()
        makeConstraints()
    }

    private func addSubviews() {
        addSubview(containerView)
        containerView.addSubview(myImageView)
        containerView.addSubview(disclosureIndicatorButton)
        containerView.addSubview(separatorView)
    }

    private func makeConstraints() {
        containerView.snp.makeConstraints { maker in
            maker.edges.equalToSuperview()
        }

        myImageView.snp.makeConstraints { maker in
            maker.top.greaterThanOrEqualToSuperview().inset(24)
            maker.leading.equalToSuperview().inset(24)
            maker.bottom.equalTo(separatorView).offset(-24)
        }

        disclosureIndicatorButton.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        disclosureIndicatorButton.snp.makeConstraints { maker in
            maker.trailing.equalToSuperview().inset(24)
            maker.centerY.equalTo(myImageView)
            maker.leading.greaterThanOrEqualTo(myImageView.snp.trailing).offset(30)
        }

        separatorView.snp.makeConstraints { maker in
            maker.height.equalTo(1)
            maker.leading.trailing.equalToSuperview().inset(16)
            maker.bottom.equalToSuperview().inset(12)
        }
    }
}
