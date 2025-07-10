//
//  ImageService.swift
//  PokemonContactApp
//
//  Created by 김이든 on 7/8/25.
//

import UIKit
import Alamofire

final class ImageService {

    // ViewController로 이미지 결과 전달
    var onImageFetched: ((UIImage) -> Void)?

    // 내부 상태 저장용
    private(set) var selectedImage: UIImage?

    // ViewController에서 호출
    func fetchRandomPokemonImage() {
        let randomID = Int.random(in: 1...1000)
        let url = "https://pokeapi.co/api/v2/pokemon/\(randomID)"

        AF.request(url).responseDecodable(of: ImageResponse.self) { [weak self] response in
            guard let self = self else { return }

            switch response.result {
            case .success(let data):
                guard let urlString = data.sprites.frontDefault,
                      let imageURL = URL(string: urlString) else {
                    print("URL 파싱 실패")
                    return
                }
                self.downloadImage(from: imageURL)

            case .failure(let error):
                print("포켓몬 API 실패: \(error)")
            }
        }
    }

    private func downloadImage(from url: URL) {
        AF.request(url).responseData { [weak self] response in
            guard let self = self else { return }

            switch response.result {
            case .success(let data):
                if let image = UIImage(data: data) {
                    self.selectedImage = image
                    self.onImageFetched?(image) // ViewController에게 알림
                }
            case .failure(let error):
                print("이미지 다운로드 실패: \(error)")
            }
        }
    }
}

