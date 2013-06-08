# Legco Hansard Parser

Convert Legco hansard document PDF into texts, and then convert them into structured data.

## Features

- List available Legco hansard documents (agenda, minutes, voting, hansard and floor hansard)
- Convert hansard PDF into TXT
- Convert hansard TXT into JSON
  - Extract meta data (date, present members, absent members, officials and clerks) from TXT
  - Extract speech and actions data
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
rake download:hansard
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
  "events": [
    {
      "type": "speech",
      "speaker": {
        "full": "主席",
        "name": null,
        "title": "主席"
      },
      "text": "秘書，請響鐘傳召議員進入會議廳。",
      "supplement": null
    },
    {
      "type": "action",
      "text": "在傳召鐘響後，多位議員進入會議廳"
    },
    {
      "type": "speech",
      "speaker": {
        "full": "主席",
        "name": null,
        "title": "主席"
      },
      "text": "",
      "supplement": "提交文件\n\n下列文件是根據《議事規則》第21(2)條的規定提交：\n\n附屬法例／文書 法律公告編號\n\n《 2012年電訊 (電訊器具 )(豁免領牌 )(修訂 )令》 .... 190/2012\n\n《〈 2012年陪審員津貼 (修訂 )令〉 (生效日期 )\n公告》 ....................................................\n\n191/2012\n\n《〈 2012年刑事訴訟程序 (證人津貼 )(修訂 )規則〉\n(生效日期 )公告》 ....................................\n\n192/2012\n\n《〈 2012年死因裁判官 (證人津貼 )(修訂 )規則〉\n(生效日期 )公告》 ....................................\n\n193/2012\n\n《 2013年圖書館指定 (修訂 )令》 ........................... 1/2013\n\n\n其他文件\n\n第 57號 ― 政府飛行服務隊總監擬備截至二零一二年三月\n三十一日為止年度內的政府飛行服務隊福利基金\n管理報告\n\n第 58號 ― 農產品獎學基金\n二零一一年四月一日起至二零一二年三月三十一\n日止的報告\n\n第 59號 ― 香港學術及職業資歷評審局\n2011-12年報\n議員質詢的口頭答覆"
    }
  ]
  "date": "2013-01-10T09:00:00+00:00"
}
```