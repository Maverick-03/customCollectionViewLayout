//
//  ViewController.swift
//  customCollectionLayout
//
//  Created by Administrator on 01/09/18.
//  Copyright © 2018 MyTeam. All rights reserved.
//

import UIKit

enum colours:Int {
    case red = 0
    case green
    case yellow
    var colour:UIColor{
        switch self {
        case .red:
           return UIColor.red
        case .green:
           return UIColor.green
        case .yellow:
           return UIColor.yellow
            
        default:
           return UIColor.blue
        }
    }
}


class ViewController: UIViewController,MYCustomLayoutProperties,UICollectionViewDataSource {
    func getHeightOfCollectionItemsAtIndexPath(collectionVW: UICollectionView, indexPath: IndexPath) -> CGFloat {
        let randomNumber = arc4random_uniform(4) + 1

        return CGFloat(40*randomNumber)
    }
    
    @IBOutlet weak var collectionView:UICollectionView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        initialCollectionView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    func initialCollectionView(){
        (collectionView.collectionViewLayout as! MyCustomLayout).delegate = self
        collectionView.reloadData()
    }
    
    //MARK: - DataSource
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionCell", for: indexPath)
        let randomNumber = arc4random_uniform(4)
        let colour  = colours.init(rawValue: Int(randomNumber))?.colour
        cell.backgroundColor = colour
        return cell
    }
    
    
}

