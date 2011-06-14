def error(text) STDERR.puts "!  #{text}" end
def info(text, prefix="*") STDOUT.puts "#{prefix}  #{text}" end
def info_cmd(text) info(text, ">") end
def info_rm(text) info(text, "x") end

desc "Install dotfiles."
task :default => :install do
end

desc "Install dotfiles."
task :install do

  for file in Dir['configs/*'] + Dir['bash_profile']
    source      = File.join(Dir.pwd, file)
    basename    = File.basename(source)
    destination = File.expand_path("~/.#{basename}")
    
    # Create symlink
    if File.symlink?(destination)
      symlink_to = File.readlink(destination)
      info_rm "Removing symlink #{destination} --> #{symlink_to}" if symlink_to != source
      FileUtils.rm(destination)
    elsif File.exist?(destination)
      error "#{destination} exists. Will not automatically overwrite a non-symlink. Overwrite (default: yes)?"
      print "? "
      if STDIN.gets.match(/^n/i)
        next
      else
        info_rm "Removing #{destination}."
        FileUtils.rm_rf(destination)
      end
    end
    
    # Cutomize
    contents = File.read(source) rescue ""
    if contents.include?('<.replace ')
      info "#{source} has <.replace> placeholders."
      contents.gsub!(/<\.replace (.+?)>/) {
        begin
          File.read(File.expand_path("~/.#{$1}"))
        rescue => e
          error "Could not replace `#{$&}`: #{e.message}"
          ""
        end
      }
      File.open(destination, 'w') {|f| f.write contents }
      info_cmd "wrote file #{destination}"
    else
      FileUtils.ln_s(source, destination)
      info_cmd "ln -s #{source} #{destination}"
    end
  end

  system 'source ~/.bash_profile'
end
