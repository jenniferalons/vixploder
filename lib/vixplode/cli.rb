require 'rubygems'
require 'optparse'
require 'ftools'

module Vixplode
  class CLI
    def self.execute(stdout, arguments=[])
      options = {
        :path     => '~'
      }
      mandatory_options = %w(  )

      parser = OptionParser.new do |opts|
        opts.banner = <<-BANNER.gsub(/^          /,'')
          This application is wonderful because...

          Usage: #{File.basename($0)} [options]

          Options are:
        BANNER
        opts.separator ""
        opts.on("-p", "--path=PATH", String,
                "This is a sample message.",
                "For multiple lines, add more strings.",
                "Default: ~") { |arg| options[:path] = arg }
        opts.on("-h", "--help",
                "Show this help message.") { stdout.puts opts; exit }
        opts.parse!(arguments)

        if mandatory_options && mandatory_options.find { |option| options[option.to_sym].nil? }
          stdout.puts opts; exit
        end
      end

      source_dir = File.expand_path(File.dirname(__FILE__) + "/../dotfiles")
      destination_dir = File.expand_path("~")
      backup_directory = File.expand_path("~/vixploder_backup/")
      path = options[:path]

      puts "Backing up current settings in case a restore is necessary..."
      if File.exists?(backup_directory)
        msg= "Directory #{backup_directory} already exists! Please move it and issue this command again."
        #raise ArgumentError, msg
      else
        Dir.mkdir(backup_directory) unless File.exists?(backup_directory)
      end

      # copy current .vimrc file to ~/vixploder_vim_backups
      files_to_backup = [
                          "~/.aliases",
                          "~/.bashrc",
                          "~/.gitconfig",
                          "~/.gitignore",
                          "~/.gvimrc",
                          "~/.screenrc",
                          "~/.tmux.conf",
                          "~/.vim",
                          "~/.vimrc"
                        ]
      files_to_backup.each do |file|
        file_to_backup = File.expand_path(file)
        puts "Attempting to back up '#{file_to_backup}' to '#{backup_directory}'"
        if File.exists?(file_to_backup)
          if File.symlink?(file_to_backup)
            File.safe_unlink(file_to_backup) if File.symlink?(file_to_backup)
          else
            File.move file_to_backup, backup_directory, true
          end
          puts "Move of '#{file_to_backup}' to '#{backup_directory}' complete"
        else
          puts "No '#{file}' to back up."
        end
      end

      # symlink to included files
      Dir.open(source_dir).each do |f|
        next if f == ".." || f == "."
        File.safe_unlink("#{destination_dir}/.#{f}") if File.symlink?("#{destination_dir}/.#{f}")
        File.symlink("#{source_dir}/#{f}", "#{destination_dir}/.#{f}")
      end
    end
  end
end
