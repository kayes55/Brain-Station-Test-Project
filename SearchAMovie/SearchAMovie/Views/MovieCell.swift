//
//
// SearchAMovie
// Running on MacOS Version 12.4
// Swift Version 5.0
// Created by kayes on 8/12/22
// Copyright © IMRUL KAYES. All rights reserved.


import UIKit

class MovieCell: UITableViewCell {
    
    @IBOutlet weak var imageForMovie: CachedImageView!
    
    @IBOutlet weak var title: UILabel!
    
    @IBOutlet weak var body: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
