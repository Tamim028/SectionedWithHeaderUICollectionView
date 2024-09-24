//
//  SectionedHeaderReusableView.swift
//  SwiftAnimationWithUIKit
//
//  Created by Tamim Dari Chowdhury on 9/25/24.
//

import UIKit

class SectionedHeaderReusableView: UICollectionReusableView {

    @IBOutlet var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    func update(viewModel: SectionedContentCategoryViewModel){
        self.titleLabel.text = viewModel.name
    }
    
}
