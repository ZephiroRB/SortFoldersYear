# Sorting Folders (Downloads)
# Organizar tus Folders rapidamente.
# Desarrollado por Carlos Montalvo (zetanova.com) 2016

require 'fileutils'
require 'time'

excludes_files = [
  /sorting.rb/i,
  /^[12][0-9]{3}$/i,
  /\$/i
]

re = Regexp.union(excludes_files)

my_files = Dir["*"].sort_by { |a| File.stat(a).ctime }

my_files.reverse.each do |filename|

  next if filename.match(re)

  ctime = File.stat(filename).ctime

  structure_folders = "#{ctime.strftime("%Y")}/#{ctime.strftime("%m")}/#{ctime.strftime("%d")}"

  unless ctime.strftime("%Y-%m-%d") == Time.now.strftime("%Y-%m-%d")
    FileUtils::mkdir_p "#{structure_folders}" unless File.directory?("#{structure_folders}")

    FileUtils.mv(filename, "#{structure_folders}/")
  end
  
  puts "#{filename}"
end