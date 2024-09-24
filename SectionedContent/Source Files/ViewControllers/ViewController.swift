//
//  ViewController.swift
//  SectionedContent
//
//  Created by Tamim Dari Chowdhury on 9/25/24.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func openContentVCButtonPressed(_ sender: UIButton) {
        self.presentSectionedContentVC()
    }
    

    func presentSectionedContentVC(){
        let storyboard = UIStoryboard(name: "SectionedContentVC", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "SectionedContentVC") as! SectionedContentVC
        self.present(vc, animated: true)
    }

}

