//
//  ViewController.swift
//  TableViewEx
//
//  Created by 김종권 on 2021/07/27.
//

import UIKit
import RxSwift
import RxCocoa

class ViewController: UIViewController {

    // business logic에 위치해야할 값
    var dataSource: [MyItemList] = []

    lazy var tableView: UITableView = {

        // header 영역도 같이 scroll되기 위해 .grouped로 설정
        let view = UITableView(frame: .zero, style: .grouped)
        view.dataSource = self
        view.delegate = self
        view.estimatedRowHeight = 44
        view.rowHeight = 48
        view.separatorStyle = .none
        view.backgroundColor = .white
        view.register(MyTableViewCell.self, forCellReuseIdentifier: "MyTableViewCell")
        view.register(MyTableViewHeader.self, forHeaderFooterViewReuseIdentifier: "MyTableViewHeader")
        view.register(SeparatorTableViewFooter.self, forHeaderFooterViewReuseIdentifier: "SeparatorTableViewFooter")

        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        setupDataSource()
        addSubviews()
        configure()
    }

    private func addSubviews() {
        view.addSubview(tableView)
    }

    private func configure() {
        tableView.snp.makeConstraints { maker in
            maker.leading.top.bottom.equalToSuperview()
            maker.trailing.equalToSuperview().inset(120)
        }
    }
}

extension ViewController: UITableViewDataSource, UITableViewDelegate {

    // TableView DataSource

    func numberOfSections(in tableView: UITableView) -> Int {
        return numberOfSections
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return numberOfRows(in: section)
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MyTableViewCell") as? MyTableViewCell else {
            fatalError("MyTableViewCell not dequeued property")
        }
        let item = getItem(in: indexPath.section, indexPath.row)
        cell.model = item

        return cell
    }

    // Header & Footer

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard section == 0, let headerCell = tableView.dequeueReusableHeaderFooterView(withIdentifier: "MyTableViewHeader") as? MyTableViewHeader else { return nil }

        let tapGesture = UITapGestureRecognizer()
        headerCell.addGestureRecognizer(tapGesture)
        tapGesture.rx.event
            .asDriver()
            .drive(onNext: { _ in
                print("did tap first header")
            }).disposed(by: headerCell.disposeBag)

        return headerCell
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        // Header 영역 크기 = 140(separator 상단) + 12(separator 하단)

        return section == 0 ? 152 : 0
    }

    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        // 마지막 section은 footer 미표출

        guard section != numberOfSections - 1 else {
            return nil
        }
        return tableView.dequeueReusableHeaderFooterView(withIdentifier: "SeparatorTableViewFooter")
    }

    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        // footer 영역 크기 = 12 (마지막 section의 footer 크기는 0)

        return section == numberOfSections - 1 ? 0 : 12
    }

    // Select Cell

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        didSelectRowAt(in: indexPath.section, indexPath.row)
    }
}

// business logic에 위치해야할 값들
extension ViewController {

    var numberOfSections: Int {
        return dataSource.count
    }

    func setupDataSource() {
        // Section 1
        let item1 = MyItem(title: "1", type: .a)
        let item2 = MyItem(title: "2", type: .b)

        // Section 2
        let item3 = MyItem(title: "3", type: .c)
        let item4 = MyItem(title: "4", type: .d)
        let item5 = MyItem(title: "5", type: .e)

        // Section 3
        let item6 = MyItem(title: "6", type: .c)
        let item7 = MyItem(title: "7", type: .d)
        let item8 = MyItem(title: "8", type: .e)

        let section1 = [item1, item2]
        let section2 = [item3, item4, item5]
        let section3 = [item6, item7, item8]

        dataSource = [section1, section2, section3]
    }

    func numberOfRows(in section: Int) -> Int {
        return dataSource[section].count
    }

    func getItem(in section: Int, _ row: Int) -> MyItem {
        return dataSource[section][row]
    }

    func didSelectRowAt(in section: Int, _ row: Int) {
        print("did select type = \(dataSource[section][row].type)")
    }
}
