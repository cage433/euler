# A generic Makefile that should handle a number of source files.
# 
# All it really does though is
#
#   nasm -f elf64 -g -F stabs foo.asm -o foo.o
#   gcc foo.o
#   ./a.out


task :default => [:run]
src_files = FileList['*.asm']

def obj_file(src_file)
  File.basename(src_file).sub(/\.asm/, ".o")
end

src_files.each do |file|
  obj = obj_file(file)
  file obj => [file] do
    sh "nasm -f elf64 -g -F stabs #{file} -o #{obj_file(file)}"
  end
end

obj_files = src_files .collect{|f| obj_file(f)}

file "main" => obj_files do
  obj = obj_files.join(" ")
  sh "gcc #{obj}"
end

task :run => ["main"] do
  system('./a.out')
end
  
