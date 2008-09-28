#!/usr/bin/env ruby
#
# from http://errtheblog.com/posts/89-huba-huba
# Modified by Conor Hunt

puts "Backups of your current dotfiles will be placed in a .backups folder in your home directory"

current_dir = File.dirname(File.expand_path(__FILE__))
home_dir = File.expand_path('~')
backup_dir = File.join(home_dir, ".backups")

`mkdir #{backup_dir}` unless File.exists?(backup_dir)

# Link each of the dotfiles and back them up if they exist already
Dir['dotfiles/*'].each do |file|
  file_name = file.match(%r{/.*$})[0]
  target = File.join(home_dir, "#{file_name}")
  if File.exists?(target) and not File.exists?(File.join(backup_dir, file_name))
    puts "backing up #{target} to #{backup_dir}"
    File.move(target, backup_dir)
  end
  puts "symlinking #{file} to #{target}"
  File.symlink(file, target)
end

# Link the .ssh directory and back it up if it it exists already
old_ssh = File.join(home_dir, ".ssh")
new_ssh = File.join(current_dir,'dot_ssh')
if File.exists?(new_ssh) and File.exists?(old_ssh) and not File.exists?(File.join(backup_dir, ".ssh"))
  puts "backing up #{old_ssh} to #{backup_dir}/.ssh"
  File.move(old_ssh, "#{backup_dir}/.ssh")
end

`ln -s File.join(current_dir,'dot_ssh')}/ #{ssh_home}`
`chmod -R og-rw ~/.ssh/`
`ln -s #{File.join(current_dir,'Utils')}/ #{File.join(home_dir, 'Utils')}`
