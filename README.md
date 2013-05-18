# Legco Hansard Parser

Convert Legco hansard document PDF into texts, and then convert them into structured data.

## Features

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
rake convert:handsard
```

PDFs at ``data/pdf`` will be converted to txt at ``data/txt``