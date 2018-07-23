import UIKit
import AVFoundation
import Alamofire
import AlamofireImage
import AVKit
import KDEAudioPlayer

class PlayerViewController: UIViewController, CachingPlayerItemDelegate, AudioPlayerDelegate {
    
    //CachingPlayerItemDelegate
    
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var imgCover: UIImageView!
    @IBOutlet weak var lblProgStart: UILabel!
    @IBOutlet weak var lblProgEnd: UILabel!
    @IBOutlet weak var btnPlay: UIButton!
    @IBOutlet weak var sContent: UISlider!
    
    var content_id:String = ""
    var content_name:String = ""
    var content_banner:String = ""
    var content_category:String = ""
    var content_location:String = ""
    var content_type:String = ""
    var content_date:String = ""
    
    var player: AVPlayer!
    var playerAudio: AVAudioPlayer!
    
    var isPause:Bool = false
    
    var cData:Data? = nil
    
    //Saim KDE PLAYER
    var playerKDE:AudioPlayer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let url = URL(string: content_location)!
        let playerItem = CachingPlayerItem(url: url)
        playerItem.delegate = self
        
        player = AVPlayer(playerItem: playerItem)
        player.automaticallyWaitsToMinimizeStalling = false
        player.play()
        
        self.player!.addPeriodicTimeObserver(forInterval: CMTimeMakeWithSeconds(1, 1), queue: DispatchQueue.main) { (CMTime) -> Void in
            if self.player!.currentItem?.status == .readyToPlay {
                let time : Float64 = CMTimeGetSeconds(self.player!.currentTime())
                self.sContent!.value = Float ( time );
                print(time)
                let m1 : Float64 = floor(time / 60)
                let s1 : Float64 = floor(time - (m1 * 60))
                let m2 = Int(m1)
                let s2 = Int(s1)
                
                self.lblProgEnd.text = "\(m2):\(s2)"
            }
        }
        
        
        
        Alamofire.request(self.content_banner).responseImage { response in
            if let image = response.result.value {
                self.imgCover.image = image
            }
        }
        self.lblName.text = self.content_name
        
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        self.player.pause()
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
                self.player.play()
                b.setImage(i_ps, for: .normal)
                self.isPause = true
            }
            
        }
    }
    
    @IBAction func btnSaveContent(_ sender: Any) {
        let id: Int64 = Int64(content_id)!
        SaveContent.instance.addContent(ID: id, NAME: content_name, BANNER: content_banner, LOCATION: content_location, TYPE: content_type, CATEGORY: content_category, DATE_TIME: content_date)
    }
    
    @IBAction func btnDownload(_ sender: Any) {
        print(SaveContent.instance.getContents())
    }
    
    func playerItem(_ playerItem: CachingPlayerItem, didFinishDownloadingData data: Data) {
        print("File is downloaded and ready for storing")
        self.cData = data
    }
    
    func playerItem(_ playerItem: CachingPlayerItem, didDownloadBytesSoFar bytesDownloaded: Int, outOf bytesExpected: Int) {
        
    }
    
    func playerItemPlaybackStalled(_ playerItem: CachingPlayerItem) {
        print("Not enough data for playback. Probably because of the poor network. Wait a bit and try to play later.")
    }
    
    func playerItem(_ playerItem: CachingPlayerItem, downloadingFailedWith error: Error) {
        print(error)
    }
    
    
    
    
    
}
