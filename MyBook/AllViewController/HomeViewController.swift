import UIKit

class HomeViewController: UIViewController {
    
    let preferences = UserDefaults.standard

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    @IBAction func btnAudio(_ sender: Any) {
        let myVC = storyboard?.instantiateViewController(withIdentifier: "storyboardContent") as! ContentUIViewController
        myVC.book_name = "AUDIO"
        myVC.vc_title = "Lates Audio"
        navigationController?.pushViewController(myVC, animated: true)
    }
    
    @IBAction func btnVideo(_ sender: Any) {
        let myVC = storyboard?.instantiateViewController(withIdentifier: "storyboardContent") as! ContentUIViewController
        myVC.book_name = "VIDEO"
        myVC.vc_title = "Lates Video"
        navigationController?.pushViewController(myVC, animated: true)
    }
    
    
}
