//
//  DetailTableViewCell.swift
//  Sandwich
//
//  Created by Matthew Brandly on 9/28/14.
//
//

import UIKit

class DetailTableViewCell : UITableViewCell {
    var titleLabel: UILabel!
    var thumbnailImageView: UIImageView!
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String!) {
        titleLabel = UILabel()
        thumbnailImageView = UIImageView()
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        titleLabel.setTranslatesAutoresizingMaskIntoConstraints(false)
        titleLabel.font = UIFont.boldSystemFontOfSize(14.0)
        titleLabel.numberOfLines = 0
        self.contentView.addSubview(titleLabel)
        
        let views = ["title": titleLabel]
        let metrics = ["padding": "15.0"]
        self.contentView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(
            "H:|-padding-[title]-padding-|", options: NSLayoutFormatOptions.allZeros, metrics: metrics, views: views))
        self.contentView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(
            "V:|-padding-[title]-(>=15)-|", options: NSLayoutFormatOptions.allZeros, metrics: metrics, views: views))
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
