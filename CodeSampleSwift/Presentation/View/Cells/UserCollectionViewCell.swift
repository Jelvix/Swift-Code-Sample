//
//  CollectionViewCell.swift
//
//  Copyright © 2017 Jelvix. All rights reserved.
//

import UIKit

class UserCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var likeIcon: UIImageView!
    @IBOutlet weak var dislikeIcon: UIImageView!
    @IBOutlet weak var userAvatar: UIImageView!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var userbio: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupShadow()
        hideIcons()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        hideIcons()
    }
    
    func hideIcons() {
        dislikeIcon.alpha = 0
        likeIcon.alpha = 0
    }
    
    private func setupShadow() {
        self.layer.cornerRadius = 4
        self.layer.shadowRadius = 3
        self.layer.shadowOpacity = 0.2
        self.layer.shadowOffset = CGSize(width:1, height:1)
    }
}
