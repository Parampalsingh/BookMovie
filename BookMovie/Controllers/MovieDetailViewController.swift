//
//  MovieDetailViewController.swift
//  BookMovie
//
//  Created by Parampal Singh on 01/08/22.
//

import UIKit

class MovieDetailViewController: UIViewController {

    
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var imgMovie: UIImageView!
    @IBOutlet weak var lblOverview: UILabel!
    
    var content: MovieList!
    var genres = ["Family","Animation", "Adventure", "Comedy", "Fantasy"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.self.configure()
       
    }
    
    
    func configure() {
        guard let content = self.content else { return }
        print(content.original_title)
        self.lblName.text = content.original_title
        self.lblOverview.text = content.overview
        
        let url = URL(string: WebPath.KBASEIMAGE_URL + content.poster_path )
        self.imgMovie.sd_setImage(with: url, placeholderImage: nil)
 
    }
    
}

extension MovieDetailViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return genres.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "GenresCollectionViewCell", for: indexPath) as! GenresCollectionViewCell
        cell.lblName.text = genres[indexPath.row]
        cell.bgView.backgroundColor =   .random()
        
        return cell
    }
    
}

extension UIColor {
    static func random() -> UIColor {
        return UIColor(
           red:   .random(),
           green: .random(),
           blue:  .random(),
           alpha: 1.0
        )
    }
}

extension CGFloat {
    static func random() -> CGFloat {
        return CGFloat(arc4random()) / CGFloat(UInt32.max)
    }
}
