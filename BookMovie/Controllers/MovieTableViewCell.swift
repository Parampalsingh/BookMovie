//
//  MovieTableViewCell.swift
//  BookMovie
//
//  Created by Parampal Singh on 31/07/22.
//

import UIKit
import Foundation
import SDWebImage

class MovieTableViewCell: UITableViewCell {
    
    var content: MovieList? {
        didSet {
            self.configure()
        }
    }
    
    @IBOutlet weak var lblTittle: UILabel!
    @IBOutlet weak var imgMovie: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        imgMovie.layer.cornerRadius = 10.0
        imgMovie.clipsToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    
    func configure() {
        guard let content = self.content else { return }
        
        self.lblTittle.text = content.original_title
        
        let url = URL(string: WebPath.KBASEIMAGE_URL + content.poster_path )
        self.imgMovie.sd_setImage(with: url, placeholderImage: nil)

        
        
    }
}
