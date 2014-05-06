require_relative '../http_parser'

describe HttpParser do
  before do
    input = <<-INPUT
HTTP/1.1 200 OK
Content-Type: text/html
Transfer-Encoding: chunked

<!DOCTYPE html>
<html lang="en">
<head><meta charset="utf-8" />
  <meta name="description" content="should i test private methods?" />
  <meta name="keywords" content="test,private,methods,oo,object,oriented,tdd" />
  <title>Should I Test Private Methods?</title>
</head>
<body>
  <div style='font-size: 96px; font-weight: bold; text-align: center; padding-top: 200px; font-family: Verdana, Helvetica, sans-serif'>NO</div>
  <!-- Every time you consider testing a private method, your code is telling you that you haven't allocated responsibilities well.  Are you listening to it? -->
</body>
</html>
INPUT

    @parser = HttpParser.new(input)
  end

  it 'can return status code' do
    expect(@parser.status_code).to eq 200
  end

  it 'can return headers' do
    expected_headers = {
        "Content-Type" => "text/html",
        "Transfer-Encoding" => "chunked"
    }

    expect(@parser.headers).to eq expected_headers
  end

  it 'can return a body' do
    expected_body = <<-BODY
<!DOCTYPE html>
<html lang="en">
<head><meta charset="utf-8" />
  <meta name="description" content="should i test private methods?" />
  <meta name="keywords" content="test,private,methods,oo,object,oriented,tdd" />
  <title>Should I Test Private Methods?</title>
</head>
<body>
  <div style='font-size: 96px; font-weight: bold; text-align: center; padding-top: 200px; font-family: Verdana, Helvetica, sans-serif'>NO</div>
  <!-- Every time you consider testing a private method, your code is telling you that you haven't allocated responsibilities well.  Are you listening to it? -->
</body>
</html>
BODY
    expect(@parser.body).to eq expected_body.strip
  end
end
