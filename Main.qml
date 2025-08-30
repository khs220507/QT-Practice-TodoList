import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

Window {
    id: win
        width: 400
        height: 600
        visible: true
        color: "#1e1e1e"
        title: "QT Quick TodoList"

        // ✅ 모델 꼭 선언!
        ListModel { id: todoModel }

        // ===== 네비 영역 =====
            Rectangle {
                id: navBar
                height: 48
                color: "#1e1e1e"
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.top: parent.top
                border.color: "#333"

                // 타이틀
                Text {
                    text: "할 일 목록"
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.left: parent.left
                    anchors.leftMargin: 12
                    font.pixelSize: 18
                    font.bold: true
                    color: "#ffffff"
                }

                // 전체삭제 버튼
                Button {
                            id: clearAllBtn
                            text: "전체삭제"
                            anchors.verticalCenter: parent.verticalCenter
                            anchors.right: parent.right
                            anchors.rightMargin: 12
                            enabled: todoModel.count > 0
                            background: Rectangle {
                                radius: 6
                                color: clearAllBtn.enabled ? "#333333" : "#222222"
                                border.color: "#555"
                            }
                            contentItem: Text {
                                text: clearAllBtn.text
                                color: clearAllBtn.enabled ? "#ffffff" : "#777777"
                                anchors.centerIn: parentd
                            }
                            onClicked: todoModel.clear()
                        }
            }

            // ===== 입력 영역 =====
            Rectangle {
                id: inputArea
                height: 44
                color: "#1e1e1e"
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.top: navBar.bottom
                anchors.margins: 12

                // 입력 Row (폭에 따라 반응형 너비 조정)
                Row {
                    id: inputRow
                    spacing: 8
                    anchors.fill: parent


                    TextField {
                        id: input
                        placeholderText: "할 일 입력..."
                        placeholderTextColor: "#888888"   // 🔹 다크모드에서 어울리는 회색
                        color: "#E0E0E0"
                        width: parent.width - addBtn.implicitWidth - inputRow.spacing
                        height: 25
                        onAccepted: addBtn.enabled && addTodo()

                        background: Rectangle {
                            radius: 6
                            border.color: "#333333"; border.width: 1
                            color: "#121212"
                        }
                    }

                    Button {
                        id: addBtn
                        text: "추가"
                        enabled: input.text && input.text.trim().length > 0
                        background: Rectangle {
                            radius: 6
                            color: addBtn.down
                                     ? "#2E7D32"   // 클릭 시 진한 초록
                                     : (addBtn.hovered ? "#66BB6A" : "#4CAF50") // hover 시 밝은 초록
                            border.color: "#444444"
                            border.width: 1
                        }
                        contentItem: Text {
                            text: addBtn.text
                            color: "#ffffff"
                            anchors.centerIn: parent
                        }
                        onClicked: addTodo()
                    }

                }
            }

            // ===== 리스트 영역 =====
            ListView {
                id: listView
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.top: inputArea.bottom
                anchors.bottom: parent.bottom
                anchors.margins: 12
                spacing: 8
                clip: true
                model: todoModel



                delegate: Rectangle {
                    width: listView.width
                    height: 35
                    radius: 6
                    border.width: 1
                    border.color: "#333333"
                    color: "#2c2c2c"

                    Row {
                        anchors.fill: parent
                        anchors.margins: 6
                        spacing: 8


                        Text {
                            text: model.text
                            anchors.verticalCenter: parent.verticalCenter
                            elide: Text.ElideRight
                            width: parent.width - deleteBtn.implicitWidth - 20
                            color: "#E0E0E0"

                        }

                        Button {
                            id: deleteBtn
                            text: "삭제"
                            anchors.right: parent.right
                            anchors.verticalCenter: parent.verticalCenter
                            background: Rectangle {
                                radius: 6
                                color: deleteBtn.down
                                         ? "#C62828"   // 클릭 시 진한 빨강
                                         : (deleteBtn.hovered ? "#EF5350" : "#F44336") // hover 시 밝은 빨강
                                border.color: "#444444"
                                border.width: 1
                            }
                            contentItem: Text {
                                text: deleteBtn.text
                                color: "#ffffff"
                                anchors.centerIn: parent
                            }
                            onClicked: todoModel.remove(index)

                        }
                    }
                }
            }

            // ===== 공용 함수 =====
            function addTodo() {
                var t = input.text.trim()
                if (t.length > 0) {
                    todoModel.append({ "text": t })
                    input.text = ""
                }
            }
}

