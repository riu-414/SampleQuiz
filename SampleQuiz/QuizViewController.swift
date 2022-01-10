//
//  QuizViewController.swift
//  SampleQuiz
//
//  Created by 大杉祐弥 on 2022/01/01.
//

import UIKit
//import GoogleMobileAds

class QuizViewController: UIViewController {
    @IBOutlet weak var quizNumberLabel: UILabel!
    @IBOutlet weak var quizTextView: UITextView!
    @IBOutlet weak var answerButton1: UIButton!
    @IBOutlet weak var answerButton2: UIButton!
    @IBOutlet weak var answerButton3: UIButton!
    @IBOutlet weak var answerButton4: UIButton!
    @IBOutlet weak var judgeImageView: UIImageView!
    
//    var bannerView: GADBannerView!
    var csvArray: [String] = []
    var quizArray: [String] = []
    var quizConut = 0
    var correctCount = 0
    var selectLevel = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        bannerView = GADBannerView(adSize: kGADAdSizeBanner)
//        bannerView.adUnitID = "ca-app-pub-4616652627281444~2787924256"
//        bannerView.rootViewController = self
//        bannerView.load(GADRequest())
//        addBannerViewToView(bannerView)
        
        print("選択したレベル\(selectLevel)")
        
        csvArray = loadCSV(fileName: "quiz\(selectLevel)")
        csvArray.shuffle()
        print(csvArray)
        
        quizArray = csvArray[quizConut].components(separatedBy: ",")
        
        quizNumberLabel.text = "第\(quizConut + 1)問"
        quizTextView.text = quizArray[0]
        answerButton1.setTitle(quizArray[2], for: .normal)
        answerButton2.setTitle(quizArray[3], for: .normal)
        answerButton3.setTitle(quizArray[4], for: .normal)
        answerButton4.setTitle(quizArray[5], for: .normal)
        
        answerButton1.layer.borderWidth = 2
        answerButton1.layer.borderColor = UIColor.black.cgColor
        answerButton2.layer.borderWidth = 2
        answerButton2.layer.borderColor = UIColor.black.cgColor
        answerButton3.layer.borderWidth = 2
        answerButton3.layer.borderColor = UIColor.black.cgColor
        answerButton4.layer.borderWidth = 2
        answerButton4.layer.borderColor = UIColor.black.cgColor
        
        // Do any additional setup after loading the view.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let scoreVC = segue.destination as! ScoreViewController
        scoreVC.correct = correctCount
    }
    
    @IBAction func btnAction(sender: UIButton) {
        if sender.tag == Int(quizArray[1]) {
            print("正解")
            correctCount += 1
            judgeImageView.image = UIImage(named: "correct")
        } else {
            print("不正解")
            judgeImageView.image = UIImage(named: "incorrect")
        }
        print("スコア:\(correctCount)")
        judgeImageView.isHidden = false
        answerButton1.isEnabled = false
        answerButton2.isEnabled = false
        answerButton3.isEnabled = false
        answerButton4.isEnabled = false
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.judgeImageView.isHidden = true
            self.answerButton1.isEnabled = true
            self.answerButton2.isEnabled = true
            self.answerButton3.isEnabled = true
            self.answerButton4.isEnabled = true
            self.netxQuiz()
        }
    }
    
    func netxQuiz() {
        quizConut += 1
        if quizConut < csvArray.count {
            quizArray = csvArray[quizConut].components(separatedBy: ",")
            quizNumberLabel.text = "第\(quizConut + 1)問"
            quizTextView.text = quizArray[0]
            answerButton1.setTitle(quizArray[2], for: .normal)
            answerButton2.setTitle(quizArray[3], for: .normal)
            answerButton3.setTitle(quizArray[4], for: .normal)
            answerButton4.setTitle(quizArray[5], for: .normal)
        } else {
            performSegue(withIdentifier: "toScoreVC", sender: nil)
        }
    }
    
    func loadCSV(fileName: String) -> [String] {
        let csvBundle = Bundle.main.path(forResource: fileName, ofType: "csv")!
        do {
            let csvDate = try String(contentsOfFile: csvBundle, encoding: String.Encoding.utf8)
            let lineCange = csvDate.replacingOccurrences(of: "\r", with: "\n")
            csvArray = lineCange.components(separatedBy: "\n")
            csvArray.removeLast()
        } catch {
            print("エラー")
        }
        return csvArray
    }
    
//    func addBannerViewToView(_ bannerView: GADBannerView) {
//        bannerView.translatesAutoresizingMaskIntoConstraints = false
//        view.addSubview(bannerView)
//        view.addConstraints(
//            [NSLayoutConstraint(item: bannerView,
//                                attribute: .bottun,
//                                relatedBy: equal,
//                                toItem: view.safeAreaLayoutGuide,
//                                attribute: .bottom,
//                                multiplier: 1,
//                                constant: 0),
//             NSLayoutConstraint(item: bannerView,
//                                attribute: .centerX,
//                                relatedBy: .equal,
//                                toItem: view,
//                                attribute: .centerX,
//                                multiplier: 1,
//                                constant: 0)
//            ])
//    }

    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
