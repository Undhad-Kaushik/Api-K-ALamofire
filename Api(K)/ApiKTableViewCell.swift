//
//  ApiKTableViewCell.swift
//  Api(K)
//
//  Created by undhad kaushik on 23/03/23.
//

import UIKit
class ApiKTableViewCell: UITableViewCell {
   
    @IBOutlet weak var nameLabel1: UILabel!
    @IBOutlet weak var namelabel2: UILabel!
    @IBOutlet weak var nameLabel3: UILabel!
    @IBOutlet weak var nameLAbel4: UILabel!
    @IBOutlet weak var myImage: UIImageView!
    @IBOutlet weak var spaceWebView: UIWebView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

       
    }

}
