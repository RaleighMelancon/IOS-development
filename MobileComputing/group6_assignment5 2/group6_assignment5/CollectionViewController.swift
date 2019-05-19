//
//  CollectionViewController.swift
//  group6_assignment5
//
//  Created by Hughes, Brady L on 3/8/19.
//  Copyright © 2019 Hughes, Brady L. All rights reserved.
//

import Foundation
import UIKit

class animalCollectionViewController2: UICollectionViewController{
    var animalList:[Animal] = []
    
    override func viewDidLoad() {
        print ("print")
        super.viewDidLoad()
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print ("Num in Section")
        return 12
    }
    override func collectionView(_ collectionView: UICollectionView,
                        viewForSupplementaryElementOfKind kind: String,
                        at indexPath: IndexPath) -> UICollectionReusableView {
        
        switch kind {
            
        case UICollectionElementKindSectionHeader:
            let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "animalHeader", for: indexPath)
            
            return headerView
            
        case UICollectionElementKindSectionFooter:
            let footerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "animalFooter", for: indexPath)
            
            return footerView
            
        default:
            assert(false, "ERROR")
        }
    }
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cellname = "animalCollectionCell"
        let animalID: Int = Int(indexPath.row/3)
        let picID = indexPath.row%3
        print ("finished cell setup")
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier:cellname, for: indexPath as IndexPath) as! AnimalCollectionViewCell
        print (cell.animalCaption.text)
        let currentAnimal = animalList[animalID]
        
        let photo = currentAnimal.album[picID].image
        let caption = currentAnimal.album[picID].caption
        
        cell.animalCaption.text = caption
        cell.animalImage.image = photo
        
        return cell
    }
}
