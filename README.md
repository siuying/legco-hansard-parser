# Legco Hansard Parser

Convert Legco hansard document PDF into texts, and then convert them into structured data.

## Features

- List available Legco hansard documents (agenda, minutes, voting, hansard and floor hansard)
- Convert hansard PDF into TXT
- Convert hansard TXT into JSON
  - Extract meta data (date, present members, absent members, officials and clerks) from TXT
  - TODO: Extract speech data
  - TODO: Extract voting data
  - ... etc

## Usage

### List available hansard documents

```ruby
rake download:list
```

File ``data/hansard_list.json`` will be created.

### Download hansard PDF

```ruby
rake download:handsard
```

PDFs will be downloaded to ``data/pdf``

### Convert hansard PDF into text

```ruby
rake convert:txt
```

PDFs at ``data/pdf`` will be converted to txt at ``data/txt``

### Convert hansard text into JSON

```ruby
rake convert:json
```

TXTs at ``data/txt`` will be converted to JSON at ``data/json``

Sample JSON format:

```javascript
{
  "present_members": [
    "曾鈺成",
    "何俊仁",
    "李卓人",
    "涂謹申",
    "陳鑑林",
    "梁耀忠",
    "劉慧卿",
    "譚耀宗",
    "石禮謙",
    "馮檢基",
    "方剛",
    "王國興",
    "李國麟",
    "林健鋒",
    "梁君彥",
    "黃定光",
    "湯家驊",
    "何秀蘭",
    "李慧琼",
    "林大輝",
    "陳克勤",
    "陳健波",
    "梁美芬",
    "梁家騮",
    "張國柱",
    "黃國健",
    "葉國謙",
    "葉劉淑儀",
    "謝偉俊",
    "梁家傑",
    "梁國雄",
    "陳偉業",
    "黃毓民",
    "毛孟靜",
    "田北辰",
    "吳亮星",
    "何俊賢",
    "易志明",
    "胡志偉",
    "姚思榮",
    "范國威",
    "馬逢國",
    "莫乃光",
    "陳志全",
    "陳恒鑌",
    "陳家洛",
    "陳婉嫻",
    "梁志祥",
    "梁繼昌",
    "麥美娟",
    "郭家麒",
    "郭偉強",
    "郭榮鏗",
    "張華峰",
    "張超雄",
    "單仲偕",
    "黃碧雲",
    "葉建源",
    "葛珮帆",
    "廖長江",
    "潘兆平",
    "鄧家彪",
    "蔣麗芸",
    "盧偉國",
    "鍾國斌",
    "鍾樹根",
    "謝偉銓"
  ],
  "absent_members": [
    "劉皇發",
    "張宇人",
    "田北俊"
  ],
  "officers": [
    "袁國強",
    "陳家強"
  ],
  "clerks": [
    "戴燕萍",
    "梁慶儀",
    "馬朱雪履"
  ],
  "date": "2013-01-10T09:00:00+00:00"
}
```