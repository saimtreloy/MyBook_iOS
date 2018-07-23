import UIKit
import Alamofire
import AlamofireImage
import KDEAudioPlayer

class KdePlayerViewController: UIViewController, AudioPlayerDelegate {
    
    var content_id:String = ""
    var content_name:String = ""
    var content_banner:String = ""
    var content_category:String = ""
    var content_location:String = ""
    var content_type:String = ""
    var content_date:String = ""

    @IBOutlet weak var lblContentName: UILabel!
    @IBOutlet weak var lblTimeStart: UILabel!
    @IBOutlet weak var lblTimeEnd: UILabel!
    @IBOutlet weak var imgContentCover: UIImageView!
    @IBOutlet weak var sdContentSlider: UISlider!
    
    //KDE PLAYER
    var player:AudioPlayer!
    var isPause:Bool = false
    var totalDuration:Int64 = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let url = URL(string: content_location)!
        let delegate: AudioPlayerDelegate = self
        player = AudioPlayer()
        player.delegate = delegate
        let item = AudioItem(mediumQualitySoundURL: url)
        player.play(item: item!)
        
        Alamofire.request(self.content_banner).responseImage { response in
            if let image = response.result.value {
                self.imgContentCover.image = image
            }
        }
        self.lblContentName.text = self.content_name
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        self.player.stop()
    }

    @IBAction func btnPlayAction(_ sender: Any) {
        DispatchQueue.main.async {
            
            let b = sender as! UIButton
            let i_pl = UIImage(named: "ic_play")
            let i_ps = UIImage(named: "ic_pause")
            if self.isPause == true {
                self.player.pause()
                b.setImage(i_pl, for: .normal)
                self.isPause = false
            } else if self.isPause == false {
                self.player.resume()
                b.setImage(i_ps, for: .normal)
                self.isPause = true
            }
            
        }
    }
    
    @IBAction func btnSaveAction(_ sender: Any) {
        let id: Int64 = Int64(content_id)!
        SaveContent.instance.addContent(ID: id, NAME: content_name, BANNER: content_banner, LOCATION: content_location, TYPE: content_type, CATEGORY: content_category, DATE_TIME: content_date)
    }
    
    @IBAction func btnDownloadAction(_ sender: Any) {
        player.seek(to: 100)
    }
    
    @IBAction func sContentSliderAction(_ sender: Any) {
        let sd = sender as! UISlider
        let ss:Int64 = ((totalDuration * Int64(sd.value)) / 100)
        self.player.seek(to: TimeInterval(ss))
        print(sd.value)
    }
    
    func audioPlayer(_ audioPlayer: AudioPlayer, didFindDuration duration: TimeInterval, for item: AudioItem) {
        print(duration)
        self.totalDuration = Int64(duration)
        let m:Int64 = Int64(duration)/60
        let s:Int64 = Int64(duration)%60
        self.lblTimeEnd.text = "\(m):\(s)"
    }
    
    func audioPlayer(_ audioPlayer: AudioPlayer, didUpdateProgressionTo time: TimeInterval, percentageRead: Float) {
        print(percentageRead)
        let m:Int64 = Int64(time)/60
        let s:Int64 = Int64(time)%60
        self.lblTimeStart.text = "\(m):\(s)"
        self.sdContentSlider.value = percentageRead
    }
    
}
