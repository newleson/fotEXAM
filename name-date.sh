#!/bin/bash

PHONEBOOK="phonebook.txt"

declare -A AREA_CODES
AREA_CODES=(
    ["02"]="서울"
    ["031"]="경기"
    ["032"]="인천"
    ["051"]="부산"
    ["053"]="대구"
)

is_valid_phone_number() {
    [[ "$1" =~ ^[0-9]{2,3}-[0-9]{3,4}-[0-9]{4}$ ]]
}

if [ $# -ne 2 ]; then
    echo "사용법: $0 이름 전화번호"
    exit 1
fi

NAME="$1"
PHONE="$2"

if ! is_valid_phone_number "$PHONE"; then
    echo "잘못된 전화번호 형식입니다. 전화번호는 하이픈(-)으로 연결된 숫자여야 합니다."
    exit 1
fi

AREA_CODE=${PHONE%%-*}
AREA=${AREA_CODES[$AREA_CODE]}

if [ -z "$AREA" ]; then
    echo "알 수 없는 지역번호입니다."
    exit 1
fi

if grep -q "^$NAME " "$PHONEBOOK"; then
    CURRENT_PHONE=$(grep "^$NAME " "$PHONEBOOK" | cut -d' ' -f2)
    if [ "$CURRENT_PHONE" == "$PHONE" ]; then
        echo "입력된 전화번호가 이미 존재합니다."
        exit 0
    else
        echo "새로운 전화번호로 업데이트합니다."
        sed -i "/^$NAME /d" "$PHONEBOOK"
    fi
fi

echo "$NAME $PHONE $AREA" >> "$PHONEBOOK"

sort -o "$PHONEBOOK" "$PHONEBOOK"

echo "전화번호부가 업데이트되었습니다."
