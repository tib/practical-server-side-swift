//
//  CustomCell.swift
//  MyProject
//
//  Created by Tibor Bodecs on 2020. 05. 15..
//  Copyright © 2020. Tibor Bodecs. All rights reserved.
//

import UIKit

class CustomCell: UITableViewCell {
    weak var coverView: UIImageView!
    weak var titleLabel: UILabel!

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        self.initialize()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)

        self.initialize()
    }

    func initialize() {
        let coverView = UIImageView(frame: .zero)
        coverView.translatesAutoresizingMaskIntoConstraints = false
        self.contentView.addSubview(coverView)
        self.coverView = coverView
        self.coverView.contentMode = .scaleAspectFill
        self.coverView.clipsToBounds = true
        self.coverView.layer.cornerRadius = 8

        let titleLabel = UILabel(frame: .zero)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        self.contentView.addSubview(titleLabel)
        self.titleLabel = titleLabel
        self.titleLabel.textAlignment = .center

        NSLayoutConstraint.activate([
            self.coverView.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 16),
            self.coverView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 16),
            self.coverView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -16),
            self.coverView.bottomAnchor.constraint(equalTo: self.titleLabel.topAnchor, constant: 0),
            
            self.titleLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 16),
            self.titleLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -16),
            self.titleLabel.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: 0),
            self.titleLabel.heightAnchor.constraint(equalToConstant: 44),
        ])
    }

    override func prepareForReuse() {
        super.prepareForReuse()

        self.titleLabel.text = nil
        self.coverView.image = nil
    }
}
