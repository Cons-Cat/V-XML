module xml

import os
import strings.textscanner as sscan

struct Data {
mut:
	tree [][]string
}

pub fn parse_file_path(path string) ?Data {
	file := os.open(path) or { return none }
	file_size := os.file_size(path)
	text, _ := os.fd_read(file.fd, int(file_size))
	return parse_xml(text)
}

fn parse_xml(data string) Data {
	mut scanner := sscan.new(data)
	mut xml_data := Data{}
	for scanner.remaining() > 0 {
		char := rune(scanner.next())
		if char == `\n` {
			continue
		}
		if char == `<` {
			println(`<`)
			continue
		}
		if char == `>` {
			println(`>`)
			continue
		}
		println(char)
	}
	return xml_data
}
