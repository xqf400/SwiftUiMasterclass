//
//  ContentView.swift
//  Honeymoon
//
//  Created by Fabian Kuschke on 07.09.22.
//

import SwiftUI

struct ContentView: View {
    //MARK: Properties
    
    @State var showAlert: Bool = false
    @State var showGuide: Bool = false
    @State var showInfo: Bool = false
    @GestureState private var dragState = DragState.inactive
    private var dragAreaThreshold: CGFloat = 65.0
    @State private var lastCardsIndex: Int = 1
    @State private var cardRemovalTransition = AnyTransition.tralingBottom
    
    //MARK: Card views
    
    @State var cardViews: [CardView] = {
        var views = [CardView]()
        for index in 0..<2 {
            views.append(CardView(honeymonn: honeymoonData[index]))
        }
        return views
    }()
    
    //MARK: Move Cards
    private func moveCards(){
        cardViews.removeFirst()
        self.lastCardsIndex += 1
        print("Destination: \(lastCardsIndex % honeymoonData.count)")
        let honeymoon = honeymoonData[lastCardsIndex % honeymoonData.count]
        let newCardView = CardView(honeymonn: honeymoon)
        cardViews.append(newCardView)
    }
    
    //MARK: Top card
    private func isTopCard(cardView:CardView) -> Bool{
        guard let index = cardViews.firstIndex(where: {$0.id == cardView.id}) else{
            return false
        }
        return index == 0
    }
    
    //MARK: Drag State
    enum DragState {
        case inactive
        case pressing
        case dragging(translation: CGSize)
        
        var translation: CGSize{
            switch self {
            case .inactive, .pressing:
                return .zero
            case .dragging(translation: let translation):
                return translation
            }
        }
        
        var isDragging: Bool {
            switch self{
            case .inactive, .pressing:
                return false
            case .dragging:
                return true
            }
        }
        
        var isPressing: Bool{
            switch self{
            case .dragging, .pressing:
                return true
            case .inactive:
                return false
            }
        }
    }
    
    var body: some View {
        VStack {
            //MARK: Header
            HeaderView(showGuideView: $showGuide, showInfoView: $showInfo)
                .opacity(dragState.isDragging ? 0.0:1.0)
                .animation(.default, value: showInfo)
            Spacer()
            
            //MARK: Cards
            ZStack{
                ForEach(cardViews){ cardView in
                    cardView
                        .zIndex(self.isTopCard(cardView: cardView) ? 1 : 0)
                        .overlay(
                            ZStack{
                                //X Mark symbol
                                Image(systemName: "x.circle")
                                    .foregroundColor(.red)
                                    .modifier(SymbolModifier())
                                    .opacity(self.dragState.translation.width < -self.dragAreaThreshold && self.isTopCard(cardView: cardView) ? 1.0 : 0.0)
                                //Heart Symbol
                                Image(systemName: "heart.circle")
                                    .foregroundColor(.green)
                                    .modifier(SymbolModifier())
                                    .opacity(self.dragState.translation.width > self.dragAreaThreshold && self.isTopCard(cardView: cardView) ? 1.0 : 0.0)
                            }
                        )
                        .offset(x: self.isTopCard(cardView: cardView) ? self.dragState.translation.width: 0, y: self.isTopCard(cardView: cardView) ? self.dragState.translation.height : 0)
                        .scaleEffect(self.dragState.isDragging && self.isTopCard(cardView: cardView) ? 0.85: 1.0)
                        .rotationEffect(Angle(degrees: self.isTopCard(cardView: cardView) ? Double(self.dragState.translation.width/12) : 0))
                        .animation(.interpolatingSpring(stiffness: 120, damping: 120), value: self.dragState.translation)
                        .gesture(LongPressGesture(minimumDuration: 0.01)
                            .sequenced(before: DragGesture())
                            .updating(self.$dragState, body: { value, state, transaction in
                                switch value {
                                case .first(true):
                                    state = .pressing
                                case .second(true, let drag):
                                    state = .dragging(translation: drag?.translation ?? .zero )
                                default:
                                    break
                                }
                            })
                                .onChanged({ (value) in
                                    guard case .second(true, let drag?) = value else{
                                        return
                                    }
                                    if drag.translation.width < -self.dragAreaThreshold{
                                        self.cardRemovalTransition = .leadingBottom
                                    }
                                    if drag.translation.width > self.dragAreaThreshold {
                                        self.cardRemovalTransition = .tralingBottom
                                    }
                                })
                                    .onEnded({ (value) in
                                        guard case .second(true, let drag?) = value else{
                                            return
                                        }
                                        if drag.translation.width < -self.dragAreaThreshold{
                                            print("trash: \(cardView.honeymonn.place)")
                                            UINotificationFeedbackGenerator().notificationOccurred(.warning)
                                        }
                                        if drag.translation.width > self.dragAreaThreshold {
                                            print("liked: \(cardView.honeymonn.place)")
                                            UINotificationFeedbackGenerator().notificationOccurred(.success)
                                        }
                                        
                                        
                                        if drag.translation.width < -self.dragAreaThreshold || drag.translation.width > self.dragAreaThreshold {
                                            playSound(sound: "sound-rise", type: "mp3")
                                            self.moveCards()
                                        }
                                    })
                        ).transition(self.cardRemovalTransition)
                }
            }
            //CardView(honeymonn: honeymoonData[2])
            // .padding()
            Spacer()
            
            //MARK: Footer
            FooterView(showBookingAlert: $showAlert)
                .opacity(dragState.isDragging ? 0.0:1.0)
                .animation(.default, value: showInfo)
        }
        .alert(isPresented: $showAlert) {
            Alert(title: Text("SUCCESS"),
                  message: Text("Wishing a lovely and most precius of the times together for the amazing couple"),
                  dismissButton: .default(
                    Text("Happy Honeymoon!")
                  ))
        }
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
