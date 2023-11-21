require 'tempfile'
require 'fileutils'

module Fastlane
	module Actions
		class ModifyFileAction < Action
			def self.run(params)
                file_path ||= params[:file_path]
                old_value = params[:old_value]
                new_value = params[:new_value]
                mode ||= params[:mode]

                UI.message(" Modifying file (#{file_path})!")
                modify(file_path, old_value, new_value, mode)
			end

			def self.modify(path, old_value, new_value, mode)
                if !File.file?(path)
                    raise "No file exist at path: (#{File.expand_path(path)})!"
                end

            	begin
                    temp_file = Tempfile.new('fastlaneModifyFile')
                    File.open(path, 'r') do |file|
                        file.each_line do |line|
                            if line.include? old_value
                                if mode == "replace"
                                    line.replace line.sub(old_value, new_value)
                                    temp_file.puts line
                                elsif mode == "append"
                                    temp_file.puts line
                                    temp_file.puts new_value
                                elsif mode == "prepend"
                                    temp_file.puts new_value
                                    temp_file.puts line
                                end
                            else
                                temp_file.puts line
                            end
                        end
                        file.close
                    end
                    temp_file.rewind
                    temp_file.close
                    FileUtils.mv(temp_file.path, path)
                    temp_file.unlink
	            rescue
		            raise 'Modifying file failed!'
	            end
            end

			def self.description
				"Modify file of your Android project."
			end

			def self.available_options
			[
                FastlaneCore::ConfigItem.new(key: :file_path,
											description: "The path to the file to be modified",
											optional: false,
                                            type: String),
				FastlaneCore::ConfigItem.new(key: :old_value,
											description: "The old value whose to be replaced, appended after or prepended before with new value",
											optional: false,
                                            type: String),
				FastlaneCore::ConfigItem.new(key: :new_value,
											description: "The new value",
											optional: false,
											type: String),
				FastlaneCore::ConfigItem.new(key: :mode,
											description: "The working mode. Possible values are replace, append or prepend (default: replace)",
											optional: true,
											type: String,
											default_value:"replace"),
            ]
			end

			def self.author
				"Nevis Security AG"
			end

			def self.is_supported?(platform)
				[:android].include? platform
			end

			def self.example_code
				[
					modify_file(
						file_path: file,
                        old_value: "<old_value>",
                        new_value: "<new_value>",
                        mode: "append"
					)
				]
			end

			def self.category
				:project
			end
		end
	end
end