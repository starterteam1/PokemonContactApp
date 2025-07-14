//
//  AddContactViewModel.swift
//  PokemonContactApp
//
//  Created by 김이든 on 7/10/25.
//

// AddContactViewModel.swift

import Foundation
import Alamofire

enum ContactMode {
    case create
    case detail(model: ContactModel)
}

protocol AddContactViewModelDelegate: AnyObject {
    func didFetchPokemonImage(_ data: Data)
}

final class AddContactViewModel {
    weak var delegate: AddContactViewModelDelegate?
    private let coreDataManage = CoreDataManage()
    
    let mode: ContactMode
    
    var contact: ContactModel? {
        switch mode {
        case .create: return nil
        case .detail(let model): return model
        }
    }
    
    init(mode: ContactMode) {
        self.mode = mode
    }
}

//MARK: - 포켓몬 이미지 데이터 요청
extension AddContactViewModel {

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
                self.fetchImageData(from: imageURL)

            case .failure(let error):
                print("포켓몬 API 실패: \(error)")
            }
        }
    }

    private func fetchImageData(from url: URL) {
        AF.request(url).responseData { [weak self] response in
            guard let self = self else { return }

            switch response.result {
            case .success(let data):
                self.delegate?.didFetchPokemonImage(data)
                
            case .failure(let error):
                print("이미지 데이터 실패: \(error)")
            }
        }
    }
}

//MARK: - CoreData
extension AddContactViewModel {
    func saveContact(image: Data, name: String, phoneNumber: String) {
        switch mode {
        case .create:
            coreDataManage.createData(image: image, name: name, phoneNumber: phoneNumber)
        case .detail(let model):
            coreDataManage.updateData(id: model.id, name: name, phoneNumber: phoneNumber, image: image)
        }
    }
}


