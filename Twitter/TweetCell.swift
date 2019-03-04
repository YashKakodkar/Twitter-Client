//
//  TweetCell.swift
//  Twitter
//
//  Created by Yash Kakodkar on 2/25/19.
//  Copyright © 2019 Dan. All rights reserved.
//

import UIKit

class TweetCell: UITableViewCell {

    @IBOutlet weak var retweetButton: UIButton!
    @IBOutlet weak var heartButton: UIButton!
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var tweetContent: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var retweetCountLabel: UILabel!
    @IBOutlet weak var favoriteCountLabel: UILabel!
    
    
    @IBAction func retweet(_ sender: Any) {
        TwitterAPICaller.client?.retweet(tweetId: tweetId, success: {
            self.setRetweet(true)
        }, failure: { (error) in
            print("Error in retweeting: \(error)")
        })
    
    }
    
    @IBAction func heart(_ sender: Any) {
    
        let toBeFavorited = !hearted
        if(toBeFavorited){
            TwitterAPICaller.client?.favoriteTweet(tweetId: tweetId, success: {
                self.setHeart(isHearted: true)
                }, failure: { (error) in
                    print("Favorite did not succeed. Errror: \(error)")
                })
        }else{
            TwitterAPICaller.client?.unFavoriteTweet(tweetId: tweetId, success: {
                self.setHeart(isHearted: false)
            }, failure: { (error) in
                print("Unfavorite did not succeed. Errror: \(error)")
            })
        }
    }
    
    var retweeted:Bool = false
    var hearted:Bool = false
    var tweetId:Int = -1
    
    
    func setRetweet(_ isRetweeted: Bool){
        retweeted = isRetweeted
        if(retweeted){
            retweetButton.setImage(UIImage(named:
                "RetweetColor"), for: UIControl.State.normal)
            retweetButton.isEnabled = false
            retweetButton.adjustsImageWhenDisabled = false
        }else{
            retweetButton.setImage(UIImage(named:
                "RetweetDecolor"), for: UIControl.State.normal)
            retweetButton.isEnabled = true
        }
    }
    
    func setHeart(isHearted:Bool){
        hearted = isHearted
        if(hearted){
            heartButton.setImage(UIImage(named:
                "HeartColor"), for: UIControl.State.normal)
        }else{
            heartButton.setImage(UIImage(named:
                "HeartDecolor"), for: UIControl.State.normal)
        }
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        profileImageView.layer.cornerRadius = profileImageView.frame.width/2
        self.clipsToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
