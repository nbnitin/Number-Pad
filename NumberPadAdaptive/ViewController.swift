//
//  ViewController.swift
//  NumberPadAdaptive
//
//  Created by Nitin on 20/01/20.
//  Copyright © 2020 Nitin. All rights reserved.
//

import UIKit

class keyCell : UICollectionViewCell {
    
   
    
    @IBOutlet weak var lblLetter: UILabel!
    @IBOutlet weak var lblDigit: UILabel!
    
    override var isHighlighted: Bool {
        didSet {
            self.backgroundColor = isHighlighted ? .darkGray : UIColor(white: 0.9, alpha: 1)
            lblDigit.textColor =  isHighlighted ? .white : .black
            lblLetter.textColor = isHighlighted ? .white : .black
        }
    }
    
   
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = frame.width / 2
        self.backgroundColor = UIColor(white: 0.9, alpha: 1)
    }
    
    
   
}

class GreenCallButtonCell : UICollectionViewCell {
    
   
    
    
   
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = frame.width / 2
        self.backgroundColor = .green
    }
    
    
   
}

class BackButtonCell : UICollectionViewCell {
    
   
    
    
   
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = frame.width / 2
        self.backgroundColor = UIColor(white: 0.9, alpha: 1)
    }
    
    
   
}


class DialedNumbersHeader : UICollectionReusableView {
    let lblNumbers = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        lblNumbers.frame = self.frame
        lblNumbers.text = "123"
        lblNumbers.textAlignment = .center
        lblNumbers.font = UIFont.boldSystemFont(ofSize: 24)
            addSubview(lblNumbers)
        lblNumbers.adjustsFontSizeToFitWidth = true
        lblNumbers.frame.origin.x = self.frame.origin.x - 20
        lblNumbers.frame.size.width = self.frame.size.width - 20
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

class ViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {

    @IBOutlet weak var numberCollView: UICollectionView!
    let numbers = ["1","2","3","4","5","6","7","8","9","*","0","#"]
    let digit = ["","ABC","DEF","GHI","JKL","MNO","PQRS","TUV","WXYZ","","+",""]

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        numberCollView.register(DialedNumbersHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "header")
        
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "header", for: indexPath) as! DialedNumbersHeader
        header.lblNumbers.text = dialedNumbersDisplayedString
        return header
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        if ( section == 1 ) {
            return .zero
        }
        let height = view.frame.height * 0.2 //20 % of view
        return .init(width: view.frame.width, height: height)
    }

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if ( section == 0 ) {
            return numbers.count
        }
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if ( indexPath.section == 1 ) {
           if ( indexPath.row == 0 ) {
                      let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "greenCallButtonCell", for: indexPath) as! GreenCallButtonCell

                      return cell
                  }
                  let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "backButtonCell", for: indexPath) as! BackButtonCell
                  return cell
        }
        
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! keyCell
                   cell.lblDigit.text = numbers[indexPath.row]
                   cell.lblLetter.text = digit[indexPath.row]
                   return cell
        
       
        
        
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let leftRightPadding = view.frame.width * 0.15 //15 % of entire width
        let innerSpacing = view.frame.width * 0.1 // 10 % of entire width
        
        let cellWidth = ( view.frame.width - 2 * leftRightPadding - 2 * innerSpacing ) / 3
        
        
        return CGSize(width: cellWidth,height: cellWidth)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        if ( section == 0 ) {
            //some basic math/geometry
                   
                   let leftRightPadding = view.frame.width * 0.15 //15 % of entire width
                  // let innerSpacing = view.frame.width * 0.1 // 10 % of entire width
                   
                   
                   
                   return UIEdgeInsets(top: 16, left: leftRightPadding, bottom: 16, right: leftRightPadding)
        } else if ( section == 1 ) {
            let leftRightPadding = view.frame.width * 0.15 //15 % of entire width
                   let innerSpacing = view.frame.width * 0.1 // 10 % of entire width
                   
                   let cellWidth = ( view.frame.width - 2 * leftRightPadding - 2 * innerSpacing ) / 3
            let leftPadding = (view.frame.width) / 2 - cellWidth / 2
            return UIEdgeInsets(top: 0, left: leftPadding, bottom: 0, right: leftRightPadding)

        }
       return UIEdgeInsets(top: 0, left: 200, bottom: 0, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 16
    }
    
    var dialedNumbersDisplayedString = ""
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if ( indexPath.section == 0 ) {
            dialedNumbersDisplayedString += numbers[indexPath.row]
        } else if ( indexPath.section == 1 && indexPath.item == 1 ) {
            dialedNumbersDisplayedString = String(dialedNumbersDisplayedString.dropLast())
        }
        collectionView.reloadData()
    }

}

