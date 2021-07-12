module main

import xml

fn main() {
   file := './test.xml'
   xml.parse_file_path(file) or {panic('FAIL')}
	println('hello')
}
