//
//  MyCustomLayout.swift
//  customCollectionLayout
//
//  Created by Administrator on 01/09/18.
//  Copyright © 2018 MyTeam. All rights reserved.
//

import UIKit

protocol MYCustomLayoutProperties{
    func getHeightOfCollectionItemsAtIndexPath(collectionVW:UICollectionView,indexPath:IndexPath)->CGFloat
}




class MyCustomLayout:UICollectionViewLayout{
    var delegate:MYCustomLayoutProperties?
    var numberofColumns = 2
    private var cacheAttribute = [UICollectionViewLayoutAttributes]()
    private var contentHeight:CGFloat = 0
    private var width : CGFloat{
        return (collectionView?.bounds.width)!
    }
    
    override var collectionViewContentSize: CGSize{
        return CGSize(width: width, height: contentHeight)
    }
    
    
    override func prepare() {
        guard cacheAttribute.isEmpty else{
            return
        }
    
        let columnWidth = width/CGFloat(numberofColumns)
        var xOffsets = [CGFloat]()
        for item in 0..<numberofColumns{
            xOffsets.append(CGFloat(item)*columnWidth)
        }
        
        var yOffsets = [CGFloat](repeating: 0, count: numberofColumns)
        var column = 0
        for item in 0..<(collectionView?.numberOfItems(inSection: 0))!{
            let indexPath = IndexPath(item: item, section: 0)
            let height = delegate?.getHeightOfCollectionItemsAtIndexPath(collectionVW: collectionView!, indexPath: indexPath)
            let frame = CGRect(x: xOffsets[column], y: yOffsets[column], width: width, height: height!)
            let attributes = UICollectionViewLayoutAttributes(forCellWith: indexPath)
            attributes.frame = frame
            cacheAttribute.append(attributes)
            contentHeight = max(contentHeight, frame.maxY)
            yOffsets[column] = yOffsets[column] + height!
            column = column >= (numberofColumns - 1) ? 0 : column + 1
        }
        
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        var collectionAttributes = [UICollectionViewLayoutAttributes]()
        for attributes in cacheAttribute{
            if attributes.frame.intersects(rect){
                collectionAttributes.append(attributes)
            }
        }
        return collectionAttributes
    }
    
    
}
