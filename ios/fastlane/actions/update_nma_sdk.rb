require "xcodeproj"

module Fastlane
	module Actions
		##
		# Fastlane action that updates the Nevis Mobile Authentication SDK iOS Swift Package
		# reference in an Xcode project.
		#
		# See {UpdateNmaSdkAction.available_options available options} for supported parameters.
		class UpdateNmaSdkAction < Action
			# Identifier fragment of NMA iOS SPM package name.
			NMA_IOS_PACKAGE_IDENTIFIER = "nevis-mobile-authentication-sdk-ios-package".freeze

			##
			# Main entry point for this Fastlane action.
			#
			# @param params [FastlaneCore::Configuration] Parameters for the action.
			# @return [void]
			def self.run(params)
				project = params[:project]
				repository_url = params[:repository_url]
				version = params[:version]

				proj = Xcodeproj::Project.open(project.to_s)

				changed = false
				nma_package_refs(proj).each do |ref|
					changed |= update_repository_url?(ref, repository_url)
					changed |= update_requirement?(ref, version)
				end

				proj.save if changed
			end

			##
			# Returns all remote Swift package references in the given Xcode project that belong
			# to the Nevis Mobile Authentication SDK package.
			#
			# @param proj [Xcodeproj::Project] Open Xcode project instance.
			# @return [Array<Object>] Matching `XCRemoteSwiftPackageReference` objects.
			def self.nma_package_refs(proj)
				proj.objects
					.select { |o| o.isa == "XCRemoteSwiftPackageReference" }
					.select { |ref| ref.respond_to?(:repositoryURL) }
					.select { |ref| ref.repositoryURL&.include?(NMA_IOS_PACKAGE_IDENTIFIER) }
			end
			private_class_method :nma_package_refs

			##
			# Updates the `repositoryURL` of a Swift package reference if it differs from the desired value.
			#
			# @param ref [Object] A `XCRemoteSwiftPackageReference` from the Xcode project.
			# @param repository_url [String] Desired package repository URL.
			# @return [Boolean] `true` if the reference was modified, `false` otherwise.
			def self.update_repository_url?(ref, repository_url)
				return false if ref.repositoryURL == repository_url

				ref.repositoryURL = repository_url
				true
			end
			private_class_method :update_repository_url?

			##
			# Updates the SPM requirement of a Swift package reference to an exact version pin.
			#
			# @param ref [Object] A `XCRemoteSwiftPackageReference` from the Xcode project.
			# @param version [String] Version to pin as an exact version requirement.
			# @return [Boolean] `true` if the reference was modified, `false` otherwise.
			def self.update_requirement?(ref, version)
				desired_req = desired_requirement_hash(ref, version)
				return false if ref.requirement == desired_req

				ref.requirement = desired_req
				true
			end
			private_class_method :update_requirement?

			##
			# Builds the normalized Swift package requirement hash for an exact-version pin.
			#
			# @param ref [Object] A `XCRemoteSwiftPackageReference` from the Xcode project.
			# @param version [String] Version to pin as an exact version requirement.
			# @return [Hash] Requirement hash to assign to `ref.requirement`.
			def self.desired_requirement_hash(ref, version)
				req = ref.requirement || {}
				req = req.to_hash if req.respond_to?(:to_hash)

				desired_req = req.dup
				desired_req["kind"] = "exactVersion"
				desired_req.delete("version")
				desired_req.delete("minimumVersion")
				desired_req.delete("maximumVersion")
				desired_req["version"] = version
				desired_req
			end
			private_class_method :desired_requirement_hash

			def self.description
				"Updates the version of Nevis Mobile Authentication SDK."
			end

			def self.available_options
				[
					FastlaneCore::ConfigItem.new(
						key: :project,
						description: "The path to the Xcode project file to be modified",
						optional: false,
						verify_block: proc do |value|
							UI.user_error!("Xcode project not found at path '#{value}'") unless File.exist?(value)
						end
					),
					FastlaneCore::ConfigItem.new(
						key: :repository_url,
						description: "The repository URL of the Nevis Mobile Authentication SDK SPM package",
						optional: false,
						type: String
					),
					FastlaneCore::ConfigItem.new(
						key: :version,
						description: "The version of the Nevis Mobile Authentication SDK to be set",
						optional: false,
						type: String
					)
				]
			end

			def self.author
				"Nevis Security AG"
			end

			def self.is_supported?(platform)
				[:ios].include? platform
			end

			def self.example_code
				[
					update_nma_sdk(
						project: "<project_path>",
						repository_url: "<repository_url>",
						version: "<version>"
					)
				]
			end

			def self.category
				:project
			end
		end
	end
end
