//
//  SectionedHeaderReusableView.swift
//  SwiftAnimationWithUIKit
//
//  Created by Tamim Dari Chowdhury on 9/25/24.
//

import UIKit

protocol SectionedHeaderReusableViewDelegate: NSObjectProtocol {
    func selectedHeader(uuid: String)
}

class SectionedHeaderReusableView: UICollectionReusableView {
    weak var delegate: SectionedHeaderReusableViewDelegate? = nil
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var mainContentView: UIView!
    private var uuid: String!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        let tap = UITapGestureRecognizer(target: self, action: #selector(headerTapped))
        self.mainContentView.addGestureRecognizer(tap)
    }
    
    func update(viewModel: SectionedContentCategoryViewModel){
        self.titleLabel.text = viewModel.name
        self.uuid = viewModel.uuid
    }

    @objc func headerTapped(){
        self.delegate?.selectedHeader(uuid: self.uuid)
    }
    
}
