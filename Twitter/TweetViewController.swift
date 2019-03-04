//
//  TweetViewController.swift
//  Twitter
//
//  Created by Yash Kakodkar on 3/1/19.
//  Copyright © 2019 Dan. All rights reserved.
//

import UIKit

class TweetViewController: UIViewController,UITextViewDelegate {

    var credArray = [String:Any]()
    @IBOutlet weak var tweetContent: UITextView!
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var limitLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tweetContent.text = "What's happening?"
        tweetContent.textColor = UIColor.lightGray
        tweetContent.becomeFirstResponder()
        tweetContent.selectedTextRange = tweetContent.textRange(from: tweetContent.beginningOfDocument, to: tweetContent.beginningOfDocument)

        //getProfilePic()
        profileImage.layer.cornerRadius = profileImage.frame.width/2
        //self.clipsToBounds = true
        tweetContent.delegate = self
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        //updateCharCount()
    }
    
    
    func textViewDidChangeSelection(_ textView: UITextView) {
        if self.view.window != nil {
            if textView.textColor == UIColor.lightGray {
                textView.selectedTextRange = textView.textRange(from: textView.beginningOfDocument, to: textView.beginningOfDocument)
            }
        }
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        
        // Combine the textView text and the replacement text to
        // create the updated text string
        let currentText:String = tweetContent.text
        let updatedText = (currentText as NSString).replacingCharacters(in: range, with: text)
        
        // If updated text view will be empty, add the placeholder
        // and set the cursor to the beginning of the text view
        if updatedText.isEmpty {
            
            tweetContent.text = "What's happening?"
            tweetContent.textColor = UIColor.lightGray
            
            tweetContent.selectedTextRange = tweetContent.textRange(from: tweetContent.beginningOfDocument, to: tweetContent.beginningOfDocument)
        }
            
            // Else if the text view's placeholder is showing and the
            // length of the replacement string is greater than 0, set
            // the text color to black then set its text to the
            // replacement string
        else if tweetContent.textColor == UIColor.lightGray && !text.isEmpty {
            tweetContent.textColor = UIColor.black
            tweetContent.text = text
        }
        
    
        let changedText = (textView.text as NSString).replacingCharacters(in: range, with: text)
        
        // to handle user pasting over the character limit
        if changedText.count > 140 || tweetContent.textColor == UIColor.lightGray {
            limitLabel.text = "140"
        } else {
            limitLabel.text = "\(140 - changedText.count)"
        }
        
        return changedText.count <= 140
    }
    
    func updateCharCount(){
        limitLabel.text = "\(tweetContent.text.count)/140"
    }
    
    
//    func getProfilePic(){
//
//
//        let myUrl = "https://api.twitter.com/1.1/account/verify_credentials.json"
//        let params: [String:Any] = [:]
//
//        TwitterAPICaller.client?.getDictionariesRequest(url: myUrl, parameters: params as [String : Any], success: { (credentials: [NSDictionary]) in
//            print("Count: \(self.credArray.count)")
//            self.credArray = credentials as! Dictionary<String,Any>
//            //self.credArray.removeAll()
////            for info in credentials {
////                self.credArray.append(info)
////            }
//            print("Count: \(self.credArray.count)")
//
//        }, failure: { (Error) in
//            print("Could not retrieve credentials")
//        })
//
//
//        //let user = credArray[0]
//        let imageString = credArray["profile_image_url_https"] as? String
//        let bigImage = imageString?.replacingOccurrences(of: "_normal.jpg", with: "_bigger.jpg")
//        let imageUrl = URL(string: bigImage!)
//        print("PI URL: \(String(describing: credArray["profile_image_url_https"] as? String))")
//        let data = try? Data(contentsOf: imageUrl!)
//
//        if let imageData = data {
//            profileImage.image = UIImage(data: imageData)
//        }
//
//
//    }
    
    
    @IBAction func cancel(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func tweet(_ sender: Any) {
        
        if (!tweetContent.text.isEmpty){
            TwitterAPICaller.client?.postTweet(tweetString: tweetContent.text,success: {
                self.dismiss(animated: true, completion: nil)
            }, failure: { (error) in
                print("Error posting tweet \(error)")
                self.dismiss(animated: true, completion: nil)
            })
        } else {
            self.dismiss(animated: true, completion: nil)
        }
        
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
