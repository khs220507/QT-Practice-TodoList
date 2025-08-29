import QtQuick
import QtQuick.Controls

Window {
    id: win
        width: 480
        height: 360
        visible: true
        title: "Todo - Step 1"

        // ✅ 모델 꼭 선언!
        ListModel { id: todoModel }

        // 공용 함수로 분리 (버튼/엔터 어디서든 호출)
        function addTodo() {
            const t = input.text ? input.text.trim() : ""
            if (!t) return
            todoModel.append({ text: t })
            input.text = ""
            console.log("added:", t)   // 콘솔 확인용
        }

        Column {
            anchors.fill: parent
            anchors.margins: 12
            spacing: 8

            Row {
                spacing: 8
                width: parent.width

                TextField {
                    id: input
                    placeholderText: "할 일 입력..."
                    width: parent.width - addBtn.implicitWidth - 8
                    onAccepted: win.addTodo()   // ✅ 엔터로 추가
                }

                Button {
                    id: addBtn
                    text: "추가"
                    enabled: input.text && input.text.trim().length > 0
                    onClicked: win.addTodo()    // ✅ 클릭으로 추가
                }
            }

            ListView {
                id: listView
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.bottom: parent.bottom
                anchors.top: parent.top        // ✅ 확실히 영역 잡기
                anchors.topMargin: 60          // 입력줄 높이만큼 띄우기(대략)
                model: todoModel
                spacing: 6
                clip: true

                delegate: Rectangle {
                    width: listView.width
                    height: 36
                    radius: 6
                    border.width: 1
                    border.color: "#ddd"
                    color: "white"

                    Text {
                        anchors.centerIn: parent
                        text: model.text
                    }
                }
            }
        }
}

