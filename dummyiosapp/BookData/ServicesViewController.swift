//
//  ServicesViewController.swift
//  dummyiosapp
//
//  Created by Maheen on 04/09/2022.
//

import UIKit

extension UIImageView {
    func downloaded(from url: URL, contentMode mode: ContentMode = .scaleAspectFit) {
        contentMode = mode
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else { return }
            DispatchQueue.main.async() { [weak self] in
                self?.image = image
            }
        }.resume()
    }
    func downloaded(from link: String, contentMode mode: ContentMode = .scaleAspectFit) {
        guard let url = URL(string: link) else { return }
        downloaded(from: url, contentMode: mode)
    }
}

class ServicesViewController: UIViewController {
    
    //connections
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var availibilityBook: UILabel!
    @IBOutlet weak var descLbl: UILabel!
    @IBOutlet weak var authorLbl: UILabel!
    @IBOutlet weak var priceLbl: UILabel!
    @IBOutlet weak var bookimg: UIImageView!
    
    var listbook: BookStats?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nameLbl.text = listbook?.localized_name
        authorLbl.text = listbook?.primary_attr
        priceLbl.text = listbook?.price
        descLbl.text = listbook?.bookdescriptions
        availibilityBook.text = listbook?.available
        
        let imgUrl = (listbook?.img)!
        print(imgUrl)
        bookimg.downloaded(from: imgUrl)

    }

}
