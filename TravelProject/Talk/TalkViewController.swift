//
//  TalkViewController.swift
//  TravelProject
//
//  Created by 이빈 on 1/10/25.
//

import UIKit

class TalkViewController: UIViewController, setView {
    
    @IBOutlet var searchBar: UISearchBar!
    @IBOutlet var chatRoomCollectionView: UICollectionView!
    
    
    var currentChatList: [ChatRoom] = mockChatList {
        didSet {
            chatRoomCollectionView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setDesign()
    }
    
    func setDesign() {
        basicDesign()
        searchBarDesign()
        collectionViewDesign()
    }
    
    func basicDesign() {
        self.navigationController?.navigationBar.tintColor = .black
        self.navigationController?.navigationBar.topItem?.backButtonTitle = ""
    }

    func searchBarDesign() {
        searchBar.delegate = self
        searchBar.placeholder = "친구 이름을 검색해 보세요"
    }
    
    func collectionViewDesign() {
        chatRoomCollectionView.delegate = self
        chatRoomCollectionView.dataSource = self
        
        let xib = UINib(nibName: TalkCollectionViewCell.identifier, bundle: nil)
        chatRoomCollectionView.register(xib, forCellWithReuseIdentifier: TalkCollectionViewCell.identifier)
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        
        let deviceWidth: CGFloat = UIScreen.main.bounds.width
        layout.itemSize = CGSize(width: deviceWidth, height: 80)
        
        chatRoomCollectionView.collectionViewLayout = layout
        
    }
    
}

extension TalkViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return currentChatList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TalkCollectionViewCell.identifier, for: indexPath) as! TalkCollectionViewCell
        
        let item = currentChatList[indexPath.item]
        cell.configureData(item)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // 선택한 셀의 태그에 맞게 화면 전환!-!
        guard let vc = storyboard?.instantiateViewController(withIdentifier: ChattingViewController.identifier) as? ChattingViewController else {
            print("전환할 화면이 없는데요..")
            return
        }

        // indexPath.item에 있는 셀의 태그와 mockChatList의 chatRoom의 chatroomId가 같은 것 찾기
        guard let cellTag = chatRoomCollectionView.cellForItem(at: indexPath)?.tag else {
            print("그런 태그 가진 애 없어요~~")
            return
        }
        
        let room = mockChatList.filter{ $0.chatroomId == cellTag }[0]
        vc.chatRoomName = room.chatroomName
        vc.chatDetailList = room.chatList
        vc.lastIndex = IndexPath(row: room.chatList.count - 1, section: 0)
        
        navigationController?.pushViewController(vc, animated: true)
        
    }
    
}

extension TalkViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print(#function)
        print(searchText)
        
        var flag: Bool = false
        var updateRooms: [ChatRoom] = []
        
        if searchText.isEmpty {
            currentChatList = mockChatList
        }
        
        for chatRoom in mockChatList {
            flag = false
            for chat in chatRoom.chatList {
                // 검색하는 내용이랑 같으면 currentChatList 업데이트
                if searchText.lowercased() == chat.user.rawValue.lowercased() {
                    print("같당")
                    flag = true
                    continue
                }
            }
            if flag { // 검색하는 사용자가 있으면 넣어주기
                updateRooms.append(chatRoom)
                currentChatList = updateRooms
            }
        }
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        view.endEditing(true)
    }
}
