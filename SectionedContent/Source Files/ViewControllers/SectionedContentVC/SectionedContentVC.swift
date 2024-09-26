//
//  SectionedContentVC.swift
//  SwiftAnimationWithUIKit
//
//  Created by Tamim Dari Chowdhury on 9/24/24.
//
import UIKit

class SectionedContentVC: UIViewController {
    
    @IBOutlet var sectionedCV: SectionedContentCollectionView!
    
    override func viewDidLoad(){
        super.viewDidLoad()
        sectionedCV.updateWith(viewModels: self.getContentViewModels())
    }
    
    private func getContentViewModels() -> [SectionedContentCategoryViewModel] {
        
        let contents1: [ContentViewModel] = [
            ContentViewModel(uuid: "1", name: "Content 1"),
            ContentViewModel(uuid: "2", name: "Content 2"),
            ContentViewModel(uuid: "3", name: "Content 3"),
            ContentViewModel(uuid: "4", name: "Content 4"),
        ]
        
        let contents2: [ContentViewModel] = [
            ContentViewModel(uuid: "5", name: "Content 5"),
            ContentViewModel(uuid: "6", name: "Content 6")
            
        ]
        
        let content3: [ContentViewModel] = [
            ContentViewModel(uuid: "7", name: "Content 7"),
            ContentViewModel(uuid: "8", name: "Content 8"),
            ContentViewModel(uuid: "9", name: "Content 9")
        ]
        let categoryModels: [SectionedContentCategoryViewModel] = [
            SectionedContentCategoryViewModel(uuid: "ct1", name: "Cat1", contents: contents1),
            SectionedContentCategoryViewModel(uuid: "ct2", name: "Cat2", contents: contents2),
            SectionedContentCategoryViewModel(uuid: "ct3", name: "Cat3", contents: content3)
        ]
        
        return categoryModels
            
    }
    
}

//-------------
class SectionedContentCategoryViewModel {
    let name: String
    let uuid: String
    let contents: [ContentViewModel]
    init(uuid: String, name: String, contents: [ContentViewModel]){
        self.uuid = uuid
        self.name = name
        self.contents = contents
    }
}

class ContentViewModel {
    let uuid: String
    let name: String
    
    init(uuid: String, name: String) {
        self.uuid = uuid
        self.name = name
    }
    
}


//CollectionView
class SectionedContentCollectionView: UICollectionView {
    let cellID = "SectionedContentCVCell"
    let headerCellID = "SectionedHeaderReusableView"
    var cellViewModels: [SectionedContentCategoryViewModel] = []{
        didSet{
            self.reloadData()
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        setupCV()
    }
    private func setupCV(){
        self.dataSource = self
        self.delegate = self
        
        self.showsVerticalScrollIndicator = false
        self.showsHorizontalScrollIndicator = false
        
        let headerNib = UINib(nibName: headerCellID, bundle: nil)
        self.register(headerNib, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader , withReuseIdentifier: headerCellID)
        self.contentInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 0)
    }
    public func updateWith(viewModels: [SectionedContentCategoryViewModel]){
        self.cellViewModels = viewModels
    }
    
}

extension SectionedContentCollectionView: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, SectionedHeaderReusableViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: 35, height: 76)
        }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader, let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerCellID, for: indexPath) as?  SectionedHeaderReusableView {
            headerView.update(viewModel: cellViewModels[indexPath.section])
            headerView.delegate = self
            return headerView
        }
        fatalError()
    }
    
    func selectedHeader(uuid: String) {
        print("Event: SectionedContentVC: HeaderView selected... uuid: \(uuid)")
    }
    
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return cellViewModels.count
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cellViewModels[section].contents.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as? SectionedContentCVCell {
            cell.configureUI(viewModel: cellViewModels[indexPath.section].contents[indexPath.row])
            return cell
        }
        fatalError()
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        let cell = cell as? SectionedContentCVCell
        cell?.configureUI(viewModel: cellViewModels[indexPath.section].contents[indexPath.row])
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
    }
    
    
    //------Flow Layout ------
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 64.0, height: 76)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 2.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 2, bottom: 0, right: 20)
    }
    
    
    
}

class SectionedContentCVCell: UICollectionViewCell {
    private var label: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: self.bounds.width, height: 20))
        label.font = UIFont.systemFont(ofSize: 11)
        label.textColor = UIColor.black
        self.addSubview(label)
        self.label = label
    }
    
    func configureUI(viewModel: ContentViewModel){
        let randomValue = CGFloat.random(in: 0.3...1)
        self.backgroundColor = UIColor.red.withAlphaComponent(randomValue)
        self.label.text = viewModel.name
    
    }
}


