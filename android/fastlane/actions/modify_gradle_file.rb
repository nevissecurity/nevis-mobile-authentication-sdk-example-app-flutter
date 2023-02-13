require 'tempfile'
require 'fileutils'

module Fastlane
	module Actions
		class ModifyGradleFileAction < Action
			def self.run(params)
                gradle_file_path ||= params[:gradle_file_path]
                constant = params[:constant]
                value = params[:value]
                mode ||= params[:mode]

                if gradle_file_path != nil
                    UI.message(" Using gradle file (#{gradle_file_path})!")
                    modify(gradle_file_path, constant, value, mode)
                else
                    app_folder_name ||= params[:app_folder_name]
                    UI.message("Using project folder `#{app_folder_name}`!")

                    Dir.glob("**/#{app_folder_name}/build.gradle") do |path|
                        modify(path, constant, value, mode)
                    end
                end
			end

			def self.modify(path, constant_name, constant_value, mode)
                if !File.file?(path)
                    raise "No file exist at path: (#{path})!"
                end

            	begin
                    temp_file = Tempfile.new('fastlaneModifyGradleFile')
                    File.open(path, 'r') do |file|
                        file.each_line do |line|
                            if line.include? constant_name
                                if mode == "replace"
                                    components = line.strip.split(' ')
                                    current_value = components[components.length-1].tr("\"","")
                                    line.replace line.sub(current_value, constant_value)
                                    temp_file.puts line
                                elsif mode == "append"
                                    temp_file.puts line
                                    temp_file.puts constant_value
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
		            raise 'Modifying gradle file failed!'
	            end
            end

			def self.description
				"Modify gradle file of your Android project."
			end

			def self.available_options
			[
                FastlaneCore::ConfigItem.new(key: :app_folder_name,
											description: "The name of the application source folder in the Android project (default: app)",
											optional: true,
											type: String,
											default_value:"app"),
                FastlaneCore::ConfigItem.new(key: :gradle_file_path,
											description: "The relative path to the gradle file containing the constant parameter (default:app/build.gradle)",
											optional: true,
                                            type: String,
                                            default_value: nil),
				FastlaneCore::ConfigItem.new(key: :constant,
											description: "The constant whose value is to be replaced or appended after",
											optional: false,
                                            type: String),
				FastlaneCore::ConfigItem.new(key: :value,
											description: "The new value",
											optional: false,
											type: String),
				FastlaneCore::ConfigItem.new(key: :mode,
											description: "The working mode. Possible values are replace or append (default: replace)",
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
					modify_gradle_file(
						gradle_file_path: file,
                        constant: "<constant>",
                        value: "<value>",
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