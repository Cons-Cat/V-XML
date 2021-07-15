module main

import xml

fn main() {
   file := './test.xml'
   data := xml.parse_file_path(file) or {panic('FAIL')}
   println(data)
}
