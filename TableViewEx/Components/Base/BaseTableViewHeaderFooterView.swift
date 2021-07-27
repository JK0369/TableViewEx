//
//  BaseTableViewHeaderFooterView.swift
//  TableViewEx
//
//  Created by 김종권 on 2021/07/27.
//

import UIKit

class BaseTableViewHeaderFooterView<T>: UITableViewHeaderFooterView {
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)

        configure()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    var model: T? {
        didSet {
            if let model = model {
                bind(model)
            }
        }
    }

    func configure() {}
    func bind(_ model: T) {}
}

