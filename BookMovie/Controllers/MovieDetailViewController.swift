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
