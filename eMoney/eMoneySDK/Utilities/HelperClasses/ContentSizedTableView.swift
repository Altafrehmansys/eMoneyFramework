//
//  ContentSizedTableView.swift
//  e&money
//
//  Created by Muhammad Uzair Akram on 15/04/2023.
//

import UIKit

final class ContentSizedTableView: UITableView {
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.invalidateIntrinsicContentSize()
    }
    
    override var intrinsicContentSize: CGSize {
        get {
            var height:CGFloat = 0;
            for s in 0..<self.numberOfSections {
                let nRowsSection = self.numberOfRows(inSection: s)
                for r in 0..<nRowsSection {
                    height += self.rectForRow(at: IndexPath(row: r, section: s)).size.height;
                }
            }
            return CGSize(width: UIView.noIntrinsicMetric, height: height)
        }
        set { }
    }
}
