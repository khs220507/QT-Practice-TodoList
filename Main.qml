import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick.Controls.Material

Window {
    id: win
       width: 800
       height: 600
       visible: true
       title: "TCP TodoList"
       Material.theme: Material.Dark
       Material.accent: Material.Blue
       color: "#141414"

       RowLayout {
           anchors.fill: parent
           spacing: 5


           // ===== 왼쪽: TCP + To-Do =====
           ColumnLayout {
               Layout.topMargin: 5
               Layout.bottomMargin: 5
               Layout.leftMargin: 5
               Layout.rightMargin: 0
               spacing: 5

               // --- TCP 영역 ---
               GroupBox {
                   title: "TCP 영역"
                   Layout.fillWidth: true
                   Layout.preferredHeight: 150
                   Layout.minimumHeight: 100

                   background: Rectangle {
                       radius: 5
                       color: "#222222"
                       border.color: "#555555"   // 초록 테두리
                       border.width: 0.5
                   }

                   Button {
                          id: toggleBtn
                          anchors.centerIn: parent
                          checkable: true   // 버튼을 토글형으로 만듦
                          text: checked ? "해제" : "연결"


                          onClicked: {
                              if (checked) {
                                  console.log("서버 연결 시도")
                                  // client.connectTo("127.0.0.1", 12345)  // 실제 연결 코드 (C++ 바인딩)
                              } else {
                                  console.log("서버 해제 시도")
                                  // client.disconnectFromServer()
                              }
                          }
                      }


               }

               // --- 할일(To-Do) 영역 ---
               GroupBox {
                   title: "할 일 영역"
                   Layout.fillWidth: true
                   Layout.fillHeight: true

                   background: Rectangle {
                       radius: 5
                       color: "#222222"
                       border.color: "#555555"   // 파란 테두리
                       border.width: 0.5
                       anchors.fill: parent

                   }

                   ColumnLayout{
                       anchors.fill: parent

                       RowLayout {
                           id: todoInputRow
                                       Layout.fillWidth: true
                                       Layout.fillHeight: false
                                               TextField {
                                                   id: inputField
                                                   placeholderText: "할 일을 입력하세요..."
                                                   Layout.fillWidth: true
                                                   onAccepted: addBtn.clicked()

                                               }

                                               Button {
                                                   id: addBtn
                                                   text: "추가"
                                                   enabled: inputField.text.trim().length > 0
                                                                           onClicked: {
                                                                               if (inputField.text.trim().length > 0) {
                                                                                   todoModel.append({ text: inputField.text.trim() })
                                                                                   inputField.text = ""
                                                                               }
                                                                           }
                                               }


                       }
                       ListView {
                                   id: listView
                                   Layout.fillWidth: true
                                   Layout.fillHeight: true        // ← 중요: 아래 공간 다 먹음
                                   spacing: 6
                                   clip: true
                                   model: ListModel { id: todoModel }

                                   delegate: Rectangle {
                                       width: listView.width
                                       height: 40
                                       radius: 6
                                       color: "#2a2d34"
                                       border.color: "#3a3f47"
                                       border.width: 1

                                       RowLayout {
                                           anchors.fill: parent
                                           anchors.margins: 8
                                           spacing: 8
                                           Text {
                                               text: model.text
                                               color: "#e6e6e6"
                                               Layout.fillWidth: true
                                               elide: Text.ElideRight
                                           }
                                           Button {
                                               id: delBtn
                                               text: "삭제"
                                               onClicked: todoModel.remove(index)
                                           }
                                       }
                                   }
                               }
                   }




               }
           }

           ColumnLayout {
               Layout.topMargin: 5
               Layout.bottomMargin: 5
               Layout.leftMargin: 0
               Layout.rightMargin: 5


               GroupBox {
                   title: "로그 영역"
                   Layout.fillWidth: true
                   Layout.fillHeight: true
                   background: Rectangle {
                       radius: 5
                       color: "#222222"
                       border.color: "#555555"   // 초록 테두리
                       border.width: 0.5
                   }

               }


           }


       }
}
