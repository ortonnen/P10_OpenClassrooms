//
//  FavoriteRecipesTableViewCell.swift
//  Reciplease
//
//  Created by Nathalie Ortonne on 12/10/2020.
//  Copyright © 2020 Nathalie Ortonne. All rights reserved.
//

import UIKit

class FavoriteRecipesTableViewCell: UITableViewCell {

    @IBOutlet weak var recipeImageView: UIImageView!

    @IBOutlet weak var subtitleLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!

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
        titleLabel.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.7).cgColor
        titleLabel.layer.shadowRadius = 2.0
        titleLabel.layer.shadowOffset = CGSize(width: 2.0, height: 2.0)
        titleLabel.layer.shadowOpacity = 2.0

        subtitleLabel.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.7).cgColor
        subtitleLabel.layer.shadowRadius = 2.0
        subtitleLabel.layer.shadowOffset = CGSize(width: 2.0, height: 2.0)
        subtitleLabel.layer.shadowOpacity = 2.0
    }

    func configure(withTitle title: String, subTitle: String, imageUrl: String) {

        guard let url = URL(string:imageUrl) else { return }

        recipeImageView.af.setImage(withURL: url)
        titleLabel.text = title
        subtitleLabel.text = subTitle
    }

}
