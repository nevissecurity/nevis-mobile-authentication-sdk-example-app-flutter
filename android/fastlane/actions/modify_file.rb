require "tempfile"
require "fileutils"

module Fastlane
	module Actions
		##
		# This class provides an action to modify a file by replacing, appending, or prepending content.
		#
		# See {ModifyFileAction.available_options available options} for supported parameters.
		class ModifyFileAction < Action
			##
			# Main entry point for this Fastlane action.
			#
			# @param params [FastlaneCore::Configuration] Parameters for the action.
			# @return [void]
			def self.run(params)
				file_path ||= params[:file_path]
				old_value = params[:old_value]
				new_value = params[:new_value]
				mode ||= params[:mode]

				UI.message(" Modifying file (#{file_path})!")
				modify(file_path, old_value, new_value, mode)
			end

			##
			# Modifies a text file in-place by applying an operation ("replace", "append", or "prepend")
			# on every line that contains `old_value`.
			#
			# The method streams the original file line-by-line into a temporary file, then
			# replaces the original file with the temporary one.
			#
			# @param path [String] Path to the file to modify.
			# @param old_value [String] Substring to look for in each line. The operation is applied
			#   only to lines that include this value.
			# @param new_value [String] Replacement text (for "replace") or the text to insert
			#   (for "append"/"prepend").
			# @param mode [String] Operation mode:
			#   - `replace`: Replaces the first occurrence of `old_value` in the matching line with `new_value`.
			#   - `append`: Writes the original matching line, then writes `new_value` as a new line after it.
			#   - `prepend`: Writes `new_value` as a new line before the original matching line.
			# @return [void]
			def self.modify(path, old_value, new_value, mode)
				raise "No file exist at path: (#{File.expand_path(path)})!" unless File.file?(path)

				begin
					temp_file = Tempfile.new("fastlaneModifyFile")
					File.open(path, "r") do |file|
						file.each_line do |line|
							if line.include? old_value
								case mode
								when "replace"
									line.replace line.sub(old_value, new_value)
									temp_file.puts line
								when "append"
									temp_file.puts line
									temp_file.puts new_value
								when "prepend"
									temp_file.puts new_value
									temp_file.puts line
								else
									raise "Invalid mode: #{mode}! Possible values are replace, append or prepend."
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
					raise "Modifying file failed!"
				end
			end
			private_class_method :modify

			def self.description
				"Modify file of your Android project."
			end

			def self.available_options
				[
					FastlaneCore::ConfigItem.new(
						key: :file_path,
						description: "The path to the file to be modified",
						optional: false,
						type: String
					),
					FastlaneCore::ConfigItem.new(
						key: :old_value,
						description: "The old value whose to be replaced, appended after or prepended before with new value",
						optional: false,
						type: String
					),
					FastlaneCore::ConfigItem.new(
						key: :new_value,
						description: "The new value",
						optional: false,
						type: String
					),
					FastlaneCore::ConfigItem.new(
						key: :mode,
						description: "The working mode. Possible values are replace, append or prepend (default: replace)",
						optional: true,
						type: String,
						default_value: "replace"
					)
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
