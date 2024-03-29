//
//  SettingView.swift
//  voiceMemo
//
//  Created by 엄태양 on 2/16/24.
//

import SwiftUI

struct SettingView: View {
    @EnvironmentObject private var homeViewModel: HomeViewModel
    
    var body: some View {
        
        VStack {
            
            TitleView()
            
            Spacer()
                .frame(height: 35)
            
            TotalTapCountView()
            
            Spacer()
                .frame(height: 35)
            
            TotalTapMoveView()
            
            Spacer()
        }
        
    }
}

//MARK: - 타이틀 뷰

private struct TitleView: View {
    fileprivate var body: some View {
        HStack {
            Text("설정")
                .font(.system(size: 30, weight: .bold))
                .foregroundColor(.customBlack)
                
            Spacer()
        }
        
        .padding(.horizontal, 30)
        .padding(.top, 45)
    }
}

//MARK: - 전체 탭 설정된 카운트 뷰

private struct TotalTapCountView: View {
    @EnvironmentObject private var homeViewModel: HomeViewModel
    
    fileprivate var body: some View {
        //각각 탭 카운트 뷰(todoList, 메모장, 음성메모장)
        HStack {
            Spacer()
            
            TabCountView(
                title: "To do",
                count: homeViewModel.todosCount
            )
            
            Spacer()
                .frame(width: 70)
            
            TabCountView(
                title: "메모",
                count: homeViewModel.memosCount
            )
            
            Spacer()
                .frame(width: 70)
            
            TabCountView(
                title: "음성 메모",
                count: homeViewModel.voiceRecorderCount
            )
            
            Spacer()
        }
    }
}

//MARK: - 각 탭 설정된 카운트 뷰(공통 뷰)

private struct TabCountView: View {
    private var title: String
    private var count: Int
    
    fileprivate init(
        title: String,
        count: Int
    ) {
        self.title = title
        self.count = count
    }
    
    fileprivate var body: some View {
        VStack(spacing: 5) {
            Text("\(title)")
                .font(.system(size: 14))
                .foregroundColor(.customBlack)
            
            Text("\(count)")
                .font(.system(size: 30, weight: .medium))
                .foregroundColor(.customBlack)
        }
    }
}

//MARK: - 전체 탭 이동 뷰

private struct TotalTapMoveView: View {
    @EnvironmentObject private var homeViewModel: HomeViewModel
    fileprivate var body: some View {
        VStack {
            Rectangle()
                .fill(.customGray1)
                .frame(height: 1)
            
            TapMoveView(
                title: "To do 리스트", 
                tapAction: { homeViewModel.changeSelectedTab(.todoList) }
            )
            
            TapMoveView(
                title: "메모", 
                tapAction: { homeViewModel.changeSelectedTab(.memo) }
            )
            
            TapMoveView(
                title: "음성 메모", 
                tapAction: { homeViewModel.changeSelectedTab(.voiceRecorder) }
            )
            
            TapMoveView(
                title: "타이머", 
                tapAction: { homeViewModel.changeSelectedTab(.timer) }
            )
            
            
            Rectangle()
                .fill(.customGray1)
                .frame(height: 1)
            
        }
    }
}

//MARK: - 탭 이동 뷰

private struct TapMoveView: View {
    private var title: String
    private var tapAction: () -> Void
    
    fileprivate init(
        title: String,
        tapAction: @escaping () -> Void
    ) {
        self.title = title
        self.tapAction = tapAction
    }
    
    fileprivate var body: some View {
        Button(
            action: { tapAction() },
            label: {
                HStack {
                    Text(title)
                        .font(.system(size: 14))
                        .foregroundColor(.customBlack)
                    
                    Spacer()
                    
                    Image("arrowRight")
                }
            }
        )
        .padding(.all, 20)
    }
}

#Preview {
    SettingView()
        .environmentObject(HomeViewModel())
}
