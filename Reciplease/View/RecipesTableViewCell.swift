//
//  RecipesTableViewCell.swift
//  Reciplease
//
//  Created by Nathalie Ortonne on 28/09/2020.
//  Copyright © 2020 Nathalie Ortonne. All rights reserved.
//

import UIKit
import AlamofireImage

class RecipesTableViewCell: UITableViewCell {
    
    @IBOutlet weak var recipeImageView: UIImageView!

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subTitleLabel: UILabel!

    @IBOutlet weak var likeLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        addShadow()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        recipeImageView.af.cancelImageRequest()
        recipeImageView.image = nil
    }
    
    private func addShadow() {
        timeLabel.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.7).cgColor
        titleLabel.layer.shadowRadius = 2.0
        titleLabel.layer.shadowOffset = CGSize(width: 2.0, height: 2.0)
        titleLabel.layer.shadowOpacity = 2.0

        subTitleLabel.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.7).cgColor
        subTitleLabel.layer.shadowRadius = 2.0
        subTitleLabel.layer.shadowOffset = CGSize(width: 2.0, height: 2.0)
        subTitleLabel.layer.shadowOpacity = 2.0
    }

    func configure(withTitle title: String, subTitle: [String], like: Int, timing: Int, imageUrl: String) {

        guard let url = URL(string:imageUrl) else { return }

        recipeImageView.af.setImage(withURL: url)
        titleLabel.text = title
        subTitleLabel.text = subTitle.joined(separator: ", ")
        likeLabel.text = String(like)
        timeLabel.text = String(timing)
    }

}
