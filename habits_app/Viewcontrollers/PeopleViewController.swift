//
//  PeopleViewController.swift
//  habits_app
//
//  Created by Home PC on 2/13/25.
//

import UIKit

class PeopleViewController: UIViewController {

    @IBOutlet weak var peopleCollectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()

        //self.peopleCollectionView.
        // Do any additional setup after loading the view.
        self.peopleCollectionView.collectionViewLayout = UICollectionViewFlowLayout()
        
    }
}

extension PeopleViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "peopleCell", for: indexPath)
        cell.backgroundColor = .systemBlue
        return cell
    }
}

extension PeopleViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 200, height: 300)
    }
}
