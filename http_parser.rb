class HttpParser
  def initialize(response)
    @response = response
  end

  def status_code
    lines[0].split(" ")[1].to_i
  end

  def headers
    headers = {}
    lines[1...first_empty_line_index].each do |header|
      key, value = header.split(": ")
      headers[key] = value
    end

    headers
  end

  def body
    body_start = first_empty_line_index + 1
    lines[body_start..-1].join("\n")
  end

  private
  def first_empty_line_index
    lines.find_index("")
  end

  def lines
    @response.split("\n")
  end
end