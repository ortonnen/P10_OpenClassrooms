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

    //MARK: - Outlet
    @IBOutlet weak var recipeImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subTitleLabel: UILabel!
    @IBOutlet weak var likeLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!


    //MARK: - Methods
    override func awakeFromNib() {
        super.awakeFromNib()

        addShadow()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        recipeImageView.af.cancelImageRequest()
        recipeImageView.image = nil
    }
    /// add shadow for title and subtitle
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

    ///configure cell appearance
    func configure(withTitle title: String, subTitle: [String], like: Double, timing: Double, imageUrl: String) {

        guard let url = URL(string:imageUrl) else {
            return }

        recipeImageView.af.setImage(withURL: url)
        titleLabel.text = title
        subTitleLabel.text = subTitle.joined(separator: ", ")
        likeLabel.text = String(like)
        timeLabel.text = String(timing)
    }
}
