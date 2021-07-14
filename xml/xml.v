module xml

import os
import strings.textscanner as sscan

struct Prolog {
mut:
	prolog_keys   []string
	prolog_values []string
}

fn (p Prolog) get_version() ?string {
	for i, s in p.prolog_keys {
		if s == 'version' {
			return p.prolog_values[i]
		}
	}
	return none
}

struct Data {
	Prolog
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

fn parse_open_tag(mut scanner sscan.TextScanner, mut xml_data Data) {
	char := rune(scanner.next())
	if char == `?` {
		parse_prolog(mut scanner, mut xml_data)
	}
	if char == `>` {
		return
	}
}

fn parse_prolog(mut scanner sscan.TextScanner, mut xml_data Data) {
	for {
		char := rune(scanner.next())
		if char == `?` {
			break
		}
		if byte(char).is_letter() {
			xml_data.prolog_keys << parse_word(scanner)
			xml_data.prolog_values << parse_string(scanner)
		}
	}
}

fn parse_word(scanner &sscan.TextScanner) string {
	mut str := ''
	for {
		char := rune(scanner.next())
		if char == ` ` || char == `=` {
			return str
		} else {
			str << char
		}
	}
}

fn parse_string(scanner &sscan.TextScanner) string {
	return ''
}
