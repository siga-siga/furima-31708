# Furima-31708 DB設計図

## Usersテーブル

| Column         | Type   | Option      |
| -------------- | ------ | ----------- |
| nickname       | string | null: false |
| email          | string | null: false |
| lastName       | string | null: false |
| firstName      | string | null: false |
| lastName_kana  | string | null: false |
| firstName_kana | string | null: false |
| birthday       | date   | null: false |

Association
has_many :items
has_many :purchases

## Itemsテーブル 

| Column            | Type      | Option                         |
| ----------------- | ------    | ------------------------------ |
| name              | string    | null: false                    |
| content           | string    | null: false                    |
| category_id       | string    | null: false                    |
| status_id         | string    | null: false                    |
| shippingPayer_id | string    | null: false                    |
| area_id           | string    | null: false                    |
| deliveryDays_id  | string    | null: false                    |
| price             | date      | null: false                    |
| user              |references | null: false, foreign_key: true |

Association
belongs_to :user
has_one :purchase

## Purchasesテーブル

| Column | Type      | Option                         |
| ------ | --------- | ------------------------------ |
| item   |references | null: false, foreign_key: true |
| user   |references | null: false, foreign_key: true |

Association
belongs_to :user
belongs_to :item
has_one :address

## Addressesテーブル

| Column           | Type      | Option                         |
| ---------------- | ------    | ------------------------------ |
| postalCode      | string    | null: false                    |
| prefectures_id   | integer   | null: false                    |
| city             | string    | null: false                    |
| block            | string    | null: false                    |
| building         | string    |                                |
| phone            | string    | null: false                    |
| purchase         |references | null: false, foreign_key: true |

Association
belongs_to :purchase
